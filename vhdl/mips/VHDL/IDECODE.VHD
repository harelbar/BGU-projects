						--  Idecode module (implements the register file for
LIBRARY IEEE; 			-- the MIPS computer)
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY Idecode IS
      generic (n : positive := 9 );
	  PORT(	read_data_1	: OUT 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			read_data_2	: OUT 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			Instruction : IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			read_data 	: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			ALU_result	: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			RegWrite 	: IN 	STD_LOGIC;
			MemtoReg 	: IN 	STD_LOGIC_VECTOR ( 1 downto 0);
			RegDst 		: IN 	STD_LOGIC;
			PC_plus_4   : IN    STD_LOGIC_VECTOR( n+2 DOWNTO 0 );
			Sign_extend : OUT 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			jump_address: OUT 	STD_LOGIC_VECTOR( n DOWNTO 0 );
			clock,reset	: IN 	STD_LOGIC );
END Idecode;


ARCHITECTURE behavior OF Idecode IS
TYPE register_file IS ARRAY ( 0 TO 31 ) OF STD_LOGIC_VECTOR( 31 DOWNTO 0 );

	SIGNAL register_array				: register_file;
	SIGNAL write_register_address 		: STD_LOGIC_VECTOR( 4 DOWNTO 0 );
	SIGNAL write_data					: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL read_register_1_address		: STD_LOGIC_VECTOR( 4 DOWNTO 0 );
	SIGNAL read_register_2_address		: STD_LOGIC_VECTOR( 4 DOWNTO 0 );
	SIGNAL write_register_address_1		: STD_LOGIC_VECTOR( 4 DOWNTO 0 );
	SIGNAL write_register_address_0		: STD_LOGIC_VECTOR( 4 DOWNTO 0 );
	SIGNAL Instruction_immediate_value	: STD_LOGIC_VECTOR( 15 DOWNTO 0 );
	SIGNAL write_register_ra     		: STD_LOGIC_VECTOR( 4 DOWNTO 0 );


BEGIN
	read_register_1_address 	<= Instruction( 25 DOWNTO 21 ); --rs
   	read_register_2_address 	<= Instruction( 20 DOWNTO 16 ); --rt
   	write_register_address_1	<= Instruction( 15 DOWNTO 11 ); --rd
   	write_register_address_0 	<= Instruction( 20 DOWNTO 16 ); --rt
   	Instruction_immediate_value <= Instruction( 15 DOWNTO 0 );
	jump_address                <= Instruction( n DOWNTO 0 );
	write_register_ra           <= b"11111";                    --R[31]
					-- Read Register 1 Operation
	read_data_1 <= register_array( 
			      CONV_INTEGER( read_register_1_address ) );
					-- Read Register 2 Operation		 
	read_data_2 <= register_array( 
			      CONV_INTEGER( read_register_2_address ) );
					-- Mux for Register Write Address
    write_register_address <= write_register_address_1 WHEN RegDst = '1'
                             ELSE write_register_ra   when MemtoReg = "10"
							 ELSE write_register_address_0;
					-- Mux to bypass data memory for Rformat instructions
	write_data <= ALU_result( 31 DOWNTO 0 ) WHEN ( MemtoReg = "00" )
                  ELSE read_data            when ( MemtoReg = "01" )
				  ELSE x"00000"&"00"&PC_plus_4 WHEN n=7
				  ELSE x"00000"&PC_plus_4;  
					-- Sign Extend 16-bits to 32-bits
    	Sign_extend <= X"0000" & Instruction_immediate_value
		WHEN Instruction_immediate_value(15) = '0'
		ELSE	X"FFFF" & Instruction_immediate_value;

PROCESS
	BEGIN
		WAIT UNTIL clock'EVENT AND clock = '1';
		IF reset = '1' THEN
					-- Initial register values on reset are register = reg#
					-- use loop to automatically generate reset logic 
					-- for all registers
			FOR i IN 0 TO 31 LOOP
				register_array(i) <= CONV_STD_LOGIC_VECTOR( i, 32 );
 			END LOOP;
					-- Write back to register - don't write to register 0
  		ELSIF RegWrite = '1' AND write_register_address /= 0 THEN
		      register_array( CONV_INTEGER( write_register_address)) <= write_data;
		END IF;
	END PROCESS;
END behavior;


