# busybox-varmerge

Busybox with `usrmerge` and `varmerge` top-level directory structure.

- [Official Docker repo](https://hub.docker.com/_/busybox)
- [Official Github repo](https://github.com/docker-library/busybox)

# Why `varmerge`?

To put all mutable state in `/var`.

- [debian on usrmerge](https://wiki.debian.org/UsrMerge)
- [freedesktop on usrmerge](https://www.freedesktop.org/wiki/Software/systemd/TheCaseForTheUsrMerge/)
- [fedora on varmerge](https://docs.fedoraproject.org/en-US/fedora-silverblue/technical-information/)
- [coreos and ostree on varmerge](https://ostree.readthedocs.io/en/latest/manual/adapting-existing/)