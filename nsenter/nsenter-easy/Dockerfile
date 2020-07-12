# Stage 0
FROM alpine:latest
RUN apk update \
  && apk add util-linux \
  && mkdir -p /mnt/usr/bin \
  && ln -s usr/bin /mnt/bin \
  && ln -s usr/lib /mnt/lib \
  && ln -s busybox /mnt/usr/bin/sh \
  && echo '#!/bin/sh' > /mnt/usr/bin/nsenter1 \
  && echo 'exec nsenter -m -u -n -i -t 1 "$@"' >> /mnt/usr/bin/nsenter1 \
  && chmod a+x /mnt/usr/bin/nsenter1

# Stage 1
FROM scratch
COPY --from=0 /mnt /
COPY --from=0 \
  /bin/busybox \
  /usr/bin/busybox
COPY --from=0 \
  /usr/bin/nsenter \
  /usr/bin/nsenter
COPY --from=0 \
  /lib/ld-musl-x86_64.so.1 \
  /usr/lib/ld-musl-x86_64.so.1

ENTRYPOINT ["/usr/bin/nsenter1"]
CMD ["/bin/sh"]
