# stage 0
ARG FEDORA_VERSION=32
FROM fedora:${FEDORA_VERSION}

# stage 1
FROM alpine:latest
WORKDIR /mnt
COPY --from=0 / /mnt
COPY common.sh /
COPY fedora.sh /
RUN . /common.sh && . /fedora.sh \
    && _varmerge_fedora

# stage 2
FROM scratch
WORKDIR /
COPY --from=1 /mnt /
RUN rmdir --ignore-fail-on-non-empty boot lost+found
CMD ["bash"]
