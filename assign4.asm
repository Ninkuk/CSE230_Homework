# Ninad Kulkarni 1216529600
# Class ID: 40130
# Homework 4

.data
.asciiz "Please enter a number (0 to quit) "

.text
.globl main

main:
	jal getsum		# call function to print sum of input
	ori $a0, $v0, 0	# copy sum to $a0
	ori $v0, $0, 1		# set output command
	syscall			# prints the sum

end:
	ori $v0, $0, 10	# set command to stop program,
	syscall			# end program

# This function takes a number and returns 0 if that number is even and 1 if it is odd
# parameter: $a0 - number to be evaluated
# return: $v0 - return 1 if $a0 is odd or 0 if it is even
# registers:
	# $t0 - used to store temporary values such as least significant bit of the input, and the parity of the input
	# $ra - holds the return address to go back to next line from where it was called
isodd:
	andi $t0, $a0, 1	# isolate the least significant bit
	slti $t0, $t0, 1	# sets t0 = 1 if number is even or t0 = 0 if number is odd
	bne $t0, $0, else	# if $t0 != 0 then goto else tag
	addi $v0, $0, 1	# sets 1 to the return $v0. This is only executed if $t1 = 0
	j return		# jumps to return tag which
	else: addi $v0, $0, 0	# sets 0 to the return $v0. This is only executed if $t1 = 1
	return: jr $ra		# exits out of the function and returns to the address $ra

# This function takes user inputs until 0 is entered. It evaluates each input and ignores the even values. The odd values are added up to a total sum and returned.
# parameter: No parameters in this function
# return: $v0 - returns the sum of all odd numbers
# registers:
	# $v0 - used for syscall commands
	# $s0 - used to save the user input to use after evaluating its parity through isodd
	# $s1 - used to store the sum of all odd numbers
	# $s2 - holds the base address for data
	# $t0 - used to save the result of isodd
	# $ra - holds the return address to go back to next line from where it was called
getsum:
	addi $sp, $sp, -4	# allocate space in stack
	sw $ra, 0($sp)	# save return address to stack
	lui $s2, 0x1001	# Get the base address
	loop:
		addi $v0, $0, 4		# load command to print string
		addi $a0, $s2, 0 		# address to load
		syscall				# print string ("Please enter a number ")
		addi $v0, $0, 5		# set command to read an int
		syscall				# read the user input
		beq $v0, $0, endloop	# checks if the input is 0 and ends the loop
		add $s0, $0, $v0		# save the input
		add $a0, $0, $v0		# set the input value as parameter for isodd
		jal isodd			# call isodd
		add $t0, $0, $v0		# save the result of isodd
		beq $t0, $0, loop		# if result = 0 (even) then go to back to the loop
		add $s1, $s1, $s0		# This is executed if result is odd and increments the sum by input
		j loop				# goto loop tag and execute again
	endloop:
		add $v0, $0, $s1	# sets return value to the sum
		lw $ra, 0($sp)		# load return address to stack
		addi $sp, $sp, 4	# deallocate space in stack
		jr $ra			# return back to main
