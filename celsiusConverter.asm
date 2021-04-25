.data	

		prompt:	.ascii	"Please enter the temperature "
				.asciiz		"in Celcius. \n"
		tempOut: .asciiz " degrees Farenheit"
		
		doubleZero: .double 0.0
		doubleMult: .double 1.8
		doubleAdd: .double 32.0
		
.text

celsiusConvert:	ldc1 $f2, doubleZero
		ldc1 $f4, doubleMult
		ldc1 $f6, doubleAdd

		li $v0, 4 
		la, $a0, prompt
		syscall
		
		li $v0, 7
		syscall
		
		add.d $f12, $f0, $f2
		mul.d $f12, $f12, $f4
		add.d $f12, $f12, $f6
		
		li $v0, 3
		syscall
		
		li $v0, 4
		la $a0, tempOut
		syscall
		
		jr $ra