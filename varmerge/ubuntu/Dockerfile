# stage 0
ARG UBUNTU_VERSION
FROM ubuntu:${UBUNTU_VERSION}
# RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y usrmerge

# stage 1
FROM alpine:latest
WORKDIR /mnt
COPY --from=0 / /mnt
COPY ubuntu.sh /
RUN . /ubuntu.sh \
  && _usrmerge_ubuntu \
  && _varmerge_ubuntu

# stage 2
FROM scratch
WORKDIR /
COPY --from=1 /mnt /
RUN rmdir --ignore-fail-on-non-empty boot
CMD ["bash"]
