#!/bin/sh
# cat /etc/os-release
ID=alpine

_usrmerge_alpine() {
  # usrmerge existing links
  unlink usr/lib/libcrypto.so.1.1
  unlink usr/lib/libssl.so.1.1
  
  # usrmerge usr/{bin,lib,sbin}
  for d in bin lib sbin; do
    mv $d/* usr/$d/
    rmdir $d
    ln -s usr/$d $d
  done
  
  # usrmerge absolute links
  cd usr/bin
  for x in *; do 
    if [ -h $x ]; then 
      unlink $x
      ln -s busybox $x
    fi
  done
  cd ../..
}


_varmerge_alpine() {
  # varmerge var/{home,mnt,opt,srv}
  for d in home mnt opt srv; do
    mv $d var/$d
    ln -s var/$d $d
  done
  
  # varmerge var/roothome
  mv root var/roothome
  ln -s var/roothome root
  
  # varmerge var/usrlocal
  mv usr/local var/usrlocal
  ln -s ../var/usrlocal usr/local
}
