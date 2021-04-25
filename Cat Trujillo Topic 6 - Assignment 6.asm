###################### MAIN PROGRAM FUNCTION #########################################
# Assignment #6: Sum Of Integers 1 - N Programmer: Cat Trujillo 
# Due Date: 4/19/20			Course: CSC 225 040
# Last Modified: 4/18/2020
######################################################################################
# Functional Description:
# This main program is used to test the function Sum(N)
# It will repeat the Sum(N) function 5 times, and print the result each time.
# list of arguments for N will be found data segment.
######################################################################################
# Pseudocode:
#   a1 = 5							# Initialize loop counter
#	*s1 = base address of array N 	# Initialize array pointer
# 	While (a1 > 0) do {
#		a1 = a1 - 1					# Decrement Loop Counter
#		s1 = s1 + 4 				# Increment array pointer
#		a0 = *s1                    # Load array value
#		cout << Sum(a0) << endl	}	# Output the result of Sum function
#   End Program 
######################################################################################
# Register Usage:
# $a0 = Used to pass the array value to Sum function
# $a1 = Loop Counter
# $s1 = Array pointer
######################################################################################
			.data			# Data declaration section
N:			.word 9, 10, 32666, 32777, 654321
newline:	.asciiz	"\n"

			.text			# Executable code follows
main:
	li		$a1, 5			# Initialize loop counter
	la		$s1, N 			# Initialize array pointer
loop:
	blez	$a1, End        # Exit program when counter reaches 0
	lw		$a0, 0($s1)		# load value from array
	jal 	Sum				# Call Sum Function
	 
								
	move	$a0, $v0		# Free up $v0 for syscall 
	li		$v0, 1			# System call code for print integer
	syscall					# print the reurn value of Sum
	
	li		$v0, 4			# System call code for print string
	la 		$a0, newline 	# load address of newline
	syscall					# Print newline
	
	addi 	$s1, $s1, 4		# Increment array pointer
	addi	$a1, $a1, -1	# Decrement Loop Counter
	b 		loop			# Branch to loop
	
End:
	li		$v0, 10			# Terminate program run and
	syscall					# return control to system
	
################### END OF MAIN PROGRAM ###########################################

################## SUM OF INTEGERS FUNCTION #######################################
# Function Name: Sum(N)         
# Last Modified: 4/18/2020
###################################################################################
# Function Description:
# This function will return the sum of integer values 1 - N, using the formula  
# SUM = (N * (N + 1)) / 2. Values for N will be passed from $a0, and the result  
# returned in $v0.  	
###################################################################################
# Register Usage in Function:
#	a0 = value for N
#	v0 = return value of Sum function
###################################################################################
# Pseudocode:
#	$v0 = $a0 + 1   # Value in parenthesis in SUM formula (n + 1)
#	$v0 = $v0 * $a0 # Multiply (n * (n + 1))
#	$v0 = $v0 / 2 	# Shift right 1
#	Return
###################################################################################

Sum:	
	addi	$v0, $a0, 1		# Get value in parenthesis
	
	mult	$v0, $a0		# Multiply
	mflo	$v0				# Store lower bits
	
	sra 	$v0, $v0, 1		# Divide by two
	
	jr		$ra				#return
###################### END SUM FUNCTION #######################################



		
	
	

	