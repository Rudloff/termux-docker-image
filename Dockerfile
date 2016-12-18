FROM scratch
COPY tmp/system/ /system/
CMD ["/system/bin/sh"]
ENV PATH /data/data/com.termux/files/usr/bin/:/system/bin/:$PATH
ENV LD_LIBRARY_PATH=/data/data/com.termux/files/usr/lib/
COPY tmp/bootstrap/ /data/data/com.termux/files/usr/
RUN ["/system/bin/sh", "-c", "chmod 775 /data/data/com.termux/files/usr/bin/*"]
