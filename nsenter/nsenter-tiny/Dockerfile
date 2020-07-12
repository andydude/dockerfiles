# Stage 0
FROM alpine:latest
COPY . /opt
RUN apk update \
  && apk add alpine-sdk \
  && cd /opt \
  && make nsenter1-tiny

# Stage 1
FROM scratch
COPY --from=0 /opt/nsenter1-tiny /nsenter1
ENTRYPOINT ["/nsenter1"]

