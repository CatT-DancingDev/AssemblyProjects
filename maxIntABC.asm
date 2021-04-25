################################ Main Program Header#############################################
.data

.data

promptMax: .asciiz "Please enter a number \n"
maxMsg: .asciiz "The largest number is "

.text
maxMain: 
				li $v0, 4
				la $a0, promptMax #### get 1st number
				syscall
				
				li $v0, 5
				syscall
				move $t0, $v0
				
				li $v0, 4
				la $a0, promptMax   #### get 2nd number
				syscall
				
				li $v0, 5
				syscall
				move $t1, $v0
				
				li $v0, 4
				la $a0, promptMax ### get 3rd number
				syscall
				
				li $v0, 5
				syscall
				move $t2, $v0
				jal max    ### Go to max
				
				move $t0, $v0 ### move return value to temp
				
				li $v0, 4
				la $a0, maxMsg  ### load output result message
				syscall
				
				move $a0, $t0   ### load function return value
				li $v0, 1
				syscall
				
				li $v0, 10
				syscall
				
max:			bge $t0, $t1, compA
				blt $t0, $t1, compB
compA:			bge $t0, $t2, returnA
				blt $t0, $t2, returnC
compB:			bge $t1, $t2, returnB
				blt $t1, $t2, returnC
returnA: 		move $v0, $t0
				jr $ra
returnB: 		move $v0, $t1
				jr $ra
returnC: 		move $v0, $t2
				jr $ra