# stage 0
ARG AMZN_VERSION=2.0.20200406.0
FROM amazonlinux:${AMZN_VERSION}

# stage 1
FROM alpine:latest
WORKDIR /mnt
COPY --from=0 / /mnt
COPY common.sh /
COPY amzn.sh /
RUN . /common.sh \
  && . /amzn.sh \
  && _varmerge_amzn

# stage 2
FROM scratch
WORKDIR /
COPY --from=1 /mnt /
RUN rmdir --ignore-fail-on-non-empty boot
CMD ["bash"]
