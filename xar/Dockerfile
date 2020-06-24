# Stage 0
FROM alpine:latest
ENV XAR_VERSION=420
COPY xar.patch /
RUN apk update \
  && apk add alpine-sdk autoconf automake curl fts-dev zlib-dev bzip2-dev tar libxml2-dev openssl-dev \
  && mkdir -p /usr/src/xar \
  && curl -s https://opensource.apple.com/tarballs/xar/xar-420.tar.gz | tar -xzf - -C /usr/src/xar \
  && cd /usr/src/xar/xar-${XAR_VERSION}/xar \
  && patch -p1 < /xar.patch \
  && ./autogen.sh \
  && CFLAGS="-Wall -Dsafe_dirname=dirname" LDFLAGS="-lfts -lssl -lcrypto" ./configure --disable-static \
  && ln -s ../lib/ea.h src/ea.h \
  && ln -s ../lib/filetree.h src/filetree.h \
  && ln -s ../lib/util.h src/util.h \
  && make \
  && make install

# Stage 1
FROM alpine:latest
RUN apk update \
  && apk add fts libbz2 libcrypto1.1 libxml2 xz-libs zlib
COPY --from=0 /usr/local/bin/xar /usr/local/bin/xar
COPY --from=0 /usr/local/lib/libxar.so.1 /usr/local/lib/libxar.so.1
