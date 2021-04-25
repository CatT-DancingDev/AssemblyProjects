#####################################################################
# Assignment #5: Check Book	Programmer: Catherine Trujillo
# Due Date: 4/12/2020  Course: CSC 225 040
# Last Modified: 4/9/2020
#####################################################################
# Functional Description:
# This program can be used to balance your check book.
# To detect arithmetic overflow, the program checks whether the 
# transaction is a deposit or a withdrawal. For a deposit if the new 
# balance is less than prior balance, this shows overflow. 
# For a withdrawal, if the new balance is greater than the prior balance,
# this shows overflow. I handled the overflow by sending an error message 
# to user, resetting the new balance to the prior balance, and branching 
# to the complete[transaction] sequence. 
#####################################################################
# Pseudocode:
# Print Header;
# s0 = 0;
# t0 = 0                    ####
# loop:	Prompt user for transaction;
# v0 << transaction amount;
#   if (v0 = 0) done;
#   s0 = s0 + v0;
#   if(v0 > 0) deposit;       ####
#   if(v0 < 0) withdrawal;    ####
# deposit:                    ####
#   if(s0<t0) error;          ####
#   else complete;            ####
# withdrawal:                 ####
#   if(t0<s0) error;          ####
#   else complete;            ####
# error:                      ####
#   cout << error message;    ####
#   s0 = t0;                  ####
#   go to complete            ####
# complete:                   ####
#   t0 = s0;                  ####
#   cout << s0
#   go to loop
# done:
# cout << "Adios Amigo"
# 
######################################################################
# Register Usage:
# $v0: Transaction Amount
# $s0: Current Bank Balance
# $t0: Prior Bank Balance     ####
######################################################################
	.data			# Data declaration section
Head: 	.ascii	"\n\tThis program, written by Catherine Trujillo,"
	.ascii	" can be used to balance your check book."
	.asciiz	"\n\n\t\t\t\t\t\t\t\t\t  Balance:"
tabs:	.asciiz	"\t\t\t\t\t\t\t\t\t"
tran:	.asciiz	"\nTransaction:"
bye:	.asciiz	"\n  ****  Adios Amigo  **** "
errorMessage:    .ascii "\nOverflow Occured -"    ####
                  .ascii " Transaction "          ####
                  .ascii "Ignored"                ####
		  .asciiz"\n"                     ####

	.text			# Executable code follows
main:
	li	$v0, 4		# system call code for print_string
	la	$a0, Head	# load address of Header message into $a0
	syscall			# print the Header

	move $s0, $zero	        # Set Bank Balance to zero
	move $t0, $zero         #### Initialize prior balance
loop:
	li	$v0, 4		# system call code for print_string
	la	$a0, tran	# load address of prompt into $a0
	syscall			# print the prompt message

	li	$v0, 5		# system call code for read_integer
	syscall			# reads the amount of  Transaction into $v0

	beqz $v0, done	        # If $v0 equals zero, branch to done
	
	addu $s0,$s0,$v0        # add transaction amount to the Balance
    
	bgtz $v0, deposit       #### branch to deposit
	bltz $v0, withdrawal    #### branch to withdrawal
deposit:
	blt $s0, $t0, error     #### branch to error
	b complete              #### branch to complete

withdrawal:
	bgt $s0, $t0, error     #### branch to error
	b complete              #### branch to complete

error:
	li $v0, 4               #### system call code for print_string
	la $a0, errorMessage    #### load address of errorMessage into $a0
	syscall                 #### print the errorMessage
	move $s0, $t0           #### restore new balance to prior balance
	b complete              #### branch to complete
   

complete:	
	move $t0, $s0           #### update prior balance to reflect new balance
	li   $v0, 4		# system call code for print_string
	la   $a0, tabs	        # load address of tabs into $a0
	syscall			# used to space over to the Balance column
	
	li	$v0, 1		# system call code for print_integer
	move $a0, $s0	        # move Bank Balance value to $a0 
	syscall			# print Bank Balance
	b 	loop		# branch to loop

done:	
	li	$v0, 4		# system call code for print_string
	la	$a0, bye	# load address of msg. into $a0
	syscall			# print the string

	li	$v0, 10		# terminate program run and
	syscall			# return control to system

				# END OF PROGRAM
