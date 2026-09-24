	.file	"fib.c"
	.option nopic
	.attribute arch, "rv64i2p0_m2p0_a2p0_f2p0_d2p0_c2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.align	1
	.globl	main
	.type	main, @function
main:
.LFB3:
	.file 1 "fib.c"
	.loc 1 8 1
	.cfi_startproc
	addi	sp,sp,-48
	.cfi_def_cfa_offset 48
	sd	ra,40(sp)
	sd	s0,32(sp)
	.cfi_offset 1, -8
	.cfi_offset 8, -16
	addi	s0,sp,48
	.cfi_def_cfa 8, 0
	.loc 1 11 9
	call	getint
	mv	a5,a0
	sw	a5,-32(s0)
	.loc 1 13 7
	sw	zero,-20(s0)
	.loc 1 14 7
	li	a5,1
	sw	a5,-24(s0)
	.loc 1 15 7
	li	a5,1
	sw	a5,-28(s0)
	.loc 1 17 5
	lw	a5,-20(s0)
	mv	a0,a5
	call	putint
	.loc 1 18 5
	li	a0,10
	call	putch
	.loc 1 19 5
	lw	a5,-24(s0)
	mv	a0,a5
	call	putint
	.loc 1 20 5
	li	a0,10
	call	putch
	.loc 1 22 11
	j	.L2
.L3:
	.loc 1 24 11
	lw	a5,-24(s0)
	sw	a5,-36(s0)
	.loc 1 25 11
	lw	a4,-24(s0)
	lw	a5,-20(s0)
	addw	a5,a4,a5
	sw	a5,-24(s0)
	.loc 1 26 9
	lw	a5,-24(s0)
	mv	a0,a5
	call	putint
	.loc 1 27 9
	li	a0,10
	call	putch
	.loc 1 28 11
	lw	a5,-36(s0)
	sw	a5,-20(s0)
	.loc 1 29 11
	lw	a5,-28(s0)
	addiw	a5,a5,1
	sw	a5,-28(s0)
