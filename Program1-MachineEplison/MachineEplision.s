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

.text
.globl main

main:
	la	$a0, sample_output1	# Load the address of origional string into $a0
	jal	printString		# Jump to printString and save position to $ra

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
	li	$v0, 3   	# Call the syscall to print the Double
	mov.d	$f12, $f2	# Store the result to $f12
	syscall
	jr	$ra		# return

power:
	# $a0 is the final result
	# $a1 is the base
	# $a2 is the power
	move	$a0, 0	# $a0 = 0
	move	$t1, 0	# $t1 = 0
	loop:
		bge	$t1, $a2, exit	# If $t2 >= $a2 then end loop
		mult	$a1, $a1	# $a1 * $a1 = Hi and Lo registers
		mflo	$a0		# store the result to $a0
		addi	$t1, $t1, 1	# $t1 = $t1 + 1
		j 	loop		# Continue looping
	exit:
		jr	$ra		# return



