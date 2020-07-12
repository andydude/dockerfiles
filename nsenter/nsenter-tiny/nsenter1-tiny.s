	# To build this:
	#
	#	$ as -o nsenter-try3.o nsenter-try3.s
	#	$ dd if=nsenter-try3.o of=nsenter bs=16 skip=4 count=23
	#	$ chmod a+x nsenter

	.text
	.code64
	.byte 0x7f, 'E', 'L', 'F', 2, 1, 1, 0
	.align 1
	
.LC0:  
	# The rest of e_ident
	.string "/bin/sh"

	# The rest of the ELF Header
	.short		 2	# e_type == ET_EXEC
	.short	  0x3e	# e_machine == EM_X86_64
	.short	  1, 0	# e_version
	.quad 0x400070	# e_entry
	.quad	  0x38	# e_phoff
	.quad		 0	# e_shoff
	.short	  0, 0	# e_flags
	.short	  0x40	# e_ehsize
	.short	  0x38	# e_phentsize

	# We overlap the two headers to save space
	.short		 1	# e_phnum == p_type
	.short		 0	# e_shentsize
	.short		 5	# e_shnum == p_flags
	.short		 0	# e_shstrndx

	# The rest of the Program Header
	.quad		 0	# p_offset
	.quad 0x400000	# p_vaddr
	.quad 0x400000	# p_paddr
	.quad	0x0170	# p_filesz
	.quad	0x0170	# p_memsz
	.quad 0x200000	# p_align
	
	.globl	_start
	.type	_start, @function

_start:
	.cfi_startproc
	leaq	.LC0(%rip), %rax
	movl	$2, %r8d
	xorl	%edx, %edx
	movq	$0, -8(%rsp)
	movq	%rax, -16(%rsp)
	leaq	.LC1(%rip), %rdi
	movq	%r8, %rax
	movq	%rdx, %rsi
	syscall
	movl	$308, %r9d
	movq	%rax, %rdi
	movq	%r9, %rax
	syscall
	leaq	.LC2(%rip), %rdi
	movq	%r8, %rax
	syscall
	movq	%rax, %rdi
	movq	%r9, %rax
	syscall
	leaq	.LC3(%rip), %rdi
	movq	%r8, %rax
	syscall
	movq	%rax, %rdi
	movq	%r9, %rax
	syscall
	leaq	.LC4(%rip), %rdi
	movq	%r8, %rax
	syscall
	movq	%rax, %rdi
	movq	%r9, %rax
	syscall
	leaq	.LC5(%rip), %rdi
	movq	%r8, %rax
	syscall
	movq	%rax, %rdi
	movl	$81, %eax
	syscall
	movl	$161, %eax
	leaq	.LC6(%rip), %rdi
	syscall
	movl	$59, %eax
	leaq	-16(%rsp), %rsi
	movq	-16(%rsp), %rdi
	syscall
	movl	$60, %eax
	movq	%rdx, %rdi
	syscall
	ret
	.cfi_endproc

.LC1:
	.string	"/proc/1/ns/mnt"
.LC2:
	.string	"/proc/1/ns/uts"
.LC3:
	.string	"/proc/1/ns/net"
.LC4:
	.string	"/proc/1/ns/ipc"
.LC5:
	.string	"/proc/1/root"
.LC6:
	.string	"."
