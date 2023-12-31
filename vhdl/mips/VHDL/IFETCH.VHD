-- Ifetch module (provides the PC and instruction 
--memory for the MIPS computer)
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;

ENTITY Ifetch IS
	generic (n : positive := 9 );
	PORT(	SIGNAL Instruction 		: OUT	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
        	SIGNAL PC_plus_4_out 	: OUT	STD_LOGIC_VECTOR( n+2 DOWNTO 0 );
        	SIGNAL Add_result 		: IN 	STD_LOGIC_VECTOR( n DOWNTO 0 );
        	SIGNAL Branch 			: IN 	STD_LOGIC;
			SIGNAL BranchNeq 		: IN 	STD_LOGIC;
        	SIGNAL Zero 			: IN 	STD_LOGIC;
			SIGNAL Rs       		: in	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			SIGNAL jump_address     : in	STD_LOGIC_VECTOR( n DOWNTO 0 );
			SIGNAL Jump             : in	STD_LOGIC;
			SIGNAL JR  			    : in 	STD_LOGIC;
      		SIGNAL PC_out 			: OUT	STD_LOGIC_VECTOR( n+2 DOWNTO 0 );
        	SIGNAL clock, reset 	: IN 	STD_LOGIC);
END Ifetch;

ARCHITECTURE behavior OF Ifetch IS
	SIGNAL PC, PC_plus_4 	 : STD_LOGIC_VECTOR( n+2 DOWNTO 0 );
	SIGNAL next_PC : STD_LOGIC_VECTOR( n DOWNTO 0 );
	SIGNAL  Mem_Addr 	 : STD_LOGIC_VECTOR( 9 DOWNTO 0 );
	SIGNAL zero_padding		: STD_LOGIC_VECTOR( abs(n-9) DOWNTO 0 );---fixxxxxxxxxxxxx
BEGIN
						--ROM for Instruction Memory	
	inst_memory: altsyncram
	
	GENERIC MAP (
		operation_mode => "ROM",
		width_a => 32,
		widthad_a => 10,
		lpm_type => "altsyncram",
		outdata_reg_a => "UNREGISTERED",
		init_file => "C:\Users\harel\Desktop\lab 5\ex4 - MIPS Architecture (ModelSim  Quartus)\MIPS ModelSim\Binary (I-Chace , D-Chace) content\program.hex",
		intended_device_family => "Cyclone"
	)
	PORT MAP (
		clock0     => clock,
		address_a 	=> Mem_Addr, 
		q_a 			=> Instruction );
					-- Instructions always start on word address - not byte
		PC(1 DOWNTO 0) <= "00";
					-- copy output signals - allows read inside module
		PC_out 			<= PC;
		PC_plus_4_out 	<= PC_plus_4;
						-- send address to inst. memory address register
		Mem_Addr <= Next_PC&"00" when n=7 ELSE Next_PC;
						-- Adder to increment PC by 4        
      	PC_plus_4( n+2 DOWNTO 2 )  <= PC( n+2 DOWNTO 2 ) + 1;
       	PC_plus_4( 1 DOWNTO 0 )  <= "00";
						-- Mux to select Branch Address or PC + 4        
		Next_PC  <= (others => '0') WHEN Reset = '1'
		       ELSE Add_result      WHEN ((( Branch = '1')AND( Zero = '1'))or(BranchNeq='1' AND NOT( zero='1'))) 
			   ELSE jump_address    WHEN Jump='1'
			   ELSE Rs(n+2 downto 2) WHEN Jr='1' 
		       ELSE PC_plus_4( n+2 DOWNTO 2 ); 
	PROCESS
		BEGIN
			WAIT UNTIL ( clock'EVENT ) AND ( clock = '1' );
			IF reset = '1' THEN
				   PC( n+2 DOWNTO 2) <= (others => '0') ;
			ELSE 
				   PC( n+2 DOWNTO 2 ) <= next_PC;
			END IF;
	END PROCESS;
END behavior;


