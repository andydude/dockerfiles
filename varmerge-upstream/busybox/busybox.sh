#!/bin/sh
# cat /etc/os-release
ID=busybox

_usrmerge_busybox() {
  # usrmerge usr/{bin,lib,sbin}
  mv bin usr/bin
  mkdir -p usr/lib
  for d in bin lib sbin; do
    ln -s usr/$d $d
  done
  
  # usrmerge absolute links
  cd usr/bin
  for x in $(cat /busybox-cmds.txt); do 
    unlink $x
    ln -s busybox $x
  done
  cd ../..
}


_varmerge_busybox() {
  # varmerge var/{mnt,opt,srv}
  for d in  mnt opt srv; do
    mkdir -p var/$d
    ln -s var/$d $d
  done
    
  # varmerge var/home
  for d in home; do
    mv $d var/$d
    ln -s var/$d $d
  done
  
  # varmerge var/roothome
  mv root var/roothome
  ln -s var/roothome root
  
  # varmerge var/usrlocal
  mkdir -p var/usrlocal
  ln -s ../var/usrlocal usr/local
}
