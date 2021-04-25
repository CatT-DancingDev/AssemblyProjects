
###################################################################################
# Assignment #7: Various Functions Programmer: Cat Trujillo 
# Due Date: 5/3/20			Course: CSC 225 040
# Last Modified: 4/26/2020
###################################################################################
.data

############ MAX FUNCTION ####################### 
promptMax:	.asciiz "Please enter a number \n"
maxMsg: 	.asciiz "The largest number is "

############ CELSIUS FUNCTION ###################
promptCelsius:	.ascii	"\nPlease enter the temperature "
				.asciiz		"in Celcius. \n"
tempOut: 		.asciiz " degrees Farenheit"
		
doubleMult: 	.double 1.8
doubleAdd: 		.double 32.0

############ NUMBER-PROMPT FUNCTION ############
promptInt:	.asciiz "\nPlease enter a number 1-100000 or 0 to exit\n"
msg: 		.asciiz "Your number is "
bye: 		.asciiz "Time for the next function!" 
tooLowMsg: 	.asciiz "That number is too low. \n"
tooHighMsg: .asciiz "That number is too high. \n"

############ INTEREST CALCULATOR ############
getPrinciple:	.asciiz "\nPlease enter the starting balance. \n"
getRate: 		.asciiz "\nPlease enter the interest rate.\n"
getYears: 		.asciiz "\nPlease enter the number of years interest will accrue. \n"
outputResult: 	.asciiz "Ending balance with interest: $"

double1: 		.double 1.0
double100: 		.double 100.0

############## MAIN PROGRAM ##################

.text
main:

jal maxMain
jal celsiusConvert
jal enterNumber
jal interestCalculator

li $v0, 10
syscall

#################### MAX MAIN ####################
# Purpose: Stores user input for MAX (a1,a2, a3)
# Function Calls: Calls MAX(a1,a2, a3)
##################################################
maxMain: 
		li $v0, 4				# system call code for print string
		la $a0, promptMax 		# load address of promptMax
		syscall					# print string
				
		li $v0, 5				# system call code for read integer
		syscall					# read integer
		move $a1, $v0			# Store 1st input in $a1
				
		li $v0, 4				# system call code for print string
		la $a0, promptMax   	# load address of promptMax
		syscall					# print string
				
		li $v0, 5				# system call code for read integer
		syscall					# read integer
		move $a2, $v0			# Store 2nd input in $t1
				
		li $v0, 4				# system call code for print string
		la $a0, promptMax 		# load address of promptMax
		syscall					# print string
				
		li $v0, 5				# system call code for read integer
		syscall					# read integer
		move $a3, $v0			# Store 3rd input in $a3
		
		move $s0, $ra 			# Store return address to main
		jal max    				# Go to max(a1, a2, a3)

		move $t0, $v0 			# temp store return value
				
		li $v0, 4				# system call code for print string
		la $a0, maxMsg          # load address of maxMsg
		syscall					# print string
				
		move $a0, $t0   		# load function return value
		li $v0, 1				# system call code for print integer
		syscall					# print integer 
		
		jr $s0					# return to main function 
################ MAX(a1, a2, a3) ######################	
# Purpose: Returns the largest of three numbers
# 		   stored in registers a1, a2, a3
#######################################################  
# Register Usage:
# $a1, $a2, $a3 - used to pass integer arguments
# $v0 - return value
#######################################################
# Pseudoode:
# if (a1 >= a2 && a1 >= a3) return a1
# else if (a2 > a1 && a2 >= a3) return a2
# else (a3 > a1 && a3 > a2) return a3
#######################################################										
max:			bge $a1, $a2, compA		
				blt $a1, $a2, compB
				
compA:			bge $a1, $a3, returnA
				blt $a1, $a3, returnC
				
compB:			bge $a2, $a3, returnB
				blt $a2, $a3, returnC
				
returnA: 		move $v0, $a1
				jr $ra
				
returnB: 		move $v0, $a2
				jr $ra
				
returnC: 		move $v0, $a3
				jr $ra
