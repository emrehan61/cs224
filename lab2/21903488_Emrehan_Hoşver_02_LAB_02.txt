.data:
	asksize: .asciiz "Enter the size of array: "
	askelement: .asciiz "Array Element: "
	arrayIs: .asciiz "Sorted Array is: "
	whiteSpace: .asciiz "\t"
	wsa: .asciiz " "
	indexof: .asciiz "\nIndex of element: "
	dataof: .asciiz "\t Data: "
	digitsum: .asciiz "\t Digit Sum: "
	error: .asciiz "\nIndex out of bond "
	
.text
	main:
		jal createArray
		jal bubbleSort
		li $v0,10
		syscall
createArray:
		la $a0,asksize
		li $v0,4
		syscall 
		
		li $v0,5
		syscall 
		
		move $a1,$v0 #size of array
		
		la $a0,($a1)
		li,$v0,9
		syscall
		
		move $s1, $v0  #adress of array to iterate
		move $s7, $s1 #adres of array forever
		addi $s2,$s2,0 # iterator 
		iterateArray:
			beq $s2,$a1,return 
			la $a0,askelement
			li $v0,4
			syscall 
			
			li $v0,5
			syscall 
			
			sw $v0 , 0($s1)
			addi $s2,$s2,1
			addi $s1 ,$s1 ,4
			j iterateArray
return:
	jr $ra
bubbleSort: 
	subi $sp, $sp, 4 
	sw $a1, 0($sp)#holds zize
	beq $a1, 1, continue #if array size is 1 jum back to $ra 
	beq $a1,0,done #if array size is 0 jump back to $ra 
	bsort:
		li $s0, 1 #index
		move $s1, $s7 #adress
		iswap:
			lw $s2, 0($s1) #compare 1
			lw $s3, 4($s1) # compare 2 
			ble $s2, $s3, nswap #s2<s3 it is ok 
			sw $s2, 4($s1) # swap them 
			sw $s3, 0($s1) 
			nswap: #s2<s3 go to iswap 
				addi $s1, $s1, 4 #adress + 4 
				addi $s0, $s0, 1#index + 1 
				blt $s0, $a1, iswap
		subi $a1, $a1, 1 
		bgt $a1, 1, bsort #continue sort 
	continue:
		lw $a1, 0($sp) #reload
		addi $sp, $sp, 4 #reallocate
		j printarray#jump to coninuing tasks if array size is >= 1 
	done:
		lw $a1, 0($sp) #reload
		addi $sp, $sp, 4#reallocate
		jr $ra #finish program if array size is 0 

		
	

printarray: 
	move $s1, $s7 
	addi $s2, $0,0
	
	la $a0, arrayIs
	li $v0 , 4
	syscall 
	
	iterate:
		bge $s2,$a1,arrayop 
		lw $a0 , ($s1)
		li $v0,1
		syscall 
		la $a0, wsa
		li $v0 , 4
		syscall 
		
		addi $s2,$s2,1
		addi $s1,$s1,4
		j iterate
	
arrayop:
	
	
	move $s1, $s7 
	addi $s2, $0,0
	
	getElement:
		bge $s2,$a1,return
		blt $s2 , $a1 , calc
		addi $s2,$s2,1
		addi $s1,$s1,4
		j getElement
error1:
	la $a0,error
	li $v0,4
	syscall 
	
	j arrayop
calc:
	
	lw $s3, ($s1)
	addi $s4,$0,0 #sum
	addi $s6,$0,10
	findOut:
		div $s3,$s6 #divide number by 10 
		mfhi $s5
		mflo $s3
		#add $s4,$s4,$s3 #adding remainder if number is > 10 
		add $s4,$s4,$s5 #add number itself ot the sum if number is < 10 
	
		bne $s3,0,findOut
		
	
	la $a0, indexof
	li $v0 ,4
	syscall
	
	la $a0,($s2)
	
	li $v0,1
	syscall
	
	la $a0, dataof
	li $v0 ,4
	syscall
	
	lw $a0,($s1)
	li $v0,1
	syscall
	
	
	la $a0, digitsum
	li $v0 ,4
	syscall
	
	la $a0,($s4)
	li $v0,1
	syscall
	
	
	addi $s2,$s2,1
	addi $s1,$s1,4
	
	j getElement
