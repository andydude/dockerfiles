# pause-tiny

This is an implementation of the Kubernetes pause container.

You can just use k8s.gcr.io/pause-amd64 instead, or read the original source code
[here](https://github.com/kubernetes/kubernetes/tree/master/build/pause).

You can set your own cluster's pause container with the `--pod-infra-container-image`
command line option to `kubelet`. The requirements of this container are somewhat
documented:

1. it must [pause](http://pubs.opengroup.org/onlinepubs/9699919799/functions/pause.html),
2. it must [stop](https://pubs.opengroup.org/onlinepubs/9699919799/functions/V2_chap02.html#tag_15_04) when signaled,
3. it should run a command called ["/pause"],
4. it should display help with `-h` and/or version with `-v` options.

The `s6-portable-utils` package has a `s6-pause` tool that is really good at (1), and
the `docker-init` (formerly `tini`) tool takes care of (2), but unless we add busybox
`ash`, then (3) will have to be sacrificed.

Another implementation that is quite impressive was tianon's, which can be found
[here](https://github.com/tianon/dockerfiles/tree/master/sleeping-beauty).
tianon's `sleeping-beauty` is written in x86_64 assembly language and compiled
with nasm to the end result of having a 129-byte ELF64 executable. In comparison
here are some of the file sizes of the other exetutables referenced so far:

- 112 B     pause-tiny (gas)
- 129 B     tianon/sleeping-beauty:latest (nasm)
- 129 B     kubernetes/pause:asm = k8s-pause-asm
- 240 KiB   kubernetes/pause:go
- 13.6 KiB  s6-pause
- 47.2 KiB  (docker-init)
- 60.8 KiB  (docker-init + s6-pause)
- 814 KiB   pause-easy = (docker-init + s6-pause + libc.musl)
- 772 KiB   (libc.musl)
- 1.3 MiB   openshift/origin-pod

To compare apples to apples, s6-pause includes 814 KiB of binaries in the image,
which is approximately 70 KiB more than the official K8S pause image, and the clear
winners are tianon's and varmol's versions.

This is [tianon](https://hub.docker.com/r/tianon/sleeping-beauty)'s hand-written assembly version!

```
_start:
    mov $34, %eax  # SYS_pause is 34
    syscall
    jmp _start
```

Wow that's a sleeping-beauty! (Thanks tianon)

Another notable implementation is that of [kubernetes/pause:asm](https://hub.docker.com/r/kubernetes/pause/tags).

```
_start:
    mov $34, %al  # SYS_pause is 34
    syscall
    mov $60, %al  # SYS_exit is 60
    cdq           # zero %edx
    syscall
```

The brilliance of the Kubernetes version, whose [original commit](https://github.com/kubernetes/kubernetes/commit/88317efb42db763b9fb97cd1d9ac1465e62009d0) seems to be by someone named [vmarmol](https://github.com/kubernetes/kubernetes/commits?author=vmarmol), is using the 8-bit version of the move instruction, which takes up fewer bytes in machine code than the 32-bit version of the same instruction, and provided that the register started as zero, then should be equivalent to the 8-bit version. However, since the program never gets to the third instruction, the exit syscall is never executed. So tianon's version actually makes more sense. 

Another downside of vmarmol's version is that the most clever instruction is wrong. The *intent* of the second-to-last instruction is to zero `%edi` according to the comments, but what it *actually* does it zero `%edx`. This will only work when the register is already zero.

Another downside of vmarmol's version is that the *real* exit() implementation on x86_64 actually calls `while (true) syscall`, which adds a layer of safety in the unlikely event that exit actually returns. tianon's version does use this technique, and so is actually safer than vmarmol's version in the unlikely event that both syscalls return.

[My](https://andydude.github.io/) version, called `pause-tiny`, combines the genious of both of these implementations into a smaller program:

```
_start:
    mov $34, %al  # SYS_pause is 34
	syscall
	jmp _start
```

# Thanks
Special thanks to:
- [markloiseau](http://blog.markloiseau.com/2012/05/tiny-64-bit-elf-executables/)
- [tianon](https://github.com/tianon/dockerfiles/tree/master/sleeping-beauty)
- [skarnet](https://skarnet.org/software/s6-portable-utils/s6-pause.html)