#########################CELSIUS CONVERTER#####################
# Purpose: Converts Celsius to Farenheit
###############################################################
# Register usage 
# f2 = used to pass constant values from data segment
# f12 = return value
###############################################################
# Pseudocode:
# f2 = 1.8
# f12 = f12 * f2
# f2 = 32.0
# f12 = f12 + f2
# cout << f12
###############################################################
celsiusConvert:	

	li $v0, 4 					# system call code for print string
	la, $a0, promptCelsius		# load address of propmt Celsius
	syscall						# print string
		
	li $v0, 7					# system call code for read double	
	syscall						# read double
		
	mov.d $f12, $f0				# Move return value to argument passage register
	ldc1 $f2, doubleMult  		# load constant conversion multiplier 1.8
	mul.d $f12, $f12, $f2		# Multiplication portion of formula 	
	ldc1 $f2, doubleAdd	  		# load constant conversion addend 32.0	
	add.d $f12, $f12, $f2		# addition portion of formula
		
	li $v0, 3					# system call code for print double
	syscall						# print double
		
	li $v0, 4					# System call code for print string
	la $a0, tempOut				# load address of tempOut
	syscall						# print string
	sub.d $f12, $f12, $f12		# clear f12
		
	jr $ra						# return to main function
		
######################### NUMBER PROMPT ##########################
# Purpose: Continually ask user to enter a number between 1-100000
#          If number is out-of-bounds, alert user, prompt again.
##################################################################
# Pseudocode:
# max = 100000
# Cout << promptInt
# cin >> v0
# if (v0 == 0) exit
# else if (v0 < 0) tooLow
# else if (v0 > 100000) tooHigh
# else cout << $v0
###################################################################
 
enterNumber:

	li $a1, 100000 			# initialize upper limit
				
	li $v0, 4				# system call code for print string
	la $a0, promptInt 		# load address of promptInt
	syscall					# print string
				
	li $v0, 5				# system call code for read integer
	syscall					# read integer
	
	beqz $v0, exit			# branch to exit			
	bltz $v0, tooLow		# branch to tooLow
	bgt $v0, $a1 tooHigh	# branch to tooHigh
				
				
	move $t0, $v0			# store in-bounds value in t0
	li $v0, 4				# system call code for print string
	la $a0, msg				# load address of msg
	syscall					# print string
				
	li $v0, 1				# system call code for print integer
	move $a0, $t0			# move $t0 to $a0
	syscall					# print integer
	b enterNumber			# branch to enterNumber
	
tooLow:
	li $v0, 4				# system call code for print string 
	la $a0, tooLowMsg		# load address of tooLowMsg
	syscall					# print string
	b enterNumber			# branch to enterNumber
	
tooHigh:	
	li $v0, 4				# system call code for print string 
	la $a0, tooHighMsg		# load address of tooHighMsg
	syscall					# print string
	b enterNumber			# branch to enterNumber
				
exit:
	li $v0, 4				# system call code for print string 
	la $a0, bye				# load address of bye
	syscall					# print string
				
	jr $ra					# return to main program
				
################ INTEREST CALCULATOR ###############################
# Purpose: Take user input for initial principle balance, 
#          interest rate, and number of years Calculate ending 
#          balance using formula:
#          Balance = P(1 + R/100) ^^ Y
#		   where P = initial principle
#                R = rate
#                Y = years
####################################################################
# Register Usage:
# t0 - number of years
# f2 - used to pass constant values from data segment
# f4 - initial principle balance
# f6 - interest rate
# f12 - return value 
####################################################################
interestCalculator:

	li $v0, 4				# system call code for print string 
	la $a0, getPrinciple	# load address of getPrinciple
	syscall					# print string

	li $v0, 7				# system call code for read double
	syscall					# read double
	mov.d $f4, $f0			# store in f4 - Principle

	li $v0, 4				# system call code for print string 
	la $a0, getRate			# load address of getRate
	syscall					# print string

	li $v0, 7				# system call code for read double
	syscall					# read double 
	mov.d $f6, $f0			# store in f6 - Rate

	li $v0, 4				# system call code for print string 
	la $a0, getYears		# load address of getYears
	syscall					# print string

	li $v0, 5				# system call code for read integer
	syscall					# read integer
	move $t0, $v0			# store in $t0 - years

	
	ldc1 $f2, double100		# load constant double 100
	div.d $f6, $f6, $f2		# divide rate by 100 store in f6
	
	ldc1 $f2, double1		# load constant double 1
	add.d $f6, $f6, $f2		# add 1 to f6	

	add.d $f12, $f12, $f6	# copy base value to f12 
	addi $t0, $t0, -1		# loop counter = years - 1
	
loop:
	mul.d $f12, $f12, $f6   # exponent multiplier
	addi $t0, $t0, -1 		# decrement counter
	bgtz $t0, loop			# branch to loop 

	mul.d $f12, $f4, $f12	# multiply by principle

	li $v0, 4				# system call code for print string
	la $a0, outputResult	# load address of outputResult
	syscall					# print string
	
	li $v0, 3				# system call code for print double
	syscall					# print double

	jr $ra					# return to main program
