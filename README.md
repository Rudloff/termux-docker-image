# termux-docker-image

Docker image running Android and Termux

## Setup

```bash
npm install
```

## Build the image

```bash
grunt bootstrap
grunt build
```

## Known issues

* DNS resolution does not work
* getprop does not work correctly

## Use with GitLab Runner

This image can be used to test packages using [GitLab Runner](https://gitlab.com/gitlab-org/gitlab-ci-multi-runner).

[.gitlab-ci.yml](.gitlab-ci.yml) contains an example test that installs and run `screenfetch`.

You can try it locally like this:

```bash
gitlab-runner exec docker test
```
