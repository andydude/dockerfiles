#!/bin/sh
# cat /etc/os-release
ID=centos

_usrmerge_centos() {
    # usermerge centos-specific
    rmdir lib64/tls
    mv lib64/.lib* usr/lib64/

    _usrmerge_common
}

_varmerge_centos() {
    # remove cache/logs
    rm -rf /var/cache/*
    rm -f /usr/lib64/gconv/[A-HJ-KM-TV-Z]*.so
    rm -f /usr/lib64/gconv/lib*.so
    rm -f /var/log/anaconda/*.log
   
    # varmerge var/roothome BEGIN
    chmod 755 root

    _varmerge_common

    # varmerge var/roothome END
    chmod 550 var/roothome
}
