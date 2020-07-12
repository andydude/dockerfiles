#!/bin/sh
# cat /etc/os-release
ID=ubuntu

_usrmerge_ubuntu() {
    # usrmerge usr/{lib/<target-triplet>}
    _dirmerge_common usr "lib/x86_64-linux-gnu"
    unlink "lib/x86_64-linux-gnu"

    _usrmerge_common
}

_varmerge_ubuntu() {
    _varmerge_common
}
