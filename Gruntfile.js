/*jslint node: true */
var fs = require('fs');
var path = require('path');
module.exports = function (grunt) {
    'use strict';
    grunt.initConfig(
        {
            jslint: {
                Gruntfile: {
                    src: ['Gruntfile.js']
                }
            },
            jsonlint: {
                manifests: {
                    src: '*.json',
                    options: {
                        format: true
                    }
                }
            },
            fixpack: {
                package: {
                    src: 'package.json'
                }
            },
            docker_io: {
                build: {
                    options: {
                        dockerFileLocation: '.',
                        buildName: 'termux',
                        tag: 'latest',
                        username: 'rudloff',
                        push: true
                    }
                }
            },
            download: {
                android: {
                    src: [
                        'https://dl.google.com/android/repository/sys-img/android/x86_64-24_r07.zip',
                        'https://termux.net/bootstrap/bootstrap-x86_64.zip'
                    ],
                    dest: 'tmp/'
                }
            },
            mkdir: {
                system: {
                    options: {
                        create: ['tmp/system-readonly/']
                    }
                }
            },
            shell: {
                guestmount: {
                    command: 'guestmount -a tmp/android/x86_64/system.img -m /dev/sda tmp/system-readonly/'
                },
                guestunmount: {
                    command: 'guestunmount tmp/system-readonly/'
                },
                //We use the shell because grunt-zip has a memory issue: https://github.com/twolfson/grunt-zip/issues/18
                unzip: {
                    command: 'unzip -o tmp/x86_64-24_r07.zip -d tmp/android/; unzip -o tmp/bootstrap-x86_64.zip -d tmp/bootstrap/'
                },
                //We use the shell because grunt-copy has some issues with symlinks: https://github.com/gruntjs/grunt-contrib-copy/issues/276
                copy: {
                    command: 'cp -r tmp/system-readonly/ tmp/system/'
                }
            },
            clean: {
                tmp: ['tmp/*.zip', 'tmp/system/', 'tmp/android/', 'tmp/bootstrap/']
            }
        }
    );

    grunt.registerTask('symlinks', 'Create symlinks for Termux binaries and libraries', function () {
        var symlinks = grunt.file.read('tmp/bootstrap/SYMLINKS.txt').split('\n');
        symlinks.forEach(function (symlink) {
            symlink = symlink.split('←');
            if (symlink[0]) {
                fs.symlink(symlink[0], 'tmp/bootstrap/' + symlink[1], function (e) {
                    grunt.log.error(e);
                });
            }
        });
    });

    grunt.loadNpmTasks('grunt-jslint');
    grunt.loadNpmTasks('grunt-jsonlint');
    grunt.loadNpmTasks('grunt-fixpack');
    grunt.loadNpmTasks('grunt-docker-io');
    grunt.loadNpmTasks('grunt-http-download');
    grunt.loadNpmTasks('grunt-mkdir');
    grunt.loadNpmTasks('grunt-shell');
    grunt.loadNpmTasks('grunt-contrib-clean');

    grunt.registerTask('lint', ['jslint', 'fixpack', 'jsonlint']);
    grunt.registerTask('bootstrap', ['download', 'shell:unzip', 'mkdir', 'shell:guestmount', 'shell:copy', 'shell:guestunmount', 'symlinks']);
    grunt.registerTask('build', ['docker_io']);
};
