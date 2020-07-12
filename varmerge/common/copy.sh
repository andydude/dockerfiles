#!/bin/sh

COMMON_DIR=$(dirname $0)
DIRS="
alpinelinux
amazonlinux
busybox
centos
debian
fedora
ubuntu
"

for dir in $DIRS; do
   cp $COMMON_DIR/common.sh $COMMON_DIR/../$dir/
done
