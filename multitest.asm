


		.text
main:								

li $s0, 32716
li $t2, 20
multu $s0, $t2
mflo $s2

li $s1, 32716
li $t3, 10
multu $s1, $t3
mflo $s3

mult $s3, $s2
mfhi $t0
mflo $t1

li $v0, 1
move $a0, $t0
syscall

li $v0, 1
move $a0, $t1
syscall
jr $ra