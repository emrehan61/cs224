.data 

array: .space 80 
ask1: .asciiz "enter size of array: "
ask2: .asciiz "\n Enter the elements of array: \n"
ask3: .asciiz "number: "
eqq: .asciiz "equal"
neqq: .asciiz "not equal"
size: .word 0

.text

  main: 
  
  	la $a0, ask1
  	li $v0, 4 
  	syscall 
  	
  	li $v0, 5 
  	syscall
  	sw $v0, size #t0 size 
  	lw $t0 , size
  	jal carray
  	
  	jal checkEq
  	
  	lw $a0, ($t6)
  	li $v0, 1 
  	syscall
  	
  	lw $a0, ($t3)
  	li $v0, 1 
  	syscall
  	
  	li $v0, 10 
  	syscall
  	
  	
  carray:
  	
  	la $t1, array
  	addi $t2, $0,0 #iterator
  	
  	la $a0,ask2
	li $v0,4
	syscall
		
  	getting:
  		la $a0,ask3
		li $v0,4
		syscall
			
		li $v0,5
		syscall
			
		sw $v0, 0($t1)	
		addi $t2,$t2,1
		addi $t1 ,$t1 ,4
		blt  $t2,$t0,getting
	la $t1, -4($t1)	
	jr $ra


equal: 
	la $a0,eqq
	li $v0,4
	syscall
	jr $ra	
nequal: 
	la $a0,neqq
	li $v0,4
	syscall
	jr $ra
checkEq: 
	
	li $t7,2
	div $t0,$t7
	mfhi $t4 
	mflo $t5 
	
	startc:
		beq $t4, $0, eeq
		bne $t4,$0,nnq
		
eeq: 
	la $t3,array 
	sll $t5,$t5,2
	ss1:	
		add $t6, $t3,$t5 
		lw $t2, ($t6)
		lw $t4, ($t3)
		beq $t6, $t1,lastc 
		
		beq $t4,$t2,ss2
		bne $t6,$t3,nequal
	ss2:
		la $t3, 4($t3)
		j ss1 
		
	
nnq:
	la $t3,array 
	add $t5,$t5,$t4
	sll $t5,$t5,2

	ss3:	
		add $t6,$t3,$t5
		lw $t2, ($t6)
		lw $t4, ($t3)
		beq $t6 ,$t1,lastc
		
		beq $t4,$t2,ss4
		bne $t4,$t2,nequal 
	ss4:
		la $t3, 4($t3)
		j ss3 	

lastc: 
	lw $t2, ($t6)
	lw $t4, ($t3)	
	beq $t4,$t2,equal
	bne $t4,$t2,nequal
	 
 
