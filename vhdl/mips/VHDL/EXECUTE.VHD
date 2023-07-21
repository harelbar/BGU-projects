--  Execute module (implements the data ALU and Branch Address Adder  
--  for the MIPS computer)
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;



ENTITY  Execute IS
	generic (n : positive := 9 );
	PORT(	Read_data_1 	: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			Read_data_2 	: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			Sign_extend 	: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			Function_opcode : IN 	STD_LOGIC_VECTOR( 5 DOWNTO 0 );
			ALUOp 			: IN 	STD_LOGIC_VECTOR( 1 DOWNTO 0 );
			ALUSrc 			: IN 	STD_LOGIC;
			Zero 			: OUT	STD_LOGIC;
			LUI  			: IN 	STD_LOGIC;
			SW  			: IN 	STD_LOGIC;
			LW  			: IN 	STD_LOGIC;
			ADDI  			: IN 	STD_LOGIC;
			MUL  			: IN 	STD_LOGIC;
			ALU_Result 		: OUT	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			Add_Result 		: OUT	STD_LOGIC_VECTOR( n DOWNTO 0 );
			PC_plus_4 		: IN 	STD_LOGIC_VECTOR( n+2 DOWNTO 0 );
			clock, reset	: IN 	STD_LOGIC );
END Execute;

ARCHITECTURE behavior OF Execute IS
SIGNAL Ainput, Binput 		: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
SIGNAL ASll       	     	: STD_LOGIC_VECTOR ( 31 DOWNTO 0 );
SIGNAL ASrl       	     	: STD_LOGIC_VECTOR ( 31 DOWNTO 0 );
SIGNAL ALU_output_mux		: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
SIGNAL Branch_Add 			: STD_LOGIC_VECTOR( n DOWNTO 0 );
SIGNAL ALU_ctl				: STD_LOGIC_VECTOR( 2 DOWNTO 0 );
SIGNAL s    				: integer;
SIGNAL mulres				: STD_LOGIC_VECTOR( 63 DOWNTO 0 );
SIGNAL addres				: STD_LOGIC_VECTOR( 31 DOWNTO 0 );

BEGIN
	Ainput <= Read_data_1;
	mulres <= Ainput*Binput;
	addres <=  Ainput+Binput;
	s <= to_integer(signed(Sign_extend(10 downto 6)));
	ASll <= std_logic_vector(shift_left(signed(Binput),s));
	ASrl <= std_logic_vector(shift_right(signed(Binput),s));
						-- ALU input mux
	Binput <= Read_data_2 WHEN ( ALUSrc = '0' ) 
  		ELSE  Sign_extend( 31 DOWNTO 0 );
						-- Generate ALU control bits
	ALU_ctl( 0 ) <= ( Function_opcode( 0 ) OR Function_opcode( 3 ) OR (NOT Function_opcode(5))) AND ALUOp(1);
	ALU_ctl( 1 ) <= ( NOT Function_opcode( 2 ) ) OR (NOT ALUOp( 1 ) );
	ALU_ctl( 2 ) <= ( Function_opcode( 1 ) AND ALUOp( 1 )) OR ALUOp( 0 );
						-- Generate Zero Flag
	Zero <= '1' 
		WHEN ( ALU_output_mux( 31 DOWNTO 0 ) = X"00000000"  )
		ELSE '0';    
						-- Select ALU output        
	ALU_result <= X"0000000" & "000"  & ALU_output_mux( 31 ) WHEN  ALU_ctl = "111" AND Function_opcode(3)='1' 
		ELSE  Binput(15 downto 0)& X"0000"      WHEN LUI='1'
		ELSE  "00"&addres(31 downto 2)          WHEN ((SW='1' or LW='1')and n=9)
		ELSE  addres							WHEN ((SW='1' or LW='1')and n=7)
        ELSE  mulres(31 DOWNTO 0)               WHEN mul='1'
		ELSE  ASll                              WHEN  ALU_ctl = "011" AND Function_opcode(0)='0'
		ELSE  ASrl                              WHEN  ALU_ctl = "111" AND Function_opcode(3)='0'
		ELSE  ALU_output_mux( 31 DOWNTO 0 );
						-- Adder to compute Branch Address
	Branch_Add <= PC_plus_4( n+2 DOWNTO 2 ) +  Sign_extend( n DOWNTO 0 ) ;
		Add_result 	<= Branch_Add( n DOWNTO 0 );

PROCESS ( ALU_ctl, Ainput, Binput )
	BEGIN
					-- Select ALU operation
 	CASE ALU_ctl IS
						-- ALU performs ALUresult = A_input AND B_input
		WHEN "000" 	=>	ALU_output_mux 	<= Ainput AND Binput; 
						-- ALU performs ALUresult = A_input OR B_input
     	WHEN "001" 	=>	ALU_output_mux 	<= Ainput OR Binput;
						-- ALU performs ALUresult = A_input + B_input
	 	WHEN "010" 	=>  ALU_output_mux <= Ainput + Binput;
						-- ALU performs addu or sll 
 	 	WHEN "011" 	=>	 ALU_output_mux <= Ainput + Binput;
						-- ALU performs xor
 	 	WHEN "100" 	=>	ALU_output_mux 	<= Ainput xor Binput;
						-- ALU performs ?
 	 	WHEN "101" 	=>	ALU_output_mux 	<= X"00000000";
						-- ALU performs ALUresult = A_input -B_input
 	 	WHEN "110" 	=>	ALU_output_mux 	<= Ainput - Binput;
						-- ALU performs SLT or srl
  	 	WHEN "111" 	=>	ALU_output_mux 	<= Ainput - Binput ; 
						
 	 	WHEN OTHERS	=>	ALU_output_mux 	<= X"00000000" ;
  	END CASE;
  END PROCESS;
END behavior;

