						--  Dmemory module (implements the data
						--  memory for the MIPS computer)
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;

LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;

ENTITY dmemory IS
	generic (n : positive := 9 );
	PORT(	read_data 			: OUT 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
        	address 			: IN 	STD_LOGIC_VECTOR( 11 DOWNTO 0 );
        	write_data, SW 		: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	   		MemRead, Memwrite 	: IN 	STD_LOGIC;
            clock,reset			: IN 	STD_LOGIC );
END dmemory;

ARCHITECTURE behavior OF dmemory IS
SIGNAL write_clock, memwrite_s : STD_LOGIC;
SIGNAL read_data_mem : 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
BEGIN
	data_memory : altsyncram
	GENERIC MAP  (
		operation_mode => "SINGLE_PORT",
		width_a => 32,
		widthad_a => 10,
		lpm_type => "altsyncram",
		outdata_reg_a => "UNREGISTERED",
		init_file => "C:\Users\harel\Desktop\lab 5\ex4 - MIPS Architecture (ModelSim  Quartus)\MIPS ModelSim\Binary (I-Chace , D-Chace) content\dmemory.hex",
		intended_device_family => "Cyclone"
	)
	PORT MAP (
		wren_a => memwrite_s,
		clock0 => write_clock,
		address_a => address(9 downto 0),
		data_a => write_data,
		q_a => read_data_mem	);
-- Load memory address register with write clock
		write_clock <= NOT clock;
		memwrite_s <= memwrite and (not address(11));
		read_data <=  SW WHEN (address = X"818" and n=7)or(address = X"206" and n=9)
		ELSE read_data_mem;
END behavior;