.L2:
	.loc 1 22 11
	lw	a4,-28(s0)
	lw	a5,-32(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	blt	a4,a5,.L3
	.loc 1 32 12
	li	a5,0
	.loc 1 33 1
	mv	a0,a5
	ld	ra,40(sp)
	.cfi_restore 1
	ld	s0,32(sp)
	.cfi_restore 8
	.cfi_def_cfa 2, 48
	addi	sp,sp,48
	.cfi_def_cfa_offset 0
	jr	ra
	.cfi_endproc
.LFE3:
	.size	main, .-main
.Letext0:
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.4byte	0xde
	.2byte	0x4
	.4byte	.Ldebug_abbrev0
	.byte	0x8
	.byte	0x1
	.4byte	.LASF11
	.byte	0xc
	.4byte	.LASF12
	.4byte	.LASF13
	.8byte	.Ltext0
	.8byte	.Letext0-.Ltext0
	.4byte	.Ldebug_line0
	.byte	0x2
	.byte	0x1
	.byte	0x6
	.4byte	.LASF0
	.byte	0x2
	.byte	0x1
	.byte	0x8
	.4byte	.LASF1
	.byte	0x2
	.byte	0x2
	.byte	0x5
	.4byte	.LASF2
	.byte	0x2
	.byte	0x2
	.byte	0x7
	.4byte	.LASF3
	.byte	0x3
	.byte	0x4
	.byte	0x5
	.string	"int"
	.byte	0x2
	.byte	0x4
	.byte	0x7
	.4byte	.LASF4
	.byte	0x2
	.byte	0x8
	.byte	0x5
	.4byte	.LASF5
	.byte	0x2
	.byte	0x8
	.byte	0x7
	.4byte	.LASF6
	.byte	0x2
	.byte	0x8
	.byte	0x5
	.4byte	.LASF7
	.byte	0x2
	.byte	0x10
	.byte	0x4
	.4byte	.LASF8
	.byte	0x2
	.byte	0x1
	.byte	0x8
	.4byte	.LASF9
	.byte	0x2
	.byte	0x8
	.byte	0x7
	.4byte	.LASF10
	.byte	0x4
	.4byte	.LASF14
	.byte	0x1
	.byte	0x7
	.byte	0x5
	.4byte	0x49
	.8byte	.LFB3
	.8byte	.LFE3-.LFB3
	.byte	0x1
	.byte	0x9c
	.byte	0x5
	.string	"a"
	.byte	0x1
	.byte	0x9
	.byte	0x9
	.4byte	0x49
	.byte	0x2
	.byte	0x91
	.byte	0x6c
	.byte	0x5
	.string	"b"
	.byte	0x1
	.byte	0x9
	.byte	0xc
	.4byte	0x49
	.byte	0x2
	.byte	0x91
	.byte	0x68
	.byte	0x5
	.string	"i"
	.byte	0x1
	.byte	0x9
	.byte	0xf
	.4byte	0x49
	.byte	0x2
	.byte	0x91
	.byte	0x64
	.byte	0x5
	.string	"n"
	.byte	0x1
	.byte	0x9
	.byte	0x12
	.4byte	0x49
	.byte	0x2
	.byte	0x91
	.byte	0x60
	.byte	0x5
	.string	"t"
	.byte	0x1
	.byte	0x9
	.byte	0x15
	.4byte	0x49
	.byte	0x2
	.byte	0x91
	.byte	0x5c
	.byte	0
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.byte	0x1
	.byte	0x11
	.byte	0x1
	.byte	0x25
	.byte	0xe
	.byte	0x13
	.byte	0xb
	.byte	0x3
	.byte	0xe
	.byte	0x1b
	.byte	0xe
	.byte	0x11
	.byte	0x1
	.byte	0x12
	.byte	0x7
	.byte	0x10
	.byte	0x17
	.byte	0
	.byte	0
	.byte	0x2
	.byte	0x24
	.byte	0
	.byte	0xb
	.byte	0xb
	.byte	0x3e
	.byte	0xb
	.byte	0x3
	.byte	0xe
	.byte	0
	.byte	0
	.byte	0x3
	.byte	0x24
	.byte	0
	.byte	0xb
	.byte	0xb
	.byte	0x3e
	.byte	0xb
	.byte	0x3
	.byte	0x8
	.byte	0
	.byte	0
	.byte	0x4
	.byte	0x2e
	.byte	0x1
	.byte	0x3f
	.byte	0x19
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0x11
	.byte	0x1
	.byte	0x12
	.byte	0x7
	.byte	0x40
	.byte	0x18
	.byte	0x96,0x42
	.byte	0x19
	.byte	0
	.byte	0
	.byte	0x5
	.byte	0x34
	.byte	0
	.byte	0x3
	.byte	0x8
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0x2
	.byte	0x18
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_aranges,"",@progbits
	.4byte	0x2c
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x8
	.byte	0
	.2byte	0
	.2byte	0
	.8byte	.Ltext0
	.8byte	.Letext0-.Ltext0
	.8byte	0
	.8byte	0
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF7:
	.string	"long long int"
.LASF14:
	.string	"main"
.LASF12:
	.string	"fib.c"
.LASF6:
	.string	"long unsigned int"
.LASF10:
	.string	"long long unsigned int"
.LASF1:
	.string	"unsigned char"
.LASF9:
	.string	"char"
.LASF5:
	.string	"long int"
.LASF3:
	.string	"short unsigned int"
.LASF0:
	.string	"signed char"
.LASF13:
	.string	"/home/liuguoquan/Compiler-Principles-2026/first_assignment/part1_gcc"
.LASF8:
	.string	"long double"
.LASF2:
	.string	"short int"
.LASF4:
	.string	"unsigned int"
.LASF11:
	.string	"GNU C17 10.2.0 -mcmodel=medany -march=rv64imafdc -mabi=lp64d -march=rv64imafdc -g -O0 -fno-pic"
	.ident	"GCC: (SiFive GCC-Metal 10.2.0-2020.12.8) 10.2.0"
