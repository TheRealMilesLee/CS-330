# Hengyi Li
# This program is to check the Machine Epsilon

.data
sample_output1:
	.asciiz "0.5 ^ 52 = "
sample_output2:
	.asciiz "(1 + 0.5^52) - 1 = "
sample_output3:
	.asciiz "(1 + 0.5^53) - 1 = "
sample_output4:
	.asciiz "(1 + (0.5^53 + 0.5^54)) - 1 = "
sample_output5:
	.asciiz "(1 + (0.5^53 + 0.5^105)) - 1 = "
newline:
	.asciiz "\n"
one:
	.double 1.0
half:
	.double 0.5
answer:
	.double 0.0

.text
.globl main

main:
	la	$a0, sample_output1	# Load the address of origional string into $a0
	jal	printString		# Jump to printString and save position to $ra
	addiu $v0, 0
	addiu $a0, 0
	jal		printDouble				# jump to printDouble and save position to $ra




	jal	printNewLine		# Print the newline

	la	$a0, sample_output2	# Load the address of origional string into $a0
	jal	printString		# Print the sample_output2

	jal	printNewLine 		# Print the newline

	la	$a0, sample_output3 	# Load the address of origional string into $a0
	jal	printString		# Print the sample_output3

	jal	printNewLine		# Print the newline

	la	$a0, sample_output4	# Load the address of origional string into $a0
	jal	printString		# Print the sample_output4

	jal	printNewLine		# Print the newline

	la	$a0, sample_output5	# Load the address of origional string into $a0
	jal	printString		# Print the sample_output5

	jal	printNewLine		# Print the newline

	# This is the end of the main
	li    	$v0, 0x0a		# Exit the system call
	syscall
	.end  main

printNewLine:
	la	$a0, newline	# Load the address of newline into $a0
	li	$v0, 0x04	# Call the system print the newline character
	syscall
	jr	$ra		# Return

printString:
	li	$v0, 0x04	# Call the syscall to print the string
	syscall
	jr	$ra		# Return

printDouble:
	l.d		$f12, answer	# Load the double to be printed
	li $v0, 3
	syscall
	jr	$ra		# return

power:
	# $a0 is the final result
	# $a1 is the base
	# $a2 is the power
	# $t1 is the counter for the multiplication
	l.d $f1, answer	# Load the answer address into $f1
	l.d $f2, half	# Load the base address into $f2
	addiu $t1, $t1, 0	# Initialize the $t1 to 0
	loop:
		bge	$t1, $a2, exit	# If $t2 >= $a2 then end loop
		mul.d $f2, $f2, $f2
		addiu	$t1, $t1, 1	# $t1 = $t1 + 1
		j 	loop		# Continue looping
	exit:
		s.d $f2, answer
		jr	$ra		# return
