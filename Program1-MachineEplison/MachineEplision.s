# Hengyi Li
# This program is to check the Machine Epsilon
# Version: 0.2.1. Alpha
# Copyright. 2022, Hengyi. All rights reserved
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
	li $a2, 52	# Load the power into $a2
	jal   power # Call the power function call
	jal		printDouble				# jump to printDouble and save position to $ra

	jal	printNewLine		# Print the newline

	la	$a0, sample_output2	# Load the address of origional string into $a0
	jal	printString		# Print the sample_output2

	li $a2, 52	# Load the power into $a2
	jal   power # Call the power function call
	l.d $f2, answer # Load the power result into $f2
	l.d $f4, one # Load 1 into $f4
	jal addDouble # 1 + 0.5^52
	l.d $f2, answer # Load the power result into $f2
	l.d $f4, one # Load 1 into $f4
	jal subDouble # (1 + 0.5^52) - 1

	jal printDouble # Output
	jal	printNewLine 		# Print the newline

	la	$a0, sample_output3 	# Load the address of origional string into $a0
	jal	printString		# Print the sample_output3

	li $a2, 53	# Load the power into $a2
	jal power # Call the power function call
	l.d $f2, answer # Load the power result into $f2
	l.d $f4, one # Load 1 into $f4
	jal addDouble # 1 + 0.5^53
	l.d $f2, answer # Load the power result into $f2
	l.d $f4, one # Load 1 into $f4
	jal subDouble # (1 + 0.5^53) - 1

	jal printDouble # Output
	jal	printNewLine		# Print the newline

	la	$a0, sample_output4	# Load the address of origional string into $a0
	jal	printString		# Print the sample_output4

	li $a2, 53	# Load the power into $a2
	jal power # Call the power function call
	l.d $f0, answer	# Save to $f0
	li $a2, 54	# Load the power into $a2
	jal power # Call the power function call
	l.d $f2, answer # Load the power result into $f2
	mov.d $f4, $f0 # Load the former power result into $f4
	jal addDouble # 0.5^53 + 0.5^54
	l.d $f2, answer # Load the power result into $f2
	l.d $f4, one # Load 1 into $f4
	jal addDouble # (1 + (0.5^53 + 0.5^54))
	l.d $f2, answer # Load the power result into $f2
	l.d $f4, one # Load 1 into $f4
	jal subDouble # (1+(0.5^53 + 0.5^54)) - 1

	jal printDouble # Output
	jal	printNewLine		# Print the newline

	la	$a0, sample_output5	# Load the address of origional string into $a0
	jal	printString		# Print the sample_output5

	li $a2, 53	# Load the power into $a2
	jal power # Call the power function call
	l.d $f0, answer	# Save to $f0
	li $a2, 105	# Load the power into $a2
	jal power # Call the power function call
	l.d $f2, answer # Load the power result into $f2
	mov.d $f4, $f0 # Load the former power result into $f4
	jal addDouble # 0.5^53 + 0.5^54
	l.d $f2, answer # Load the power result into $f2
	l.d $f4, one # Load 1 into $f4
	jal addDouble # (1 + (0.5^53 + 0.5^54))
	l.d $f2, answer # Load the power result into $f2
	l.d $f4, one # Load 1 into $f4
	jal subDouble # (1+(0.5^53 + 0.5^54)) - 1

	jal printDouble # Output
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

addDouble:
	add.d $f2, $f2, $f4 # Add $f2 and $f4, store it back to $f2
	s.d $f2, answer # Save $f2 into answer
	jr $ra # Return

subDouble:
	sub.d $f4, $f2, $f4 # Subtract $f2 and $f4 store to $f4
	s.d $f4, answer # Save $f4 into answer
	jr $ra # Return

power:
	# $f4 is the base
	# $f2 is the power
	# $t1 is the counter for the multiplication
	l.d $f2, answer	# Load the answer address into $f1
	l.d $f4, half	# Load the base address into $f2
	mov.d $f2, $f4 # initialize the $f2 to 0.5
	addiu $t1, $t1, 1	# Initialize the $t1 to 1

	loop:
		bge	$t1, $a2, exit	# If $t1 >= $a2 then end loop
		mul.d $f4, $f4, $f2 # Power calculation
		s.d $f4, answer # Save the result into $f4
		addiu	$t1, $t1, 1	# $t1 = $t1 + 1
		j 	loop		# Continue looping

	exit:
		move 		$t1, $zero			# $t1 = 0
		jr	$ra		# return
