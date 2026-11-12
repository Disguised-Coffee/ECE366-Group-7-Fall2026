.globl main

.data
	msg: .asciiz "\n\The number at the " 
	is: .asciiz "th iterations of the TRADITIONAL (NOT the A000045 OEIS standard) fibonacci sequence is "

.text
main: 
  #switch the # if you want to generate more fibonacci # in the terminal. 
  li $a0, 5 # n = 5 for now

  move $s0, $a0 # s0 stores our original value
  
  jal fibonacci # call function. pushes instruction address into $ra which we pop later...
  
  move $s1, $a0 # s1 stores our new value
  
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

  # Exit program cleanly
  li $v0, 10          # Service code 10 is exit
  syscall
 
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
  
  # prints a into the terminal
  move $a0,$t0
  li $v0, 1
  syscall
  
  # prints a space in terminal
  li $a0, 32
  li $v0, 11
  syscall
  
  # prints b into the terminal
  move $a0,$t1
  li $v0, 1
  syscall
  
  #prints a space in terminal
  li $a0, 32
  li $v0, 11
  syscall
 


loop: 
 
  beq $t3, $t4, end # if i == range then the loop would end
  
  add $t2, $t0, $t1 # newValue = a + b
  move $t0, $t1	    # a = b
  move $t1, $t2     # b = newValue
    
  move $a0,$t1
  li $v0,1	    # printing the #
  syscall
    
  li $a0, 32         # printing space
  li $v0, 11
  syscall
  
  addi $t3, $t3, 1  # i++
  
  j loop	    # Loops back again
 
end: 
 
  move $a0, $t1	    # returning the last fibonacci num
  li $v0,1
  syscall 
 
  jr $ra
 
return_index: 
  li $v0,1
  syscall
 
 jr $ra
 
