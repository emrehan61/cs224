#Self Modifying Code seeting must be opened from settings otherwise program will not assemble 
.data
 count1: .asciiz"\nAdd count is : "
 count2: .asciiz "\nOri count is: "
 count3: .asciiz "\nLw count is: "
 
.text
main:
	la $a0 ,main 	
	lw $s0,($a0)
	la $a1,instructionCount
	
	jal instructionCount
	
	move $s0,$v0
	move $s1,$v1 
	move $s2,$a1 
	
	addi $s2,$0,5
	addi $s1, $0,10
	add $s3,$s2,$s1
	add $s4,$s3,$s1
	add $s5, $s4,$s2
	
	
	
	la $a0,count1
	li $v0,4
	syscall
	
	la $a0,0($s0)
	li $v0,1
	syscall 
	
	la $a0,count2
	li $v0,4
	syscall
	la $a0, 0($s2)
	li $v0,1
	syscall 
	la $a0,count3
	li $v0,4
	syscall
	la $a0, 0($s1)
	li $v0,1
	syscall 
	
	la $a0 , instructionCount
	la $a1,end
	
	jal instructionCount
	
	move $s0,$v0
	move $s1,$v1 
	move $s2,$a1 
	
	
	la $a0,count1
	li $v0,4
	syscall
	
	la $a0,0($s0)
	li $v0,1
	syscall 
	
	la $a0,count2
	li $v0,4
	syscall
	la $a0, 0($s2)
	li $v0,1
	syscall 
	la $a0,count3
	li $v0,4
	syscall
	la $a0, 0($s1)
	li $v0,1
	syscall 
	
	li $v0,10
	syscall 

instructionCount:
	addi	$sp, $sp, -28
	sw	$s0, 24($sp)
	sw	$s1, 20($sp)
	sw	$s2, 16($sp)
	sw	$s3, 12($sp)
	sw	$s4, 8($sp)
	sw	$s5, 4($sp)
	sw	$s6, 0($sp)
	
	la	$s0, 0($a0) #holds adress of main
	la 	$s1, 0($a1) # holds adress of instructionCount	
	
	li $s2,0 #add counter
	li $s3,0 #lw counter
	li $s4,0 #ori counter
iterate:
	
	bge $s0,$s1,done
	
	lw $s5,($s0)
	srl $s6,$s5,26 # first 6 bits for opcode 
	sll $s7,$s5,26 # last 6 bits for func 
	srl $s7,$s7,26 # bring last 6 bits to least signigicant
	beq $s6,35,cLw #0x23 opcode of load word which is equal to 35 
	beq $s6,13,cOri# d hex is equal to 13 in decimal 
	beq $s6,0,cAdd1
	addi $s0,$s0,4
	j iterate
cLw:
	addi $s3,$s3,1#increment of load word 
	addi $s0,$s0,4#increment of adress 
	j iterate
cOri:
	addi $s4,$s4,1#increment of load word 
	addi $s0,$s0,4#increment of adress 
	j iterate
cAdd1:
	beq $s7,32,cAdd2 
	addi $s0,$s0,4
	j iterate
cAdd2:
	addi $s2,$s2,1
	addi $s0,$s0,4
	j iterate
done: 
	move	$v0, $s2			
	move	$v1, $s3
	move    $a1, $s4 			
	
	lw	$s6, 0($sp)
	lw	$s5, 4($sp)
	lw	$s4, 8($sp)
	lw	$s3, 12($sp)
	lw	$s2, 16($sp)
	lw	$s1, 20($sp)
	lw	$s0, 24($sp)
	addi	$sp, $sp, 28
	jr $ra 
end:
	
