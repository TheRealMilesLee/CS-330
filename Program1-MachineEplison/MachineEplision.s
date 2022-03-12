# Hengyi Li
# This program is to check the Machine Eplison
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
  la    $a0,sample_output1          # Load the address of origional string into $a0
  jal printString # Print the sample_output1

  jal printNewLine # Print the newline

  la $a0, sample_output2  # Load the address of origional string into $a0
  jal printString # Print the sample_output2

  jal printNewLine # Print the newline

  la $a0, sample_output3 # Load the address of origional string into $a0
  jal printString # Print the sample_output3

  jal printNewLine # Print the newline

  la $a0, sample_output4 # Load the address of origional string into $a0
  jal printString # Print the sample_output4

  jal printNewLine # Print the newline

  la $a0, sample_output5 # Load the address of origional string into $a0
  jal printString # Print the sample_output5

  jal printNewLine # Print the newline
  # This is the end of the main
  li    $v0, 0x0a           # Exit the system call
  syscall
  .end  main

printNewLine:
  la    $a0, newline        # Load the address of newline into $a0
  li    $v0, 0x04           # Call the system print the newline character
  syscall
  jr    $ra                 # return

printString:
  li $v0, 0x04  # Call the syscall to print the string
  syscall
  jr $ra  # return

printDouble:
  li $v0, 3   # Call the syscall to print the Double
  mov.d $f12, $f2
  syscall
  jr $ra  # return
