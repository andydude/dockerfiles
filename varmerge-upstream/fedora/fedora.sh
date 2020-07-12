#!/bin/sh
# cat /etc/os-release
ID=fedora

_varmerge_fedora() {    
  # varmerge var/{home,mnt,opt,srv}
  for d in home mnt opt srv; do
    mv $d var/$d
    ln -s var/$d $d
  done
  
  # varmerge var/roothome
  chmod 755 root
  mv root var/roothome
  ln -s var/roothome root
  chmod 550 var/roothome
  
  # varmerge var/usrlocal
  mv usr/local var/usrlocal
  ln -s ../var/usrlocal usr/local

  # fix ownership
  # chown -R 192:192 run/systemd/netif
  for d in home mnt opt root srv; do
    chown root:root $d
  done

  # remove cache
  rm -rf /var/cache/*
  rm -f /usr/lib64/gconv/[A-HJ-KM-TV-Z]*.so
  rm -f /usr/lib64/gconv/lib*.so
  
  # remove logs
  rm -f /var/log/anaconda/*.log
}
