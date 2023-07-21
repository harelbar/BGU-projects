				-- Top Level Structural Model for MIPS Processor Core
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

package aux_package is 
-----------------------------------------------------------------

	COMPONENT Ifetch
		generic (n : positive := 9 );
   	    PORT(	Instruction			: OUT 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
        		PC_plus_4_out 		: OUT  	STD_LOGIC_VECTOR( n+2 DOWNTO 0 );
        		Add_result 			: IN 	STD_LOGIC_VECTOR( n DOWNTO 0 );
        		Branch 				: IN 	STD_LOGIC;
				BranchNeq	        : IN 	STD_LOGIC;
        		Zero 				: IN 	STD_LOGIC;
			    Rs       		    : in	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			    jump_address        : in	STD_LOGIC_VECTOR( n DOWNTO 0 );
			    Jump                : in	STD_LOGIC;
				JR   			    : in 	STD_LOGIC;
        		PC_out 				: OUT 	STD_LOGIC_VECTOR( n+2 DOWNTO 0 );
        		clock,reset 		: IN 	STD_LOGIC );
	END COMPONENT; 

	COMPONENT Idecode
		generic (n : positive := 9 );
 	    PORT(	read_data_1 		: OUT 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
        		read_data_2 		: OUT 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
        		Instruction 		: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
        		read_data 			: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
        		ALU_result 			: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
        		RegWrite		 	: IN 	STD_LOGIC;
				MemtoReg 			: in 	STD_LOGIC_VECTOR ( 1 downto 0);
        		RegDst 				: IN 	STD_LOGIC;
				PC_plus_4           : IN    STD_LOGIC_VECTOR( n+2 DOWNTO 0 );
        		Sign_extend 		: OUT 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
		    	jump_address		: OUT 	STD_LOGIC_VECTOR( n DOWNTO 0 );
        		clock, reset		: IN 	STD_LOGIC );
	END COMPONENT;

	COMPONENT control
	    PORT( 	Opcode 				: IN 	STD_LOGIC_VECTOR( 5 DOWNTO 0 );
				func_opc			: IN 	STD_LOGIC_VECTOR( 5 DOWNTO 0 );
             	RegDst 				: OUT 	STD_LOGIC;
             	ALUSrc 				: OUT 	STD_LOGIC;
             	MemtoReg 			: OUT 	STD_LOGIC_VECTOR ( 1 downto 0);
             	RegWrite 			: OUT 	STD_LOGIC;
             	MemRead 			: OUT 	STD_LOGIC;
             	MemWrite 			: OUT 	STD_LOGIC;
             	Branch 				: OUT 	STD_LOGIC;
				BranchNeq	        : OUT 	STD_LOGIC;
             	ALUop 				: OUT 	STD_LOGIC_VECTOR( 1 DOWNTO 0 );
				LUI     	        : OUT 	STD_LOGIC;
				Jump	            : OUT 	STD_LOGIC;
				JR   			    : OUT 	STD_LOGIC;
				ADDI  	 		    : OUT 	STD_LOGIC;
				MUL  		        : OUT 	STD_LOGIC;
             	clock, reset		: IN 	STD_LOGIC );
	END COMPONENT;

	COMPONENT  Execute
		generic (n : positive := 9 );
   	    PORT(	Read_data_1 		: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
                Read_data_2 		: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
               	Sign_Extend 		: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
               	Function_opcode		: IN 	STD_LOGIC_VECTOR( 5 DOWNTO 0 );
               	ALUOp 				: IN 	STD_LOGIC_VECTOR( 1 DOWNTO 0 );
               	ALUSrc 				: IN 	STD_LOGIC;
               	Zero 				: OUT	STD_LOGIC;
				LUI 				: in	STD_LOGIC;
				SW  				: IN 	STD_LOGIC;
				LW  			    : IN 	STD_LOGIC;
				ADDI  		     	: IN 	STD_LOGIC;
				MUL  		    	: IN 	STD_LOGIC;
               	ALU_Result 			: OUT	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
               	Add_Result 			: OUT	STD_LOGIC_VECTOR( n DOWNTO 0 );
               	PC_plus_4 			: IN 	STD_LOGIC_VECTOR( n+2 DOWNTO 0 );
               	clock, reset		: IN 	STD_LOGIC );
	END COMPONENT;

	COMPONENT dmemory
		generic (n : positive := 9 );
	    PORT(	read_data 			: OUT 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
        		address 			: IN 	STD_LOGIC_VECTOR( 11 DOWNTO 0 );
        		write_data, SW		: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
        		MemRead, Memwrite 	: IN 	STD_LOGIC;
        		Clock,reset			: IN 	STD_LOGIC );
	END COMPONENT;
	
	component freq_divider is 
	GENERIC(m : INTEGER :=1 );
	port (InClk : in std_logic;	
		   OutClk : out std_logic); 
    end component;
	
	component  perifers IS
		PORT(	memWrite, MemRead   :in std_logic;
			CS_ctl              :in std_logic_vector (3 downto 0);
			data				:in std_logic_vector (7 downto 0);
			SW      	        :in std_logic_vector (7 downto 0);
			clock, reset		: IN STD_LOGIC;
			LedG,LedR,Hex0,Hex1,Hex2,Hex3 :out std_logic_vector(7 downto 0));
	END component;
	
	component hex_decoder IS
    PORT (  X: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		  Hout: OUT STD_LOGIC_VECTOR(6 downto 0)); 
    END component;
end aux_package;