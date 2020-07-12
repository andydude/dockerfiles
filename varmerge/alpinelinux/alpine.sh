#!/bin/sh
# cat /etc/os-release
ID=alpine

_usrmerge_alpine() {
    # alpine-specific
    # usrmerge existing links
    unlink usr/lib/libcrypto.so.1.1
    unlink usr/lib/libssl.so.1.1
    rmdir  lib/modules-load.d

    # busybox-specific
    # usrmerge absolute links
    cd bin
    for x in $(cat /alpine-bin-cmds.txt); do 
        unlink "$x"
        ln -s busybox "$x"
    done
    cd ..
    cd sbin
    for x in $(cat /alpine-sbin-cmds.txt); do 
        unlink "$x"
        ln -s ../bin/busybox "$x"
    done
    cd ..
    cd usr/bin
    for x in $(cat /alpine-usr-bin-cmds.txt); do 
        unlink "$x"
        ln -s busybox "$x"
    done
    cd ../..
    cd usr/sbin
    for x in $(cat /alpine-usr-sbin-cmds.txt); do 
        unlink "$x"
        ln -s ../bin/busybox "$x"
    done
    cd ../..

    _usrmerge_common
}


_varmerge_alpine() {
    mkdir -p media
    _varmerge_common
}
