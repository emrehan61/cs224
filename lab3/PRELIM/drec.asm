.text		
	

start:
	start2:
	la $a0, divided
	li $v0, 4
	syscall
		
	li $v0, 5	
	syscall
	add $s0, $0, $v0
	
	la $a0, nl
	li $v0, 4
	syscall
	
	la $a0, divider
	li $v0, 4
	syscall
	
	li $v0, 5	
	syscall
	add $s1, $0, $v0
	
	la $a0, nl
	li $v0, 4
	syscall
	
	move $a0, $s0
	move $a1, $s1
	add $v0, $0, $0
	jal recursiveDivision  
	add $s2, $v0, $0
	
	la $a0, result
	li $v0, 4
	syscall
	
	li $v0, 1
	move $a0, $s2
	syscall
	
	la $a0, nl
	li $v0, 4
	syscall	
	
	la $a0, menu
	li $v0, 4
	syscall
	
	li $v0, 5	
	syscall
	add $s3, $0, $v0
	
	la $a0, nl
	li $v0, 4
	syscall	
	
	beq $s3, 1,start2 
	
	li $v0,10  
	syscall	
recursiveDivision:
	addi $sp, $sp, -12 # allocate 12 byt
	sw $s0, 8($sp) 
	sw $a0, 4($sp) 
	sw $ra, 0($sp) #load current ra adress  for jal 
	
	slt $s0, $a0, $a1
	beq $a0, $a1, equal
	bne $s0, $0, end
	equal:
	sub $a0, $a0, $a1
	add $v0, $v0, 1	
	jal recursiveDivision
	end:
	
	lw $ra, 0($sp)#load ra to go back to main program 
	lw $a0, 4($sp) 
	lw $s0, 8($sp)
	addi $sp, $sp, 12 
	
	jr $ra
	
	



.data
result: .asciiz "Result:  "	
menu: .asciiz "To continue enter 1 else any integer: "
divided: .asciiz "To be divided: "
divider: .asciiz "To be divider:  "
ws: .asciiz " "
nl: .asciiz "\n"
