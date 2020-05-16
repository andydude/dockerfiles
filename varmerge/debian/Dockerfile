# stage 0
ARG DEBIAN_VERSION
FROM debian:${DEBIAN_VERSION}
# RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y usrmerge

# stage 1
FROM alpine:latest
WORKDIR /mnt
COPY --from=0 / /mnt
COPY debian.sh /
RUN . /debian.sh \
  && _usrmerge_debian \
  && _varmerge_debian

# stage 2
FROM scratch
WORKDIR /
COPY --from=1 /mnt /
RUN rmdir --ignore-fail-on-non-empty boot
CMD ["bash"]
