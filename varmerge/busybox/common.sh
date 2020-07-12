#!/bin/sh

_dirmerge_common() {
    for d in $2; do
        if [ ! -d $d ]; then
            continue
        fi
        if [ ! -d $1/$d ]; then
            mkdir -p $1/$d/
        fi
        if [ -d $1/$d ]; then
            if [ ! -z "$(ls -A $d)" ]; then
                mv $d/* $1/$d/
            fi
            rmdir $d
        else
            mv $d $1/$d
        fi
        ln -s $1/$d $d
    done
}

_usrmerge_common() {
    # usrmerge usr/{bin,lib,sbin}
    _dirmerge_common usr "bin lib lib64 sbin"
}

_varmerge_common() {
    # varmerge var/{home,mnt,opt,srv}
    _dirmerge_common var "home mnt opt srv"

    # varmerge var/roothome
    if [ -d root ]; then
        rootmode=$(stat -c '%a' root)
        chmod 755 root
        mv root var/roothome
        ln -s var/roothome root
        chmod $rootmode var/roothome
    fi
    
    # varmerge var/usrlocal
    if [ -d media ]; then
        mv usr/local var/usrlocal
        ln -s ../var/usrlocal usr/local
    fi
    
    # runmerge run/media
    if [ -d media ]; then
        mv media run/media
        ln -s run/media media
    fi
}
