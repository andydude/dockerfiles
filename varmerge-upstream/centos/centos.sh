#!/bin/sh
# cat /etc/os-release
ID=centos

_usrmerge_centos() {
  rmdir lib64/tls
  mv lib64/.lib* usr/lib64/
    
  for d in bin sbin lib lib64; do
    mv $d/* usr/$d/
    rmdir $d
    ln -s usr/$d $d
  done
}

_varmerge_centos() {
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
