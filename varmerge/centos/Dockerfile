# stage 0
ARG CENTOS_VERSION=8
FROM centos:${CENTOS_VERSION}

# stage 1
FROM alpine:latest
WORKDIR /mnt
COPY --from=0 / /mnt
COPY common.sh /
COPY centos.sh /
RUN . /common.sh && . /centos.sh \
  && _usrmerge_centos \
  && _varmerge_centos

# stage 2
FROM scratch
WORKDIR /
COPY --from=1 /mnt /
RUN rmdir --ignore-fail-on-non-empty lost+found
CMD ["bash"]
