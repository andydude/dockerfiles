#!/bin/sh
# cat /etc/os-release
ID=amzn

_varmerge_amzn() {
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
