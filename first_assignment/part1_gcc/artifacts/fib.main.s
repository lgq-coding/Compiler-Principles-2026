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
