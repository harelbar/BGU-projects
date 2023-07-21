.data 
	arr: .word 4,3,8,2,7,2,9,3
	S: .word 0x500000
.text
main:     
  	addi $t0, $zero, 28         # address of the end of arr
  	lw   $t8,S		        # for 1 s delay
  	addi $v0,$zero,1
  	sw $v0,0x818
L1:
	add $t9, $zero, $zero     # address of arr to be manipulated
  	add $t1, $zero, $zero     # sorted array flag

L2:                               
   	lw  $t2, 0($t9)            
   	lw  $t3, 4($t9)             
   	slt $t4, $t3, $t2           
  	beq $t4, $0, noswap      # if $t3 < $t2, no need for swap
  	add $t1, $0, 1                # if a swap has accured, we need to do another iteration
  	sw  $t2, 4($t9)             
  	sw  $t3, 0($t9)               #swap the numbers
noswap:
  	addi $t9, $t9, 4           
 	beq  $t9, $t0, retire       # If $t8 = the end of arr address
 	j    L2	                      # else, continue sorting
retire:
  	beq  $t1, $0, desplay      # if $t1 = 0, the array is sorted. display the array 
	j    L1		       
desplay:  	
	lw $t9,0x818
	andi $t9,$t9,0x001
	beq $t9,$zero,desplay    # display only if SW=1
	add $t9, $zero, $zero
	lw   $t6,0($t9)             
	sw   $t6,0x808               # write to PORT_HEX0[7-0] 
	sw   $zero,0x80C
	sw   $zero,0x810
	sw   $zero,0x814
	j    delay	
show:
	beq  $t9,$t0,desplay      # if $t8 = 64 then startover
	addi $t9,$t9,4                # going to the next number in the array
	lw   $t6,0($t9)             
	sw   $t6,0x808               # write to PORT_HEX0[7-0]
delay:
	move $t7,$zero					
L3:	
	beq $t7,$t8,show           
	addi $t7,$t7,1
	j L3
