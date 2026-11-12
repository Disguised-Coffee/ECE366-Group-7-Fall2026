
.text
.globl main

main: 

#switch the # if you want to generate more fibonacci # in the terminal. 
li $a0, 5 # n = 5 for now

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
 
 
 li $v0, 10
 syscall
 
 move $a0, $t1	    # returning the last fibonacci num
 li $v0,1
 syscall 
 
 li $v0, 10
 syscall
 
 return_index: 
 li $v0,1
 syscall
 
 li $v0,10
 syscall
 
 
 
