.data

msgPrompt: .asciiz "Please enter 4 numbers."
average: .asciiz "\nThe average is "
total: .asciiz "The total is "

.text
main:

li $v0 4
la $a0 msgPrompt
syscall

addu $t1, $zero, $zero
addu $t2, $t2, 4
jal loop


li $v0 4
la $a0, total
syscall

li $v0, 1
move $a0, $t1
syscall

li $v0 4
la $a0, average
syscall

sra $a0, $t1, 2
li $v0, 1
syscall

loop:
li $v0 5
syscall
addu $t1, $t1, $v0
addi $t2, $t2, -1
bnez $t2, loop
jr $ra



