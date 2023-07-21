onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group tb -radix hexadecimal /mips_tb/ALU_result_out
add wave -noupdate -expand -group tb -radix hexadecimal /mips_tb/Branch_out
add wave -noupdate -expand -group tb -radix hexadecimal /mips_tb/Instruction_out
add wave -noupdate -expand -group tb -radix hexadecimal /mips_tb/Memwrite_out
add wave -noupdate -expand -group tb -radix hexadecimal /mips_tb/PC
add wave -noupdate -expand -group tb -radix hexadecimal /mips_tb/Regwrite_out
add wave -noupdate -expand -group tb -radix hexadecimal /mips_tb/Zero_out
add wave -noupdate -expand -group tb -radix hexadecimal /mips_tb/clock
add wave -noupdate -expand -group tb -radix hexadecimal /mips_tb/read_data_1_out
add wave -noupdate -expand -group tb -radix hexadecimal /mips_tb/read_data_2_out
add wave -noupdate -expand -group tb -radix hexadecimal /mips_tb/reset
add wave -noupdate -expand -group tb -radix hexadecimal /mips_tb/write_data_out
add wave -noupdate -expand -group tb -radix hexadecimal /mips_tb/H0
add wave -noupdate -expand -group tb -radix hexadecimal /mips_tb/H1
add wave -noupdate -expand -group tb -radix hexadecimal /mips_tb/H2
add wave -noupdate -expand -group tb -radix hexadecimal /mips_tb/H3
add wave -noupdate -expand -group tb -radix hexadecimal /mips_tb/LedG
add wave -noupdate -expand -group tb -radix hexadecimal /mips_tb/LedR
add wave -noupdate -expand -group IFE -radix hexadecimal /mips_tb/U_0/IFE/Instruction
add wave -noupdate -expand -group IFE -radix hexadecimal /mips_tb/U_0/IFE/PC_plus_4_out
add wave -noupdate -expand -group IFE -radix hexadecimal /mips_tb/U_0/IFE/Add_result
add wave -noupdate -expand -group IFE -radix hexadecimal /mips_tb/U_0/IFE/Branch
add wave -noupdate -expand -group IFE -radix hexadecimal /mips_tb/U_0/IFE/BranchNeq
add wave -noupdate -expand -group IFE -radix hexadecimal /mips_tb/U_0/IFE/Zero
add wave -noupdate -expand -group IFE -radix hexadecimal /mips_tb/U_0/IFE/Rs
add wave -noupdate -expand -group IFE -radix hexadecimal /mips_tb/U_0/IFE/jump_address
add wave -noupdate -expand -group IFE -radix hexadecimal /mips_tb/U_0/IFE/Jump
add wave -noupdate -expand -group IFE -radix hexadecimal /mips_tb/U_0/IFE/JR
add wave -noupdate -expand -group IFE -radix hexadecimal /mips_tb/U_0/IFE/PC_out
add wave -noupdate -expand -group IFE -radix hexadecimal /mips_tb/U_0/IFE/clock
add wave -noupdate -expand -group IFE -radix hexadecimal /mips_tb/U_0/IFE/reset
add wave -noupdate -expand -group IFE -radix hexadecimal /mips_tb/U_0/IFE/PC
add wave -noupdate -expand -group IFE -radix hexadecimal /mips_tb/U_0/IFE/PC_plus_4
add wave -noupdate -expand -group IFE -radix hexadecimal /mips_tb/U_0/IFE/next_PC
add wave -noupdate -expand -group IFE -radix hexadecimal /mips_tb/U_0/IFE/Mem_Addr
add wave -noupdate -expand -group ID -radix hexadecimal /mips_tb/U_0/ID/read_data_1
add wave -noupdate -expand -group ID -radix hexadecimal /mips_tb/U_0/ID/read_data_2
add wave -noupdate -expand -group ID -radix hexadecimal /mips_tb/U_0/ID/Instruction
add wave -noupdate -expand -group ID -radix hexadecimal /mips_tb/U_0/ID/read_data
add wave -noupdate -expand -group ID -radix hexadecimal /mips_tb/U_0/ID/ALU_result
add wave -noupdate -expand -group ID -radix hexadecimal /mips_tb/U_0/ID/RegWrite
add wave -noupdate -expand -group ID -radix hexadecimal /mips_tb/U_0/ID/MemtoReg
add wave -noupdate -expand -group ID -radix hexadecimal /mips_tb/U_0/ID/RegDst
add wave -noupdate -expand -group ID -radix hexadecimal /mips_tb/U_0/ID/PC_plus_4
add wave -noupdate -expand -group ID -radix hexadecimal /mips_tb/U_0/ID/Sign_extend
add wave -noupdate -expand -group ID -radix hexadecimal /mips_tb/U_0/ID/jump_address
add wave -noupdate -expand -group ID -radix hexadecimal /mips_tb/U_0/ID/clock
add wave -noupdate -expand -group ID -radix hexadecimal /mips_tb/U_0/ID/reset
add wave -noupdate -expand -group ID -radix hexadecimal -childformat {{/mips_tb/U_0/ID/register_array(0) -radix hexadecimal} {/mips_tb/U_0/ID/register_array(1) -radix hexadecimal} {/mips_tb/U_0/ID/register_array(2) -radix hexadecimal} {/mips_tb/U_0/ID/register_array(3) -radix hexadecimal} {/mips_tb/U_0/ID/register_array(4) -radix hexadecimal} {/mips_tb/U_0/ID/register_array(5) -radix hexadecimal} {/mips_tb/U_0/ID/register_array(6) -radix hexadecimal} {/mips_tb/U_0/ID/register_array(7) -radix hexadecimal} {/mips_tb/U_0/ID/register_array(8) -radix hexadecimal} {/mips_tb/U_0/ID/register_array(9) -radix hexadecimal} {/mips_tb/U_0/ID/register_array(10) -radix hexadecimal} {/mips_tb/U_0/ID/register_array(11) -radix hexadecimal} {/mips_tb/U_0/ID/register_array(12) -radix hexadecimal} {/mips_tb/U_0/ID/register_array(13) -radix hexadecimal} {/mips_tb/U_0/ID/register_array(14) -radix hexadecimal} {/mips_tb/U_0/ID/register_array(15) -radix hexadecimal} {/mips_tb/U_0/ID/register_array(16) -radix hexadecimal} {/mips_tb/U_0/ID/register_array(17) -radix hexadecimal} {/mips_tb/U_0/ID/register_array(18) -radix hexadecimal} {/mips_tb/U_0/ID/register_array(19) -radix hexadecimal} {/mips_tb/U_0/ID/register_array(20) -radix hexadecimal} {/mips_tb/U_0/ID/register_array(21) -radix hexadecimal} {/mips_tb/U_0/ID/register_array(22) -radix hexadecimal} {/mips_tb/U_0/ID/register_array(23) -radix hexadecimal} {/mips_tb/U_0/ID/register_array(24) -radix hexadecimal} {/mips_tb/U_0/ID/register_array(25) -radix hexadecimal} {/mips_tb/U_0/ID/register_array(26) -radix hexadecimal} {/mips_tb/U_0/ID/register_array(27) -radix hexadecimal} {/mips_tb/U_0/ID/register_array(28) -radix hexadecimal} {/mips_tb/U_0/ID/register_array(29) -radix hexadecimal} {/mips_tb/U_0/ID/register_array(30) -radix hexadecimal} {/mips_tb/U_0/ID/register_array(31) -radix hexadecimal}} -subitemconfig {/mips_tb/U_0/ID/register_array(0) {-height 15 -radix hexadecimal} /mips_tb/U_0/ID/register_array(1) {-height 15 -radix hexadecimal} /mips_tb/U_0/ID/register_array(2) {-height 15 -radix hexadecimal} /mips_tb/U_0/ID/register_array(3) {-height 15 -radix hexadecimal} /mips_tb/U_0/ID/register_array(4) {-height 15 -radix hexadecimal} /mips_tb/U_0/ID/register_array(5) {-height 15 -radix hexadecimal} /mips_tb/U_0/ID/register_array(6) {-height 15 -radix hexadecimal} /mips_tb/U_0/ID/register_array(7) {-height 15 -radix hexadecimal} /mips_tb/U_0/ID/register_array(8) {-height 15 -radix hexadecimal} /mips_tb/U_0/ID/register_array(9) {-height 15 -radix hexadecimal} /mips_tb/U_0/ID/register_array(10) {-height 15 -radix hexadecimal} /mips_tb/U_0/ID/register_array(11) {-height 15 -radix hexadecimal} /mips_tb/U_0/ID/register_array(12) {-height 15 -radix hexadecimal} /mips_tb/U_0/ID/register_array(13) {-height 15 -radix hexadecimal} /mips_tb/U_0/ID/register_array(14) {-height 15 -radix hexadecimal} /mips_tb/U_0/ID/register_array(15) {-height 15 -radix hexadecimal} /mips_tb/U_0/ID/register_array(16) {-height 15 -radix hexadecimal} /mips_tb/U_0/ID/register_array(17) {-height 15 -radix hexadecimal} /mips_tb/U_0/ID/register_array(18) {-height 15 -radix hexadecimal} /mips_tb/U_0/ID/register_array(19) {-height 15 -radix hexadecimal} /mips_tb/U_0/ID/register_array(20) {-height 15 -radix hexadecimal} /mips_tb/U_0/ID/register_array(21) {-height 15 -radix hexadecimal} /mips_tb/U_0/ID/register_array(22) {-height 15 -radix hexadecimal} /mips_tb/U_0/ID/register_array(23) {-height 15 -radix hexadecimal} /mips_tb/U_0/ID/register_array(24) {-height 15 -radix hexadecimal} /mips_tb/U_0/ID/register_array(25) {-height 15 -radix hexadecimal} /mips_tb/U_0/ID/register_array(26) {-height 15 -radix hexadecimal} /mips_tb/U_0/ID/register_array(27) {-height 15 -radix hexadecimal} /mips_tb/U_0/ID/register_array(28) {-height 15 -radix hexadecimal} /mips_tb/U_0/ID/register_array(29) {-height 15 -radix hexadecimal} /mips_tb/U_0/ID/register_array(30) {-height 15 -radix hexadecimal} /mips_tb/U_0/ID/register_array(31) {-height 15 -radix hexadecimal}} /mips_tb/U_0/ID/register_array
add wave -noupdate -expand -group ID -radix hexadecimal /mips_tb/U_0/ID/write_register_address
add wave -noupdate -expand -group ID -radix hexadecimal /mips_tb/U_0/ID/write_data
add wave -noupdate -expand -group ID -radix hexadecimal /mips_tb/U_0/ID/read_register_1_address
add wave -noupdate -expand -group ID -radix hexadecimal /mips_tb/U_0/ID/read_register_2_address
add wave -noupdate -expand -group ID -radix hexadecimal /mips_tb/U_0/ID/write_register_address_1
add wave -noupdate -expand -group ID -radix hexadecimal /mips_tb/U_0/ID/write_register_address_0
add wave -noupdate -expand -group ID -radix hexadecimal /mips_tb/U_0/ID/Instruction_immediate_value
add wave -noupdate -expand -group ID -radix hexadecimal /mips_tb/U_0/ID/write_register_ra
add wave -noupdate -expand -group CTL -radix hexadecimal /mips_tb/U_0/CTL/Opcode
add wave -noupdate -expand -group CTL -radix hexadecimal /mips_tb/U_0/CTL/func_opc
add wave -noupdate -expand -group CTL -radix hexadecimal /mips_tb/U_0/CTL/RegDst
add wave -noupdate -expand -group CTL -radix hexadecimal /mips_tb/U_0/CTL/ALUSrc
add wave -noupdate -expand -group CTL -radix hexadecimal /mips_tb/U_0/CTL/MemtoReg
add wave -noupdate -expand -group CTL -radix hexadecimal /mips_tb/U_0/CTL/RegWrite
add wave -noupdate -expand -group CTL -radix hexadecimal /mips_tb/U_0/CTL/MemRead
add wave -noupdate -expand -group CTL -radix hexadecimal /mips_tb/U_0/CTL/MemWrite
add wave -noupdate -expand -group CTL -radix hexadecimal /mips_tb/U_0/CTL/Branch
add wave -noupdate -expand -group CTL -radix hexadecimal /mips_tb/U_0/CTL/BranchNeq
add wave -noupdate -expand -group CTL -radix hexadecimal /mips_tb/U_0/CTL/ALUop
add wave -noupdate -expand -group CTL -radix hexadecimal /mips_tb/U_0/CTL/LUI
add wave -noupdate -expand -group CTL -radix hexadecimal /mips_tb/U_0/CTL/Jump
add wave -noupdate -expand -group CTL -radix hexadecimal /mips_tb/U_0/CTL/JR
add wave -noupdate -expand -group CTL -radix hexadecimal /mips_tb/U_0/CTL/ADDI
add wave -noupdate -expand -group CTL -radix hexadecimal /mips_tb/U_0/CTL/MUL
add wave -noupdate -expand -group CTL -radix hexadecimal /mips_tb/U_0/CTL/clock
add wave -noupdate -expand -group CTL -radix hexadecimal /mips_tb/U_0/CTL/reset
add wave -noupdate -expand -group CTL -radix hexadecimal /mips_tb/U_0/CTL/R_format
add wave -noupdate -expand -group CTL -radix hexadecimal /mips_tb/U_0/CTL/Lw
add wave -noupdate -expand -group CTL -radix hexadecimal /mips_tb/U_0/CTL/Sw
add wave -noupdate -expand -group CTL -radix hexadecimal /mips_tb/U_0/CTL/Beq
add wave -noupdate -expand -group CTL -radix hexadecimal /mips_tb/U_0/CTL/SLUI
add wave -noupdate -expand -group CTL -radix hexadecimal /mips_tb/U_0/CTL/Bnq
add wave -noupdate -expand -group CTL -radix hexadecimal /mips_tb/U_0/CTL/JAL
add wave -noupdate -expand -group CTL -radix hexadecimal /mips_tb/U_0/CTL/SJ
add wave -noupdate -expand -group CTL -radix hexadecimal /mips_tb/U_0/CTL/J
add wave -noupdate -expand -group CTL -radix hexadecimal /mips_tb/U_0/CTL/SADDI
add wave -noupdate -expand -group CTL -radix hexadecimal /mips_tb/U_0/CTL/SMUL
add wave -noupdate -expand -group CTL -radix hexadecimal /mips_tb/U_0/CTL/SANDI
add wave -noupdate -expand -group CTL -radix hexadecimal /mips_tb/U_0/CTL/SORI
add wave -noupdate -expand -group CTL -radix hexadecimal /mips_tb/U_0/CTL/SXORI
add wave -noupdate -expand -group CTL -radix hexadecimal /mips_tb/U_0/CTL/shift
add wave -noupdate -expand -group CTL -radix hexadecimal /mips_tb/U_0/CTL/SLTI
add wave -noupdate -expand -group CTL -radix hexadecimal /mips_tb/U_0/CTL/Imm
add wave -noupdate -expand -group EXE -radix hexadecimal /mips_tb/U_0/EXE/Read_data_1
add wave -noupdate -expand -group EXE -radix hexadecimal /mips_tb/U_0/EXE/Read_data_2
add wave -noupdate -expand -group EXE -radix hexadecimal /mips_tb/U_0/EXE/Sign_extend
add wave -noupdate -expand -group EXE -radix hexadecimal /mips_tb/U_0/EXE/Function_opcode
add wave -noupdate -expand -group EXE -radix hexadecimal /mips_tb/U_0/EXE/ALUOp
add wave -noupdate -expand -group EXE -radix hexadecimal /mips_tb/U_0/EXE/ALUSrc
add wave -noupdate -expand -group EXE -radix hexadecimal /mips_tb/U_0/EXE/Zero
add wave -noupdate -expand -group EXE -radix hexadecimal /mips_tb/U_0/EXE/LUI
add wave -noupdate -expand -group EXE -radix hexadecimal /mips_tb/U_0/EXE/SW
add wave -noupdate -expand -group EXE -radix hexadecimal /mips_tb/U_0/EXE/LW
add wave -noupdate -expand -group EXE -radix hexadecimal /mips_tb/U_0/EXE/ADDI
add wave -noupdate -expand -group EXE -radix hexadecimal /mips_tb/U_0/EXE/MUL
add wave -noupdate -expand -group EXE -radix hexadecimal /mips_tb/U_0/EXE/ALU_Result
add wave -noupdate -expand -group EXE -radix hexadecimal /mips_tb/U_0/EXE/Add_Result
add wave -noupdate -expand -group EXE -radix hexadecimal /mips_tb/U_0/EXE/PC_plus_4
add wave -noupdate -expand -group EXE -radix hexadecimal /mips_tb/U_0/EXE/clock
add wave -noupdate -expand -group EXE -radix hexadecimal /mips_tb/U_0/EXE/reset
add wave -noupdate -expand -group EXE -radix hexadecimal /mips_tb/U_0/EXE/Ainput
add wave -noupdate -expand -group EXE -radix hexadecimal /mips_tb/U_0/EXE/Binput
add wave -noupdate -expand -group EXE -radix hexadecimal /mips_tb/U_0/EXE/ASll
add wave -noupdate -expand -group EXE -radix hexadecimal /mips_tb/U_0/EXE/ASrl
add wave -noupdate -expand -group EXE -radix hexadecimal /mips_tb/U_0/EXE/ALU_output_mux
add wave -noupdate -expand -group EXE -radix hexadecimal /mips_tb/U_0/EXE/Branch_Add
add wave -noupdate -expand -group EXE -radix hexadecimal /mips_tb/U_0/EXE/ALU_ctl
add wave -noupdate -expand -group EXE -radix hexadecimal /mips_tb/U_0/EXE/s
add wave -noupdate -expand -group EXE -radix hexadecimal /mips_tb/U_0/EXE/mulres
add wave -noupdate -expand -group MEM -radix hexadecimal /mips_tb/U_0/MEM/read_data
add wave -noupdate -expand -group MEM -radix hexadecimal /mips_tb/U_0/MEM/address
add wave -noupdate -expand -group MEM -radix hexadecimal /mips_tb/U_0/MEM/write_data
add wave -noupdate -expand -group MEM -radix hexadecimal /mips_tb/U_0/MEM/SW
add wave -noupdate -expand -group MEM -radix hexadecimal /mips_tb/U_0/MEM/MemRead
add wave -noupdate -expand -group MEM -radix hexadecimal /mips_tb/U_0/MEM/Memwrite
add wave -noupdate -expand -group MEM -radix hexadecimal /mips_tb/U_0/MEM/clock
add wave -noupdate -expand -group MEM -radix hexadecimal /mips_tb/U_0/MEM/reset
add wave -noupdate -expand -group MEM -radix hexadecimal /mips_tb/U_0/MEM/write_clock
add wave -noupdate -expand -group MEM -radix hexadecimal /mips_tb/U_0/MEM/memwrite_s
add wave -noupdate -expand -group MEM -radix hexadecimal /mips_tb/U_0/MEM/read_data_mem
add wave -noupdate -expand -group PER -radix hexadecimal /mips_tb/U_0/PER/memWrite
add wave -noupdate -expand -group PER -radix hexadecimal /mips_tb/U_0/PER/MemRead
add wave -noupdate -expand -group PER -radix hexadecimal /mips_tb/U_0/PER/CS_ctl
add wave -noupdate -expand -group PER -radix hexadecimal /mips_tb/U_0/PER/data
add wave -noupdate -expand -group PER -radix hexadecimal /mips_tb/U_0/PER/SW
add wave -noupdate -expand -group PER -radix hexadecimal /mips_tb/U_0/PER/clock
add wave -noupdate -expand -group PER -radix hexadecimal /mips_tb/U_0/PER/reset
add wave -noupdate -expand -group PER -radix hexadecimal /mips_tb/U_0/PER/LedG
add wave -noupdate -expand -group PER -radix hexadecimal /mips_tb/U_0/PER/LedR
add wave -noupdate -expand -group PER -radix hexadecimal /mips_tb/U_0/PER/Hex0
add wave -noupdate -expand -group PER -radix hexadecimal /mips_tb/U_0/PER/Hex1
add wave -noupdate -expand -group PER -radix hexadecimal /mips_tb/U_0/PER/Hex2
add wave -noupdate -expand -group PER -radix hexadecimal /mips_tb/U_0/PER/Hex3
add wave -noupdate -expand -group PER -radix hexadecimal /mips_tb/U_0/PER/CS
add wave -noupdate -expand -group PER -radix hexadecimal /mips_tb/U_0/PER/en0
add wave -noupdate -expand -group PER -radix hexadecimal /mips_tb/U_0/PER/en1
add wave -noupdate -expand -group PER -radix hexadecimal /mips_tb/U_0/PER/en2
add wave -noupdate -expand -group PER -radix hexadecimal /mips_tb/U_0/PER/en3
add wave -noupdate -expand -group PER -radix hexadecimal /mips_tb/U_0/PER/en4
add wave -noupdate -expand -group PER -radix hexadecimal /mips_tb/U_0/PER/en5
add wave -noupdate /mips_tb/U_0/EXE/addres
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3939526 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 235
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {3222094 ps} {6503344 ps}
