    .text
    .align 1
    
    .globl is_even
    .type is_even, @function
is_even:
    li      t0, 2
    remw    t1, a0, t0        
    seqz    a0, t1            
    ret
    .size is_even, .-is_even

    .globl gcd
    .type gcd, @function
gcd:
.L_gcd_cond:
    beqz    a1, .L_gcd_end    
    remw    t0, a0, a1        
    mv      a0, a1            
    mv      a1, t0            
    j       .L_gcd_cond
.L_gcd_end:
    ret                       
    .size gcd, .-gcd

    .globl main
    .type main, @function
main:
    addi    sp, sp, -64
    sd      ra, 56(sp)
    sd      s1, 48(sp)
    sd      s2, 40(sp)
    sd      s3, 32(sp)
    sd      s4, 24(sp)
    sd      s5, 16(sp)
    sd      s6, 8(sp)

    call    getint
    mv      s1, a0            
    li      s2, 1             
    li      s3, 0             

.L_main_while_cond:
    sext.w  t0, s2
    sext.w  t1, s1
    bgt     t0, t1, .L_main_while_end 

.L_main_while_body:
    li      t0, 4
    sext.w  t1, s2
    bne     t1, t0, .L_main_not_4
    addiw   s2, s2, 1
    j       .L_main_while_cond
.L_main_not_4:

    li      t0, 6
    sext.w  t1, s2
    beq     t1, t0, .L_main_while_end

    sext.w  t1, s2
    blez    t1, .L_main_if_end 
    
    mv      a0, s2
    call    is_even
    beqz    a0, .L_main_if_end 

    addw    s3, s3, s2

.L_main_if_end:
    addiw   s2, s2, 1
    j       .L_main_while_cond

.L_main_while_end:
    addiw   s4, s1, 3
    
    li      t0, 2
    mulw    t1, s1, t0        
    addiw   s5, t1, 1

    addw    t0, s4, s5        
    li      t1, 2
    mulw    t1, t0, t1        
    
    li      t0, 2
    divw    t2, s4, t0        
    
    li      t0, 3
    remw    t3, s5, t0        
    
    subw    t0, t1, t2        
    addw    s6, t0, t3        

    mv      a0, s4
    mv      a1, s5
    call    gcd
    mv      s4, a0            

    mv      a0, s3
    call    putint
    li      a0, 10
    call    putch

    mv      a0, s6
    call    putint
    li      a0, 10
    call    putch

    mv      a0, s4
    call    putint
    li      a0, 10
    call    putch

    li      a0, 0
    
    ld      ra, 56(sp)
    ld      s1, 48(sp)
    ld      s2, 40(sp)
    ld      s3, 32(sp)
    ld      s4, 24(sp)
    ld      s5, 16(sp)
    ld      s6, 8(sp)
    addi    sp, sp, 64
    ret
    .size main, .-main
