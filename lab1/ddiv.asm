.data 

aska: .asciiz "Enter A "
askb: .asciiz "Enter B "
askc: .asciiz "Enter c "
pdiv: .asciiz "Quatient: "
pdiv2: .asciiz "\nRemainder: "

.text
#t0 = a t1 = b t2 = c 
	la $a0 ,aska
	li $v0 , 4
	syscall 
	
	li $v0,5
	syscall 
	
	move $t0, $v0
	
	la $a0 , askb
	li $v0 , 4
	syscall 
	
	li $v0,5
	syscall 
	
	move $t1, $v0
	
	la $a0 , askc
	li $v0 , 4
	syscall 
	
	li $v0,5
	syscall 
	
	move $t2, $v0
	
	sub $t4 , $t1,$t2 
	move $t5, $t4
	li $t3 , 0 
	jal muli
	li $t3 , 0 
	li $t5,16
	
	jal calc
	
	la $a0 , pdiv
	li $v0 , 4
	syscall 
	
	la $a0 , ($t3)
	li $v0 , 1
	syscall 
	
	la $a0 , pdiv2
	li $v0 , 4
	syscall 
	
	la $a0 , ($t4)
	li $v0 , 1
	syscall 
	
	li $v0,10
	syscall 
	
muli:	
	
	mul $t4, $t4,$t0 
	jr $ra
	
calc:
	bge $t4, $0, calcip
	blt $t4,$0,calcin
	calcip:
		ble $t4,$0,donefp
		sub $t4, $t4,$t5
		addi $t3,$t3,1
		j calcip
	calcin:
		bgt $t4,$0,donefn
		add $t4,$t4,$t5
		addi $t3,$t3,1
		j calcin
	
done: 
	
	jr $ra 
	
donefn:
	beq $t4,$0,done
	subi $t3,$t3,1
	sub $t4,$t4,$t5
	j done
donefp:
	beq $t4,$0,done
	subi $t3,$t3,1
	add $t4,$t4,$t5
	j done