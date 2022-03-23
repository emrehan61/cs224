
.data

array: .space 80
askkk: .asciiz "\n\n"
askkkk: .asciiz "enter number"
sizee: .word 0 
.text 
.globl main
	main:
		
		li $v0,5 
		syscall
		
		sw $v0,sizee
	 	la $t4 , array
	 
		jal carray
		la $t6 , ($t0)
		jal print 
		
		la $a0,askkk
		li $v0,4
		syscall
		
		jal swap 
		
		
		la $t4 , array
		
		jal print
		
		
		

		li $v0,10
		syscall
		
		
	carray:
		lw $t1, sizee
		
		la $t0, array
		addi $t3,$0,0
		getting:
			
			la $a0,askkkk
			li $v0,4
			syscall
			
			li $v0,5
			syscall
			
			sw $v0, 0($t0)	
			addi $t3,$t3,1
			addi $t0 ,$t0 ,4
			blt  $t3,$t1,getting
		la $t0, -4($t0)	
		jr $ra

	done:	
		
		jr $ra
	
	swap: 
		
		la $t3, array 
		swapItems:
		
			lw $t5,0($t0)
			lw $t7,0($t3)
		
			sw $t5, 0($t3)
			sw $t7,	0($t0)
		
			addi $t3, $t3,4
		
			subi $t0, $t0,4
		
			bgt $t0, $t3, swapItems
		jr $ra 
	
	print: 
		bgt $t4,$t6,done
		
		lw $a0 , 0($t4)
		li $v0, 1
		syscall 
		addi $t4,$t4,4
		j print 


