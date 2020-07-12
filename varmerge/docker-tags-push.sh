# head /var/log/dpkg.log
set -a; . ./env; set +a

# alpine
for TAG in \
     3.11.2 \
     3.11.3 \
     3.11.5 \
     3.11.6 \
     3.12.0 \
     3; do
ALPINE_VERSION=$TAG docker-compose build --no-cache alpine;
docker push andydude64/alpine-varmerge:$TAG;
done

for TAG in 3.12.0; do
docker tag andydude64/alpine-varmerge:$TAG andydude64/alpine-varmerge:3.11;
docker tag andydude64/alpine-varmerge:$TAG andydude64/alpine-varmerge:latest;
docker push andydude64/alpine-varmerge:3.12;
docker push andydude64/alpine-varmerge:latest;
done

# busybox
for TAG in \
    1.31.0-glibc \
    1.31.0-musl \
    1.31.0-uclibc \
    1.31.1-glibc \
    1.31.1-musl \
    1.31.1-uclibc \
    1; do
BUSYBOX_VERSION=$TAG docker-compose build --no-cache busybox;
docker push andydude64/busybox-varmerge:$TAG;
done

for TAG in 1.31.1; do
docker tag andydude64/busybox-varmerge:$TAG-glibc andydude64/busybox-varmerge:1-glibc;
docker tag andydude64/busybox-varmerge:$TAG-musl andydude64/busybox-varmerge:1-musl;
docker tag andydude64/busybox-varmerge:$TAG-uclibc andydude64/busybox-varmerge:1-uclibc;
docker push andydude64/busybox-varmerge:1-glibc;
docker push andydude64/busybox-varmerge:1-musl;
docker push andydude64/busybox-varmerge:1-uclibc;
done

for TAG in 1.31.1-uclibc; do
docker tag andydude64/busybox-varmerge:$TAG andydude64/busybox-varmerge:latest;
docker push andydude64/busybox-varmerge:latest;
done

# fedora
for TAG in \
     30 \
     31 \
     32 \
     33; do
FEDORA_VERSION=$TAG docker-compose build fedora;
docker push andydude64/fedora-varmerge:$TAG;
done

docker tag andydude64/fedora-varmerge:32 andydude64/fedora-varmerge:latest;
docker push andydude64/fedora-varmerge:latest;
docker tag andydude64/fedora-varmerge:33 andydude64/fedora-varmerge:rawhide;
docker push andydude64/fedora-varmerge:rawhide;

# ubuntu
for TAG in \
     bionic-20200311 \
     bionic-20200403 \
     bionic \
     focal-20200319 \
     focal-20200423 \
     focal; do
UBUNTU_VERSION=$TAG docker-compose build --no-cache ubuntu;
docker push andydude64/ubuntu-varmerge:$TAG;
done

for TAG in focal-20200423; do
docker tag andydude64/ubuntu-varmerge:$TAG andydude64/ubuntu-varmerge:bionic;
docker tag andydude64/ubuntu-varmerge:$TAG andydude64/ubuntu-varmerge:latest;
docker push andydude64/ubuntu-varmerge:focal;
docker push andydude64/ubuntu-varmerge:latest;
done
