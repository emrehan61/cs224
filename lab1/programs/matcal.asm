
.data
askn1: .asciiz "Enter first number to calculatue (a*b)/(a+b) "
askn2: .asciiz "\nEnter first number to calculatue (a*b)/(a+b) "
res1: .asciiz "\nresult is: "
res2: .asciiz "\nremainder is : "

.text 

main:
	la $a0,askn1
	li $v0,4
	syscall
	
	li $v0,5
	syscall 
	
	move $t0,$v0 #a to t0 
	
	la $a0,askn2
	li $v0,4
	syscall
	
	li $v0,5
	syscall 
	
	move $t1,$v0 #b to t1 
	
	mult $t0,$t1
	mflo $t2 #result of multiplication
	
	add $t0 , $t0, $t1 
	
	div $t2, $t0
	
	mflo $t3 #quotient
	mfhi $t4 # remainder
	
	la $a0,res1
	li $v0,4
	syscall
	
	la $a0,($t3)
	li $v0,1
	syscall
	
	la $a0,res2
	li $v0,4
	syscall
	
	la $a0,($t4)
	li $v0,1
	syscall
	
	li $v0,10
	syscall