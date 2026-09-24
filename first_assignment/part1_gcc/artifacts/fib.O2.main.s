main:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s3,8(sp)
	sd	s0,32(sp)
	sd	s1,24(sp)
	sd	s2,16(sp)
	call	getint
	mv	s3,a0
	li	a0,0
	call	putint
	li	a0,10
	call	putch
	li	a0,1
	call	putint
	li	a0,10
	call	putch
	li	a5,1
	ble	s3,a5,.L2
	li	s1,1
	li	s0,1
	li	a5,0
.L3:
	mv	s2,s0
	addw	s0,a5,s0
	mv	a0,s0
	call	putint
	li	a0,10
	call	putch
	addiw	s1,s1,1
	mv	a5,s2
	bne	s3,s1,.L3
.L2:
	ld	ra,40(sp)
	ld	s0,32(sp)
	ld	s1,24(sp)
	ld	s2,16(sp)
	ld	s3,8(sp)
	li	a0,0
	addi	sp,sp,48
	jr	ra
	.size	main, .-main
	.ident	"GCC: (SiFive GCC-Metal 10.2.0-2020.12.8) 10.2.0"
