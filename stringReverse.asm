.data
strPrompt: .asciiz "Please enter a word, phrase, or sentence. "

string: .space 25
reverse: .space 25

.text

main:

add $t1, $zero,$zero
add $t2, $zero, $zero

li $v0, 4
la $a0, strPrompt
syscall

li $v0, 8
la $a0, string
li $a1, 25
syscall

li	$v0, 4			# We output the string to verify
la	$a0, string
syscall

jal length

move $t0, $a0      #store string
move $t1, $v0      #store length

reverseString:

add $t3, $t0, $t2
lb	$t4, 0($t3)		# load a byte at a time according to counter
beqz	$t4, print		# We found the null-byte
sb	$t4, reverse($t1)		# Overwrite this byte address in memory	
addi	$t1, $t1, -1		# Subtract our overall string length by 1 (j--)
addi	$t2, $t2, 1		# Advance our counter (i++)
j	reverseString		# Loop until we reach our condition

print:
li	$v0, 4			# Print
	la	$a0, reverse		# the string!
	syscall

 



li $v0, 10
syscall

length:
li $v0, -1
move $t1, $a0

lengthLoop:
lb $t0, 0($t1)
addi $t1, $t1, 1
addi $v0, $v0, 1
bnez $t0, lengthLoop
addi $v0, $v0, -1
jr $ra