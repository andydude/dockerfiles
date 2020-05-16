# stage 0
ARG BUSYBOX_VERSION
FROM busybox:${BUSYBOX_VERSION}

# stage 1
FROM busybox:latest
WORKDIR /mnt
COPY --from=0 / /mnt
COPY busybox.sh /
COPY busybox-cmds.txt /
RUN . /busybox.sh \
  && _usrmerge_busybox \
  && _varmerge_busybox

# stage 2
FROM scratch
WORKDIR /
COPY --from=1 /mnt /
CMD ["sh"]
