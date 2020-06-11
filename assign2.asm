# Ninad Kulkarni 1216529600
# Class ID: 40130
# Homework 2

.data
.globl main
.text
main:
sub $t0, $s1, $s0  # Subtracts s0 from s1 (30-20=10) and sets it to a temporary register t0
add $s3, $t0, $s2  # Adds t0 to s2 (10+-2 = 8) and sets it to a register s3
sub $t1, $s3, $s2  # Subtracts s2 from s3 (8--2=10) and sets it to a temporary register t1
addi $s4, $t1, 21  # Adds a constant number 21 to t1 (10+21=31) and sets it to register s4
addi $t2, $s1, 15  # Adds a constant number 15 to s1 (15+30=45) and sets it to temporary register t2
sub $s5, $t2, $s2  # Subtracts s2 from t2 (45--2=47) and sets it to a register s5
add $t3, $s0, $zero  # sets the value of s0 to a temporary register t3
add $s0, $s1, $zero  # sets the value of s0 to s1
add $s1, $t3, $zero  # sets the value of s1 to the value of t3 which contains the original value of s0
sub $s2, $zero, $s2  # subtracts s2 from 0 to make its value positive