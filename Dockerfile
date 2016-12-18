FROM scratch
COPY tmp/system/ /system/
CMD ["/data/data/com.termux/files/usr/bin/bash"]
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
