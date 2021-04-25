###################################################################################
# Assignment #7: FINAL EXAM Programmer: CAT TRUJILLO 
# Due Date: 5/10/20			Course: CSC 225 040
# Last Modified: 5/4/2020
###################################################################################
.data
############## MEAN_TOTAL DATA #################################################### 

msgPrompt: .asciiz "Please enter 4 numbers."
average: .asciiz "\nThe average is "
total: .asciiz "The total is "

############## STRING_REVERSE DATA ################################################

strPrompt: .asciiz "\nEnter a string smaller than 25 characters. "

string: .space 25
reverse: .space 25

############## MAIN FUNCTION ######################################################
.text

main:
	jal 	meanTotal					# call MEAN_TOTAL 
	jal 	stringReverse				# call STRING_REVERSE
	
	li 		$v0, 10						# syscall for system exit
	syscall								# system exit

############ MEAN_TOTAL FUNCTION ##################################################
# Type: void
# Args: no-args
# Purpose: Prompts user for 4 integers; outputs the total and average of integers
###################################################################################
# Register Usage:
#   $s0 - store return address to main
#   $t1 - calculate sum and average
#   $t2 - loop counter
#   $a0 - syscall 
#   $v0 - syscall
####################################################################################
# PseudoCode:
# t1 = 0
# t2 = 4
# cout << msgPrompt
# while (4 > 0):
#      cin > v0
#      t1 += v0
#      t2--
# move a0, t1
# cout << total + a0
# 
# t1 / 4
# move a0, t1
# cout << average + a0
# return to main	 
####################################################################################
meanTotal:

		move 	$s0, $ra				# store return address to main function
		
		addu 	$t1, $zero, $zero		# initialize total
		addu 	$t2, $t2, 4				# initialize loop counter

		li 		$v0 4					# syscall for print string
		la 		$a0 msgPrompt			# load address of msgPrompt
		syscall							# print string

		jal 	loop					# go to loop


		li 		$v0 4					# syscall for print string
		la 		$a0, total				# load address of total
		syscall							# print string

		li 		$v0, 1					# syscall for print integer
		move 	$a0, $t1				# load sum into a0
		syscall							# print integer

		li 		$v0 4                   # syscall for print string
		la 		$a0, average			# load address of average
		syscall							# print string

		sra 	$a0, $t1, 2				# divide sum by 4
		li 		$v0, 1					# syscall for print integer 
		syscall							# print integer

		jr 		$s0 					# return to main function

loop:
		li 		$v0 5					# syscall for read integer	
		syscall							# read integer
		addu 	$t1, $t1, $v0			# add input to sum
		addi 	$t2, $t2, -1			# decrement loop counter
		bnez 	$t2, loop				# go to loop
		jr 		$ra						# return to MEAN_TOTAL
		
###################### STRING_REVERSE FUNCTION ########################################
# Type: void
# Args: no-args
# Purpose: Prompts user for a string. Output the string in reverse.
#######################################################################################
# Register Usage:
#   $s0 - store return address to main
#   $a1 - max characters
#   $t0 - string
#   $t1 - length of string
#   $t2 - pointer offset value
#   $t3 - string pointer
#   $t4 - store character
#   $a0 - syscall
#   $v0 - syscall
#######################################################################################
# Pseudocode:
#	cout << strPrompt
#   t0 = cin >> string 
#   t1 = lenth(string)
#   do while (t4 > 0) 
#  		t3 = &string + t2
#   	t4 = MEM(t3 +0)
#   	MEM(reverse + t1) = t4
#   	$t1--
#   	$t2++
#   cout << reverse
#   return to main program
#######################################################################################   
stringReverse:
	move 	$s0, $ra				# store return address to main
	add 	$t1, $zero,$zero    	# initialize t1 - length
	add 	$t2, $zero, $zero		# initialize string pointer offset value

	li 		$v0, 4					# syscall for print string
	la 		$a0, strPrompt			# load address of strPrompt
	syscall							# print string

	li 		$v0, 8					# syscall for read string
	la 		$a0, string				# store input in string 	
	li 		$a1, 25					# up to 25 characters
	syscall							# read string

	jal 	length					# go to length(string)

	move 	$t0, $a0     			# store string address 
	move 	$t1, $v0      			# store length

reverseString:
	add 	$t3, $t0, $t2			# set string pointer 	
	lb		$t4, 0($t3)				# get character
	beqz	$t4, print				# if char = null-byte, go to print
	sb		$t4, reverse($t1)		# store character at reverse + length
	addi	$t1, $t1, -1			# decrement length
	addi	$t2, $t2, 1				# increment offset value
	j		reverseString			# go to reverseString

print:
	li		$v0, 4					# syscall for print string
	la		$a0, reverse    		# load address of reverse
	syscall							# print string
	
	jr 		$s0						# return to main program
	
################### LENGTH(string) FUNCTION ###########################################
# Type:  int
# args: string $a0
# Purpose: returns the length of (string $a0) in $v0
#######################################################################################
# Register Usage:
#	$a0 - address of string
#   $v0 - return value = length
#   $t1 - string pointer
#   $t0 - string charachter 
#######################################################################################
# Pseudocode:
# 	v0 = -1
#   *t1 = a0
#   do while(t0 > 0)
#		t0 = MEM(t1 + 0)
#       t1++
#       v0++
#   v0 = v0 -1
#   return to STRING_REVERSE
########################################################################################
length:
	li 		$v0, -1					# Set v0 = -1
	move 	$t1, $a0				# Store string address in t1

lengthLoop:
	lb 		$t0, 0($t1)				# Get Character
	addi 	$t1, $t1, 1				# Increment string pointer
	addi 	$v0, $v0, 1				# Increment length
	bnez 	$t0, lengthLoop			# go to lengthLoop if character !null-byte

	addi 	$v0, $v0, -1			# I put this here because my length was off by one
	jr 		$ra						# return to STRING_RESPONSE

########################################################################################

