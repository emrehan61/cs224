.data 

inputa: .asciiz "Enter a: "
inputb: .asciiz "\NEnter b: "
num : .asciiz "denominator = 0"
.text 

main:
	la $a0, inputa
	li $v0 ,4 
	syscall 
	li $v0, 5 
	syscall 
	move $t0, $v0 #t0 a 
	
	la $a0, inputb
	li $v0 ,4 
	syscall 
	li $v0 ,5 
	syscall 
	move $t1, $v0 #t1 b 
	li $t2, 0 #iterate to 3 
	move $t3, $t0
	li $t4, 4 
	mult $t1, $t4 
	mflo $t4
	li $s0 , 3 #to check
	mult $t0 , $t0 
	mflo $t3 
	
	mult $t3,$t0 
	mflo $t3
	

	
	mult $t1,$t0 
	mflo $t5 # ab 
	add $t5 ,$t5, $t1 
	div $t5, $t0 
	mfhi $t6 
	beqz $t6 ,done
	div $t4 ,$t6 
	mflo $t7 
	
	sub $t8, $t3 , $t7 
	
	move $a0 ,$t8 
	li $v0 , 1 
	syscall 
	
	li $v0 ,10
	syscall 
done:
	la $a0, num
	li $v0 , 4
	syscall 
	
	li $v0,10
	syscall
