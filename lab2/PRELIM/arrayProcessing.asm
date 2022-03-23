.data:
	asksize: .asciiz "Enter the size of array: "
	askelement: .asciiz "Array Element: "
	sum: .asciiz "Sum of elements is: "
	max: .asciiz "Max element is: "
	min: .asciiz "Min element is: "
	pal: .asciiz "Palindrome(0 = false, 1 = true): "
	
.text
	main:
		jal createArray
		subi $s1 ,$s1 ,4
		jal arrayOperations
		
		addi $s7,$v0,0
		la $a0,sum
		li $v0,4
		syscall
		la $a0, ($s6)
		li $v0,1
		syscall
		la $a0,max
		li $v0,4
		syscall
		la $a0, ($s4)
		li $v0,1
		syscall
		la $a0,min
		li $v0,4
		syscall
		la $a0, ($s5)
		li $v0,1
		syscall
		la $a0,pal
		li $v0,4
		syscall
		la $a0, ($s7)
		li $v0,1
		syscall
		li $v0,10
		syscall
		#base adress of array s1
		#size of array s0 
	createArray:
		la $a0,asksize
		li $v0,4
		syscall 
		
		li $v0,5
		syscall 
		
		move $s0,$v0 #size of array
		
		la $a0,($s0)
		li,$v0,9
		syscall
		
		move $s1, $v0  #adress of array 
		addi $s2,$s2,0 # iterator 
		iterateArray:
			beq $s2,$s0,return 
			la $a0,askelement
			li $v0,4
			syscall 
			
			li $v0,5
			syscall 
			
			sw $v0 , 0($s1)
			addi $s2,$s2,1
			addi $s1 ,$s1 ,4
			j iterateArray
		
		
	arrayOperations:
		#dueing the process array creation now we are at the end of the array adress vise 
		addi $s3 ,$s0 ,0 #to iretare over array again 
		addi $v0,$v0,0
		maxf:
			lw $s2,($s1)
			bgt $s2,$v0,setMax	
			subi $s1,$s1,4
			subi $s3 , $s3,1
			bgt $s3, $0 ,maxf
		returnmax:
			move $s4,$v0 #s4 to hold max
			addi $s1,$s1,4
		minf: 
			lw $s2,($s1)
			blt $s2,$v0,setMin 
			addi $s1,$s1,4
			addi $s3 , $s3,1
			blt $s3,$s0,minf
		
		returnmin:
			move $s5,$v0 #s5 to hold min
			la $s2, ($s1) #to hold last value of array for palindrome 
			subi $s1,$s1,4
		sumf:
			li $v0,0
			calculate:
				lw $s6,($s1)
				add $v0,$s6,$v0 
				subi $s1,$s1,4
				subi $s3,$s3,1
				bgt $s3,$0,calculate
			move $s6,$v0 #s6 to hold sum 
		checkpal:
			addi $sp,$sp,-12
			sw $s4,0($sp)# save them into stack to make them avaible during process 
			sw $s5, 4($sp)
			sw $s6,8($sp)
			li $s6,2
			div $s0 , $s6
			mflo $s6
			addi $v0,$0,1
			beqz $s6,return
			beq $s6,$v0,return
			subi $s2, $s2,4
			addi $s1,$s1,4
			checkpal2:
				lw $s4,($s2)
				lw $s5, ($s1)
				bne $s4,$s5,notPalindrome
				
				addi $s1,$s1,4
				subi $s2,$s2,4
				addi $s3 , $s3,1
				blt $s3,$s6,checkpal2
				li $s6, 1 
				move $v0 ,$s6 
				lw $s4,0($sp)# reload results
				lw $s5, 4($sp)
				lw $s6,8($sp)
				addi $sp,$sp,12
				jr $ra 
			
	return:
	
		jr $ra
	setMax:
		move $v0, $s2 
		subi $s1,$s1,4
		subi $s3 , $s3,1
		bgt $s3, $0 , maxf
		j returnmax
	setMin:
		move $v0,$s2 
		addi $s1,$s1,4
		addi $s3 , $s3,1
		blt $s3,$s0,minf
		j returnmin
	notPalindrome:
		move $v0,$0
		lw $s4,0($sp)# reload results
		lw $s5, 4($sp)
		lw $s6,8($sp)
		addi $sp,$sp,12
		jr $ra