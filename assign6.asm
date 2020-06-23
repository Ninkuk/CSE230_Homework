# Ninad Kulkarni 1216529600
# Class ID: 40130
# Homework 6

.data
.asciiz "Please enter a decimal number (0 to quit) "

.text
.globl main

main:
	sub.s $f30, $f30, $f30	# create global 0.0 value

	jal getsum			# call function to print sum of input
	sub.s $f12, $f12, $f12	# create 0.0 value
	add.s $f12, $f0, $f12		# copy sum to $f12
	ori $v0, $0, 2			# set output command
	syscall

end: 	
	ori $v0, $0, 10		# set command to stop program,
	syscall				# end program

# This function takes a float and returns 0 if that number is positive and 1 if it is negative
# parameter: $f12 - float to be evaluated
# return: $v0 - return 1 if $f12 is negative or 0 if it is positive
# registers:
	# $f30 - used as a global 0.0 value
	# $ra - holds the return address to go back to next line from where it was called
isneg:
	c.lt.s $f12, $f30		# checks if the passed parameter is less than 0.0
	bc1f else			# if the result of the branch above is false then the number is positive and the branch jumps to else
	addi $v0, $0, 1		# sets 1 (negative) to the return $v0
	j return			# jumps to return tag
	else: addi $v0, $0, 0		# sets 0 (positive) to the return $v0
	return: jr $ra			# exits out of the function and returns to the address $ra


# This function takes user inputs until 0 is entered. It evaluates each input and ignores the negative values. The positive values are added up to a total sum and returned.
# parameter: No parameters in this function
# return: $f0 - returns the sum of all positive float numbers
# registers:
	# $v0 - used for syscall commands
	# $f20 - used to save the user input to use after evaluating its sign
	# $f22 - used to store the sum of all positive float numbers
	# $s0 - holds the base address for data
	# $ra - holds the return address to go back to next line from where it was called
getsum:
	addi $sp, $sp, -4		# allocate space in stack
	sw $ra, 0($sp)		# save return address to stack
	lui $s0, 0x1001		# Get the base address
	loop:
		addi $v0, $0, 4		# load command to print string
		addi $a0, $s0, 0 		# address to load
		syscall				# print string ("Please enter a decimal number ")
		add $v0, $0, 6		# set command to read a float
		syscall				# read the user input
		c.eq.s $f0, $f30		# checks if the input is 0.0 and stores the result
		bc1t endloop			# if the result of the branch above is true then it breaks the loop and jumps to endloop
		add.s $f20, $f30, $f0		# save the input
		add.s $f12, $f30, $f0		# set the input value as parameter for isneg
		jal isneg			# call isneg
		bne $v0, $0, loop		# if result != 0 (negative = 1) then go to back to the loop
		add.s $f22, $f22, $f20	# This is executed if result is positive and increments the sum by input
		j loop				# go to loop tag and execute again
	endloop:
		add.s $f0, $f30, $f22		# sets return value to the sum
		lw $ra, 0($sp)			# load return address to stack
		addi $sp, $sp, 4		# deallocate space in stack
		jr $ra				# return back to main
