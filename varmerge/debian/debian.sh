#!/bin/sh
# cat /etc/os-release
ID=debian

_usrmerge_debian() {
    # usrmerge usr/{lib/<target-triplet>}
    _dirmerge_common usr "lib/x86_64-linux-gnu"
    unlink "lib/x86_64-linux-gnu"
    
    _usrmerge_common
}

_varmerge_debian() {    
    _varmerge_common
}
