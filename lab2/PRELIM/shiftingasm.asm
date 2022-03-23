.data:
	asknumb: .asciiz "Enter Number to be shifted: "
	asknums: .asciiz "Enter shifting count: "
	printdec1: .asciiz "Number to be shifted () between 1 and 8 ): " #8 will make same value 
	printhexa: .asciiz "Shifted number in hexa: "
	printdec2: .asciiz "Shifted number in deicmal: "
	shiftrot: .asciiz "Enter shifting direction ( 0 to right, 1 to left): "
	pshift: .asciiz "Shifting direction is: "
.text 
	main:
	la $a0, asknumb
	li $v0,4
	syscall
	
	li $v0,5 
	syscall 
	
	move $s0,$v0 #number in s0 
	,
	la $a0,asknums
	li $v0,4
	syscall
	
	li $v0,5
	syscall
	
	move $a1, $v0 #shift amount in s1
	
	la $a0,shiftrot
	li $v0,4
	syscall
	
	li $v0,5
	syscall
	
	move $a3,$v0 #shifting direction 0 to right 1 to left 
	
	
	addi $a2,$a2,0
	,
	
	
	beqz $a3,shiftrightcircular
	beq $a3,1,shiftleftcircular
	
	shiftrightcircular:
		bge $a2,$a1,done
		srl $s4, $s0, 1
		sll $s0, $s0, 31
		or $s0, $s4, $s0
		
		addi $a2,$a2,1
		j shiftrightcircular
		
	
	
	
	shiftleftcircular:
		bge $a2,$a1,done
		sll $s4, $s0, 1
		srl $s0, $s0, 31
		or $s0, $s4, $s0
		
		addi $a2,$a2,1
		j shiftleftcircular
		
		
	
	
	done:
		move $v0,$s0
	
		move $a1,$v0 
	
		la $a0,printdec2
		li $v0,4
		syscall
		
		la $a0 ,($s0)
		li $v0,1
		syscall
		
		la $a0,printhexa
		li $v0,4
		syscall
		
		la $a0 ,($s0)
		li $v0,34
		syscall
		
		
		li $v0,10
		syscall
	
