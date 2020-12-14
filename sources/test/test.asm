.text
main:	addi	$t1, $0, 5
	addi	$t2, $0, 6
	jal	Test1		# ALU Test
	jal	Test2		# Memory Test
	j	Test3		# Jump and Branch Test
	
Test1:	div	$t2, $t1	# ALU Test
	mult	$t1, $t2
	add	$t5, $t1, $t2
	addu	$t6, $t1, $t2
	addiu	$t7, $t1, 34	# addi has already been tested
	sub	$t5, $t1, $t2
	subu	$t6, $t1, $t2
	mfhi	$t3
	mflo	$t4
	and	$t5, $t1, $t4
	andi	$t6, $t1, 30
	or	$t5, $t1, $t4
	ori	$t6, $t1, 30
	xor	$t5, $t1, $t4
	xori	$t6, $t1, 30
	nor	$t5, $t1, $t4
	addi	$t4, $0, -10
	div	$t4, $t1
	mult	$t4, $t1
	slt	$t5, $t1, $t2
	sltu	$t6, $t1, $t4
	slti	$t7, $t1, -1
	sll	$t1, $t1, 17
	sltiu	$t8, $t1, -1
	srl	$t5, $t4, 2
	sra	$t6, $t4, 2
	sllv	$t5, $t4, $t2
	srlv	$t6, $t4, $t2
	srav	$t7, $t4, $t2
	jr	$ra
	
Test2:	sw	$t1, 0x0($0)	# Memory Test
	sw	$t2, 0x4($0)
	lw	$t5, 0x0($0)
	lw	$t6, 0x4($0)
	jr	$ra
	
Test3:	beq	$t3, $0, label1	# Jump and Branch Test
	addi	$t5, $0, 16
label1:	bne	$t1, $t2, label2
	addi	$t5, $0, 16
label2: beq	$t1, $t2, label3
	addi	$t6, $0, 17
label3: bne	$t3, $0, label4
	addi	$t6, $0, 18
label4:	addi	$a0, $0, 10

Exit:	syscall
