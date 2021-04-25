
.data
getPrinciple: .asciiz "Please enter the starting balance. \n"
getRate: .asciiz "\nPlease enter the interest rate.\n"
getYears: .asciiz "\nPlease enter the number of years interest will accrue. \n"
outputResult: .asciiz "Ending balance with interest: $"

doubleZero: .double 0.0
double1: .double 1.0
double100: .double 100.0
.text
interestCalculator:


li $v0, 4
la $a0, getPrinciple
syscall

li $v0, 7
syscall
mov.d $f4, $f0

li $v0, 4
la $a0, getRate
syscall

li $v0, 7
syscall
mov.d $f6, $f0

li $v0, 4
la $a0, getYears
syscall

li $v0, 5
syscall
move $t0, $v0

ldc1 $f2, double100
div.d $f6, $f6, $f2
ldc1 $f2, double1
add.d $f6, $f6, $f2
ldc1 $f2, doubleZero

add.d $f8, $f8, $f6
addi $t0, $t0, -1
loop:
addi $t0, $t0, -1
mul.d $f8, $f8, $f6
bgtz $t0, loop

mul.d $f12, $f4, $f8

li $v0, 4
la $a0, outputResult
syscall
li $v0, 3
syscall

jr $ra















li $v0, 10
syscall
 


				
				
				
				
		
				
				

		