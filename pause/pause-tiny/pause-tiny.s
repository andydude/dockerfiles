	# To build this:
	#
	#   $ as -o pause.o pause.s
	#   $ dd if=pause.o of=pause bs=16 skip=4 count=7
        #   $ chmod a+x pause
	#
        # This is the start of the ELF Header.
        # We put the entire program (progbits)
        # in the unused portion of e_ident.
	.byte 0x7f, 'E', 'L', 'F', 2, 1, 1
	.align 1
	.globl	_start


_start:
	mov $0x22, %al
	syscall
	jmp _start


	# The rest of e_ident
	.byte 0, 0, 0	# room for 3 bytes!

        # The rest of the ELF Header
	.short	     2	# e_type == ET_EXEC
	.short	  0x3e	# e_machine == EM_X86_64
	.short	  1, 0	# e_version
	.quad 0x400007  # e_entry
	.quad     0x38  # e_phoff
	.quad        0  # e_shoff
	.short	  0, 0	# e_flags
	.short	  0x40	# e_ehsize
	.short	  0x38	# e_phentsize

        # We overlap the two headers to save space
	.short	     1	# e_phnum == p_type
	.short	     0	# e_shentsize
	.short	     5	# e_shnum == p_flags
	.short	     0	# e_shstrndx

        # The rest of the Program Header
	.quad	     0  # p_offset
	.quad 0x400000	# p_vaddr
	.quad 0x400000	# p_paddr
	.quad	  0x70	# p_filesz
	.quad	  0x70	# p_memsz
	.quad 0x200000	# p_align
