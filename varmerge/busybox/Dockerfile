# stage 0
ARG BUSYBOX_VERSION=1.31.1-musl
FROM busybox:${BUSYBOX_VERSION}

# stage 1
FROM busybox:latest
WORKDIR /mnt
COPY --from=0 / /mnt
COPY common.sh /
COPY busybox.sh /
COPY busybox-bin-cmds.txt /
COPY busybox-sbin-cmds.txt /
RUN . /common.sh \
  && . /busybox.sh \
  && _usrmerge_busybox \
  && _varmerge_busybox

# stage 2
FROM scratch
WORKDIR /
COPY --from=1 /mnt /
CMD ["sh"]
