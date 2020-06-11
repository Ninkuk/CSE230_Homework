# Ninad Kulkarni 1216529600
# Class ID: 40130
# Homework 3

.data
.word 0
.word 0
.word 0
.asciiz "Ninad Kulkarni"
.asciiz "Enter a number "
.asciiz "\n"
.globl main
.text
main:

lui $s1, 0x1001	# Get the base address

# Print the prompt for user
addi $v0, $0, 4	# load command to print string
addi $a0, $s1, 27 	# address to load
syscall			# print string ("Enter a number ")

# Read first user input
addi $v0, $0, 5	# load command to read integer
syscall			#read the integer
add $s2, $0, $v0	# store the input in $s2 register for later use
sw $v0, 0($s1)	# write the input to memory at base address

# Print the prompt for user
addi $v0, $0, 4	# load command to print string
addi $a0, $s1, 27	# address to load
syscall			# print string ("Enter a number ")

# Read second user input
addi $v0, $0, 5	# load command to read integer
syscall			# read the integer
add $s3, $0, $v0	# store the input in $s3 register for later use
sw $v0, 4($s1)	# write the input to memory at 2nd address

# Add the 2 numbers and save it
add $s4, $s2, $s3 	# s4 = s2 + s3
sw $s4, 8($s1)	# write the sum to 3rd address

# Print name
addi $v0, $0, 4	# load command to print string
addi $a0, $s1, 12	# load the address to print
syscall			# print string ("Ninad Kulkarni")
addi $v0, $0, 4	# load command to print string
addi $a0, $s1, 43	# load the address to print
syscall			# print string (newline \n)

# Print address 0
lw $t0, 0($s1)		# load the value of first address
addi $v0, $0, 1	# load command to print integer
add $a0, $0, $t0	# load the address to print
syscall			# print string (first input)
addi $v0, $0, 4	# load command to print string
addi $a0, $s1, 43	# load the address to print
syscall			# print string (enter \n)

# Print address 4
lw $t0, 4($s1)		# load the value of second address
addi $v0, $0, 1	# load command to print integer
add $a0, $0, $t0	# load the address to print
syscall			# print string (second input)
addi $v0, $0, 4	# load command to print string
addi $a0, $s1, 43	# load the address to print
syscall			# print string (enter \n)

# Print address 8
lw $t0, 8($s1)		# load the value of third address
addi $v0, $0, 1	# load command to print integer
add $a0, $0, $t0	# load the address to print
syscall			# print string (sum of inputs)

#safely exit the program
addi $v0, $0, 10	# load command to exit program
syscall			# exit the program