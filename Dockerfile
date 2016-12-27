FROM scratch
COPY tmp/system/ /system/
CMD /data/data/com.termux/files/usr/bin/bash
ENV PATH /data/data/com.termux/files/usr/bin/:/data/data/com.termux/files/usr/bin/applets/:/system/bin/:$PATH
ENV LD_LIBRARY_PATH=/data/data/com.termux/files/usr/lib/
ENV ANDROID_ROOT=/system
ENV ANDROID_DATA=/data
COPY tmp/bootstrap/ /data/data/com.termux/files/usr/
RUN ["/system/bin/sh", "-c", "mkdir /bin"]
RUN ["/system/bin/sh", "-c", "ln -s /system/bin/sh /bin/sh"]
RUN chmod +x /data/data/com.termux/files/usr/bin/*
RUN echo '\n104.18.37.234 termux.net' >> /system/etc/hosts
RUN chmod +x /data/data/com.termux/files/usr/lib/apt/methods/*
RUN chmod +x /data/data/com.termux/files/usr/libexec/termux/command-not-found
RUN echo "mkdir -p /dev/socket/; ln -sfn /__properties__ /dev/__properties__; chmod 777 /dev/socket/; logd &" >> /data/data/com.termux/files/usr/etc/bash.bashrc
RUN mkdir -p /data/data/com.termux/files/usr/tmp/
RUN mkdir -p /data/data/com.termux/files/usr/etc/apt/preferences.d/
RUN mkdir -p /data/data/com.termux/files/usr/etc/apt/apt.conf.d/
RUN mkdir -p /data/data/com.termux/files/usr/var/cache/apt/archives/partial/
RUN mkdir -p /data/data/com.termux/files/usr/var/lib/dpkg/updates/
RUN mkdir -p /data/data/com.termux/files/usr/var/log/apt/
ADD tmp/__properties__ ./__properties__/
ADD tmp/property_contexts /
