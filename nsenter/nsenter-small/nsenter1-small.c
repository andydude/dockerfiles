#include <syscall.h>

static __inline long
__syscall0 (long n)
{
  unsigned long ret;
  __asm__ __volatile__ (
      "syscall"
      :"=a" (ret)
      :"a" (n)
      :"rcx", "r11", "memory");
  return ret;
}

static __inline long
__syscall1 (long n, long a1)
{
  unsigned long ret;
  __asm__ __volatile__ (
      "syscall"
      :"=a" (ret)
      :"a" (n), "D" (a1)
      :"rcx", "r11", "memory");
  return ret;
}

static __inline long
__syscall2 (long n, long a1, long a2)
{
  unsigned long ret;
  __asm__ __volatile__ (
      "syscall"
      :"=a" (ret)
      :"a" (n), "D" (a1), "S" (a2)
      :"rcx", "r11", "memory");
  return ret;
}

static __inline long
__syscall3 (long n, long a1, long a2, long a3)
{
  unsigned long ret;
  __asm__ __volatile__ (
      "syscall"
      :"=a" (ret)
      :"a" (n), "D" (a1),
       "S" (a2), "d" (a3)
      :"rcx", "r11", "memory");
  return ret;
}

#define NULL ((void *)0)

#define open(pn, flags) \
    __syscall2(SYS_open, (long)pn, flags)
#define setns(fd, nstype) \
    __syscall2(SYS_setns, fd, nstype)
#define fchdir(fd) \
    __syscall1(SYS_fchdir, fd)
#define chroot(pn) \
    __syscall1(SYS_chroot, (long)pn)
#define exit(ec) \
    __syscall1(SYS_exit, ec)
#define execve(path, argv, environ) \
    __syscall3(SYS_execve, (long)path, (long)argv, (long)environ)

//extern char **__environ;

int
_start ()
{
  char *cargv0 = "/bin/sh";
  char *cargv[] = { cargv0, NULL };

  setns (open ("/proc/1/ns/mnt", 0), 0);
  setns (open ("/proc/1/ns/uts", 0), 0);
  setns (open ("/proc/1/ns/net", 0), 0);
  setns (open ("/proc/1/ns/ipc", 0), 0);
  fchdir (open ("/proc/1/root", 0));
  chroot (".");
  execve (cargv[0], cargv, NULL);
  exit (0);
}
