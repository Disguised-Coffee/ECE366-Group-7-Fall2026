.globl main

.data
	n: .word 5	# input: change this number to test other values
	result: .word 0	 # output:
	msg: .asciiz "\n\The number at the " 
	is: .asciiz "th iterations of the TRADITIONAL (NOT the A000045 OEIS standard) fibonacci sequence is "
	odd: .asciiz "\nIs it odd? (1 = True, 0 = False): "

.text
main: 
  #switch the # if you want to generate more fibonacci # in the terminal. 
  lw $a0, n # load n from memory

  move $s0, $a0 # s0 stores our original value
  
  jal fibonacci # call function. pushes instruction address into $ra which we pop later...
  
  move $s1, $a0 # s1 stores our new value

  jal isodd # call function, result comes back in $v0

  move $s2, $v0 # s2 stores our result (1 or 0)
  sw $s2, result # store the result into memory

  li $v0, 4           # Load system call code 4 (print string)
  la $a0, msg     # Load the memory address of 'message' into $a0
  syscall             # Execute the print operation

  li $v0, 1		# Load system call code 1 (print integer)
  move  $a0, $s0     
  syscall             # Execute the print operation  
  
  li $v0, 4           
  la $a0, is     
  syscall             # Execute the print operation
  
  li $v0, 1		# Load system call code 1 (print integer)
  move  $a0, $s1     
  syscall             # Execute the print operation  

  li $v0, 4
  la $a0, odd
  syscall             # Execute the print operation

  li $v0, 1			  # Load system call code 1
  move $a0, $s2
  syscall             # Execute the print operation
  
  # Exit program cleanly
  li $v0, 10          # Service code 10 is exit
  syscall

isFibonacciOdd:  
  jal fibonacci # call function. pushes instruction address into $ra which we pop later...
  
  move $s1, $a0 # s1 stores our new value

  jal isodd # call function, result comes back in $v0
  
  # move the result back into the return register as this is a function
  move $v0, $a0
  
  # return cuz we got nothing good to do
  jr $ra
 
# Function
fibonacci:
  # we'll just print out what the value is after fibonacci...
  # 

  # This would check if the index is = 1. if it is then it would return.
  ble $a0, 1, return_index

  li $t0,0 # a = 0, a being previous #
  li $t1,1 # b = 1, b being current #
  li $t2,0 # newValue = 0
  li $t3,0 # i = 0 

  

  # n is $a0
  addi $t4, $a0, -1 # range = n - 1

  # removing printing before the loop (commenting it out)
  # prints a into the terminal
  #move $a0,$t0
  #li $v0, 1
  #syscall
  
  # prints a space in terminal
  #li $a0, 32
  #li $v0, 11
  #syscall
  
  # prints b into the terminal
  #move $a0,$t1
  #li $v0, 1
  #syscall
  
  #prints a space in terminal
  #li $a0, 32
  #li $v0, 11
  #syscall
 
  

loop: 
 
  beq $t3, $t4, end # if i == range then the loop would end
  
  add $t2, $t0, $t1 # newValue = a + b
  move $t0, $t1	    # a = b
  move $t1, $t2     # b = newValue

  addi $t3, $t3, 1  # i++

  #move $a0,$t1
  #li $v0,1	    # printing the #
  #syscall
    
  #li $a0, 32         # printing space
  #li $v0, 11
  #syscall
  # removed the printing
  
  
  j loop	    # Loops back again
 
end: 
 
  move $a0, $t1	    # returning the last fibonacci num
  #li $v0,1
  #syscall 
 
  jr $ra
 
return_index: 
  #li $v0,1
  #syscall
 
 jr $ra

# isodd(m)
# m is $a0, returns 1 in $v0 if m is odd, 0 if m is even
isodd:
  # isodd calls division, save $ra on the stack or it will lose way back to main
  addi $sp, $sp, -4
  sw $ra, 0($sp)

  li $a1, 2 # y = 2, x is already m in $a0
  jal division # remainder = division(m, 2), back in $v0

  # if remainder == 0 then m is even
  beq $v0, $zero, is_even

  li $v0, 1 # return True
  j isodd_return

is_even:
  li $v0, 0 # return False

isodd_return:
  lw $ra, 0($sp) # pop $ra back off the stack
  addi $sp, $sp, 4
  jr $ra

# division(x, y) using repeated subtraction (NO div instruction)
# x is $a0, y is $a1, returns remainder in $v0 and quotient in $v1
division:
  move $t0, $a0 # x
  li $t1, 0     # quotient = 0

div_loop:
  blt $t0, $a1, div_end # if x < y then the loop would end (loop while x >= y)

  sub $t0, $t0, $a1 # x = x - y
  addi $t1, $t1, 1  # quotient = quotient + 1

  j div_loop	    # Loops back again

div_end:
  move $v0, $t0 # returning the remainder (x)
  move $v1, $t1 # quotient, in case we need it
  jr $ra

