
# This would check if the index is = 1. if it is then it would return.
ble $a0, 1, return_index

li $t0,0 # a = 0, a being current #
li $t1,1 # b = 1, b being previous #
li $t2,0 # newValue = 0
li $t3,0 # i = 0

# n is $a0
addi $t4, $a0, -1 # range = n - 1


 loop: 
 
 beq $t3, $t4, end # if i == range then the loop would end
 
 add $t2, $t0, $t1 # newValue = a + b
 move $t1, $t0	    # b = a
 move $t0, $t2     # a = newValue
 
 addi $t3, $t3, 1  # i++
 
 j loop	    # Loops back again
 
 end: 
 
 move $v0, $t0	    # returning the last fibonacci num
 jr $ra
 
 return_index: 
 move $v0, $a0
 jr $ra
 
 