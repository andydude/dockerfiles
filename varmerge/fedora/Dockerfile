# stage 0
ARG FEDORA_VERSION
FROM fedora:${FEDORA_VERSION}

# stage 1
FROM alpine:latest
WORKDIR /mnt
COPY --from=0 / /mnt
COPY fedora.sh /
RUN . /fedora.sh && _varmerge_fedora

# stage 2
FROM scratch
WORKDIR /
COPY --from=1 /mnt /
RUN rmdir --ignore-fail-on-non-empty boot lost+found
CMD ["bash"]
