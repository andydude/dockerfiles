# pause-easy

This is an implementation of the Kubernetes pause container.

For a complete list of pause implementations, see [this](../pause-tiny/README.md).

The primary claim to fame of this pause implementation is that it doesn't require any source code.

The Dockerfile uses the builder pattern, so the filesystem in the image is:

```
/s6-pause
/docker-init
/lib/libskarnet.so.2.7
/lib/ld-musl-x86_64.so.1
```

All binaries are available in alpine, and so the Dockerfile is all you need.

Special thanks to:
- [skarnet](https://skarnet.org/software/s6-portable-utils/s6-pause.html)
