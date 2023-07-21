MIPS - top level entity. simulate the Mips datapath.
IFETCH - instruction fetch stage. fetching from the program memory the instruction to be executed.
IDECODE - instruction decode stage. fetching the operands needed to execute the instruction from the GPR file.
CONTROL - control unit that commandes the other stages which operation to execute.
EXECUTE - the datapath "calculator", calculate the arithmetic and logical operations.
DMEMORY - the interface with the data memory of the program.
freq_diveder - use for clock manipulation.
Hex_decoder - use for translation of the information to be presented on the 7-segments.
perifers - the interface with the output devices.
aux_package - a sub library used in the project.
mips_tb_struct - simulate the interface of the datapath with the perifers.
mips_tester_struct - the test bench to simulate input to the system.
