.data

prompt: .asciiz "\nPlease enter a number 1-100000 or 0 to exit\n"
msg: .asciiz "Your number is "
bye: .asciiz "Thanks for playing! Have a great day." 
tooLowMsg: .asciiz "That number is too low. \n"
tooHighMsg: .asciiz "That number is too high. \n"

.text
main: 
enterNumber:
				li $a1, 100000 #### initialize max
				
				li $v0, 4
				la $a0, prompt #### get number
				syscall
				
				li $v0, 5
				syscall
				beqz $v0, exit
				bltz $v0, tooLow
				bgt $v0, $a1 tooHigh
				
				
				move $t0, $v0
				li $v0, 4
				la $a0, msg
				syscall
				
				li $v0, 1
				move $a0, $t0
				syscall
				b enterNumber
tooLow:
				li $v0, 4
				la $a0, tooLowMsg
				syscall
				b enterNumber
tooHigh:		
				li $v0, 4
				la $a0, tooHighMsg
				syscall
				b enterNumber
				
exit:
				li $v0, 4
				la $a0, bye
				syscall
				
				jr $ra
				
				
				
				
		
				
				

		