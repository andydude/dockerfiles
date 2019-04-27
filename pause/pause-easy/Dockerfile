# stage 0
FROM alpine:latest
# Download s6-pause and docker-init
RUN apk update && apk add s6-portable-utils tini-static
RUN mkdir -p /mnt/lib \
    && cp /lib/ld-musl-x86_64.so.1 /mnt/lib/ \
    && cp /lib/libskarnet.so.2.7 /mnt/lib/ \
    && cp /sbin/tini-static /mnt/init \
    && cp /usr/bin/s6-pause /mnt/pause
CMD ["/bin/false"]

# stage 1
FROM scratch
COPY --from=0 /mnt /
CMD ["/init", "/pause"]
