# stage 0
ARG ALPINE_VERSION=3.11.6
FROM alpine:${ALPINE_VERSION}

# stage 1
FROM alpine:latest
WORKDIR /mnt
COPY --from=0 / /mnt
COPY common.sh /
COPY alpine.sh /
COPY alpine-bin-cmds.txt /
COPY alpine-sbin-cmds.txt /
COPY alpine-usr-bin-cmds.txt /
COPY alpine-usr-sbin-cmds.txt /
RUN . /common.sh \
  && . /alpine.sh \
  && _usrmerge_alpine
#  && _usrmerge_alpine \
#  && _varmerge_alpine

# stage 2
FROM scratch
WORKDIR /
COPY --from=1 /mnt /
CMD ["sh"]
