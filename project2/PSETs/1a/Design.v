
li $t0,0; # a = 0
li $t1,1; # b = 1
li $t2,0; # newValue = 0
li $t3,0; # i = 0
li $t4,0; # range = 0
 
 loop: 
 
 beq $t3, $t4, end; # if i == range then the loop would end
 