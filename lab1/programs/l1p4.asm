.data

array1: .space 400 
size: .asciiz "\nEnter the size of array: "
input: .asciiz "\nEnter input for option: "
elements: .asciiz "\n Enter the elements of the array: "
afm: "\nchoose one of the operations (a,b,c,d): "
opa: .asciiz "\nSum of numbers(smaller than): "
opb: .asciiz "\nOdd Numbers: "
opb2: .asciiz "      Even Numbers: "
opc: .asciiz"\n Number of nondivisible: "
qq: .asciiz "Quitting"
aa: .asciiz "a"
bb: .asciiz "b"
cc: .asciiz "c"
qu: .asciiz "d"
iszero: .asciiz "denominator is zero error"
.text 

main: 
	lb $s1,aa
	lb $s2,bb
	lb $s3,cc
	lb $s4,qu
	la $a0,size 
	li $v0,4
	syscall 
	
	li $v0,5 
	syscall 
	
	move $s0, $v0 #s0 is size of array 
	
	
	jal createArray 
	jal menuiter
createArray:
	move $t0,$s0 #save size for iteration control
	li $t1, 0 #0 to size, iteration 
	la $t2, array1 
	
	la $a0, elements 
	li $v0, 4 
	syscall
	loop:	
		li $v0,5 
		syscall 
		sw $v0,($t2)
		addi $t2,$t2,4
		addi $t1,$t1,1
		bge $t1, $t0, done
		j loop
done: 
	jr $ra 
	
opta:
	la $a0, input 
	li $v0,4
	syscall
	
	li $v0, 5 
	syscall 
	move $t3, $v0 
	la $t2,array1 
	li $t4, 0 #index iteration 
	li $t5,0 #sum
	 iterateforsum:
	 	
	 	lw $t6,0($t2)
	 	blt  $t6, $t3,addif
	 	
	 	addi $t2,$t2,4
	 	addi $t4,$t4,1	
	 	blt $t4,$s0,iterateforsum
	 	
	 		
	 la $a0,opa
	 li $v0,4
	 syscall 
	 
	 la $a0,($t5)
	 li $v0,1
	 syscall 
	 j menuiter
	
optb:
	la $t2,array1 
	li $t4, 0 #index iteration 
	li $t1, 0 #odd 
	li $t3,0 #even
	li $t7,2 #to div 
	li $t8,1 
	iterateforoddeven:
		lw $t6,0($t2)
	 	div $t6,$t7
	 	mfhi $t5
	 	beq $t5 ,$t8 ,addforodd
	 	beq $t5, $0 , addforeven 
	 	addi $t2,$t2,4
	 	addi $t4,$t4,1	
	 	blt $t4,$s0,iterateforoddeven
	
	bbb:
		
 	la $a0,opb
	 li $v0,4
	 syscall 
	 
	 la $a0,($t1)
	 li $v0,1
	 syscall 
	 
	 la $a0,opb2
	 li $v0,4
	 syscall 
	 
	 la $a0,($t3)
	 li $v0,1
	 syscall 
	 j menuiter
	
optc:
	la $a0,input
	li $v0,4
	syscall 
	li $v0,5
	syscall
	move $t3,$v0 #t3 is int to be checked 
	beqz $t3, itiszero
	la $t2,array1
	li $t4,0 #index 
	li $t5,0 #counting non ivisibles
	
	iteratefordiv:
		lw $t6 , 0($t2)
		div $t6, $t3
		mfhi $t7 
		bnez $t7,addfornd
		addi $t4,$t4,1
		addi $t2,$t2,4
		blt $t4,$s0,iteratefordiv
	ccc:
	la $a0 ,opc 
	li $v0,4
	syscall 
	
	la $a0,($t5)
	li $v0,1
	syscall 
	j menuiter
optq:
	la $a0,qq
	li $v0,4
	syscall
	
	li $v0,10
	syscall 
 menuiter:
 	la $a0, afm 
 	li $v0,4
 	syscall 
 	li $v0, 12 
 	syscall 
 	
 	move  $t7,$v0
 	beq $t7,$s1,opta
 	beq $t7,$s2,optb
 	beq $t7,$s3,optc
 	beq $t7,$s4,optq
 	j menuiter

addif:
	 		add $t5, $t5, $t6
	 		addi $t2,$t2,4
	 		addi $t4,$t4,1	
	 		j iterateforsum 
addforodd:
	addi $t1,$t1,1
	addi $t2,$t2,4
	 addi $t4,$t4,1	
	 blt $t4,$s0,iterateforoddeven
	 j bbb
addforeven:
	addi $t3,$t3,1
	addi $t2,$t2,4
	 addi $t4,$t4,1	
	 blt $t4,$s0,iterateforoddeven
	 j bbb
addfornd:
	addi $t5,$t5,1
	addi $t2,$t2,4
	 addi $t4,$t4,1	
	 blt $t4,$s0,iteratefordiv
	 j ccc
	
itiszero:
	la $a0, iszero
	li $v0 ,4 
	syscall
	j menuiter
