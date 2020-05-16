#!/bin/sh
# cat /etc/os-release
ID=ubuntu

_usrmerge_ubuntu() {
  for d in lib/x86_64-linux-gnu lib lib64; do
    mkdir -p usr/$d/
    mv $d/* usr/$d/
    rmdir $d
  done
  ln -s usr/lib lib
  ln -s usr/lib64 lib64
  
  # usrmerge usr/{bin,lib,sbin}
  for d in bin sbin; do
    mv $d/* usr/$d/
    rmdir $d
    ln -s usr/$d $d
  done
}

_varmerge_ubuntu() {    
  # varmerge var/{home,mnt,opt,srv}
  for d in home mnt opt srv; do
    mv $d var/$d
    ln -s var/$d $d
  done
  
  # varmerge var/roothome
  chmod 755 root
  mv root var/roothome
  ln -s var/roothome root
  chmod 700 var/roothome
  
  # varmerge var/usrlocal
  mv usr/local var/usrlocal
  ln -s ../var/usrlocal usr/local
}
