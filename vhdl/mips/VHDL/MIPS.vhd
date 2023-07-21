				-- Top Level Structural Model for MIPS Processor Core
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE work.aux_package.all;

ENTITY MIPS IS
	generic (n : positive := 7 ); --- 7 for quartus, 9 for modelsim
	PORT( reset, CLK					    : IN 	STD_LOGIC; 
	      Switch                            : IN    STD_LOGIC_VECTOR( 7 DOWNTO 0); 
		  PC								: OUT   STD_LOGIC_VECTOR( n+2 DOWNTO 0 );
		  Hex0, Hex1, Hex2, Hex3		: OUT   STD_LOGIC_VECTOR( 6 DOWNTO 0); 
		  LedG, LedR 					: OUT   STD_LOGIC_VECTOR( 7 DOWNTO 0); 
          ALU_result_out, read_data_1_out, read_data_2_out, write_data_out,Instruction_out: OUT STD_LOGIC_VECTOR( 31 DOWNTO 0 );
		  Branch_out, Zero_out, Memwrite_out, Regwrite_out: OUT 	STD_LOGIC );
    END   MIPS;

ARCHITECTURE structure OF MIPS IS
		
	-- declare signals used to connect VHDL components
	SIGNAL PC_plus_4 		: STD_LOGIC_VECTOR( n+2 DOWNTO 0 );
	SIGNAL read_data_1 		: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL read_data_2 		: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL Sign_Extend 		: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL Add_result 		: STD_LOGIC_VECTOR( n DOWNTO 0 );
	SIGNAL ALU_result 		: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL read_data 		: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL ALUSrc 			: STD_LOGIC;
	SIGNAL Branch 			: STD_LOGIC;
	SIGNAL BranchNeq     	: STD_LOGIC;
	SIGNAL RegDst 			: STD_LOGIC;
	SIGNAL Regwrite 		: STD_LOGIC;
	SIGNAL Zero 			: STD_LOGIC;
	SIGNAL MemWrite 		: STD_LOGIC;
	SIGNAL MemtoReg 		: STD_LOGIC_VECTOR ( 1 downto 0);
	SIGNAL MemRead 			: STD_LOGIC;
	SIGNAL LUI   			: STD_LOGIC;
	SIGNAL SJump   			: STD_LOGIC;
	SIGNAL SJr   			: STD_LOGIC;
	SIGNAL SSW   			: STD_LOGIC;
	SIGNAL SADDI   			: STD_LOGIC;
	SIGNAL SMUL   			: STD_LOGIC;
	SIGNAL clock   			: STD_LOGIC;
	SIGNAL ALUop 			: STD_LOGIC_VECTOR(  1 DOWNTO 0 );
	SIGNAL CS_ctl 			: STD_LOGIC_VECTOR(  3 DOWNTO 0 );
	SIGNAL Instruction		: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL SEswitch	    	: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL R31       		: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL jump_address     : STD_LOGIC_VECTOR( n DOWNTO 0 );
	SIGNAL Function_opcode_sig  : STD_LOGIC_VECTOR(  5 DOWNTO 0 );
	SIGNAL H0, H1, H2, H3   : STD_LOGIC_VECTOR(  7 DOWNTO 0 );
	SIGNAL add 		 		: STD_LOGIC_VECTOR( 11 DOWNTO 0 );

BEGIN
					-- copy important signals to output pins for easy 
					-- display in Simulator
   Instruction_out 	<= Instruction;
   ALU_result_out 	<= ALU_result;
   read_data_1_out 	<= read_data_1;
   read_data_2_out 	<= read_data_2;
   write_data_out  	<= read_data WHEN MemtoReg = "01" ELSE ALU_result; 
   Branch_out 		<= Branch;
   Zero_out 		<= Zero;
   RegWrite_out 	<= RegWrite;
   MemWrite_out 	<= MemWrite;
   CS_ctl           <= ALU_Result(11)&ALU_Result(4 downto 2) when n=7
					ELSE ALU_Result(9)&ALU_Result(2 downto 0);
   SEswitch         <= X"000000"&Switch;
   add              <= ALU_Result (11 DOWNTO 2)&"00" when n=7 else ALU_Result(11 DOWNTO 0);
   
   -- fixing the function opcode for the immidiate opcodes 
   Function_opcode_sig <= "100000" when Instruction( 31 DOWNTO 26 )="100011" or Instruction( 31 DOWNTO 26 )="001000"
					 else "100100" when Instruction( 31 DOWNTO 26 )="001100"
					 else "100110" when Instruction( 31 DOWNTO 26 )="001110"
					 else "100101" when Instruction( 31 DOWNTO 26 )="001101"
					 else "101010" when Instruction( 31 DOWNTO 26 )="001010"
					 else Instruction( 5 DOWNTO 0 ); 
					-- connect the 5 MIPS components   
  fd0 :	freq_divider
    generic map (0) 
	port map (InClk=>CLK,
              OutClk=>clock); 
  IFE : Ifetch
	generic map (n)
	PORT MAP (	Instruction 	=> Instruction,
    	    	PC_plus_4_out 	=> PC_plus_4,
				Add_result 		=> Add_result,
				Branch 			=> Branch,
				BranchNeq	    => BranchNeq,
				Zero 			=> Zero,
				Rs              => read_data_1,
				jump_address    => jump_address,
				Jump            => SJump,
				Jr              => SJr,
				PC_out 			=> PC,        		
				clock 			=> clock,  
				reset 			=> reset );

   ID : Idecode
    generic map (n)
   	PORT MAP (	read_data_1 	=> read_data_1,
        		read_data_2 	=> read_data_2,
        		Instruction 	=> Instruction,
        		read_data 		=> read_data,
				ALU_result 		=> ALU_result,
				RegWrite 		=> RegWrite,
				MemtoReg 		=> MemtoReg,
				RegDst 			=> RegDst,
				PC_plus_4       => PC_plus_4,
				Sign_extend 	=> Sign_extend,
				jump_address    => jump_address,
        		clock 			=> clock,  
				reset 			=> reset );


   CTL:   control
	PORT MAP ( 	Opcode 			=> Instruction( 31 DOWNTO 26 ),
				func_opc        => Function_opcode_sig,
				RegDst 			=> RegDst,
				ALUSrc 			=> ALUSrc,
				MemtoReg 		=> MemtoReg,
				RegWrite 		=> RegWrite,
				MemRead 		=> MemRead,
				MemWrite 		=> MemWrite,
				Branch 			=> Branch,
				BranchNeq	    => BranchNeq,
				ALUop 			=> ALUop,
				LUI             => LUI,
				Jump	    	=> SJump,
				JR   	        => SJr,
				ADDI            => SADDI,
				MUL             => SMUL,
                clock 			=> clock,
				reset 			=> reset );

   EXE:  Execute
    generic map (n)
   	PORT MAP (	Read_data_1 	=> read_data_1,
             	Read_data_2 	=> read_data_2,
				Sign_extend 	=> Sign_extend,
                Function_opcode	=> Function_opcode_sig,
				ALUOp 			=> ALUop,
				ALUSrc 			=> ALUSrc,
				Zero 			=> Zero,
				LUI             => LUI,
				SW				=> MemWrite,
				LW              => MemRead,
				ADDI            => SADDI,
				MUL             => SMUL,
                ALU_Result		=> ALU_Result,
				Add_Result 		=> Add_Result,
				PC_plus_4		=> PC_plus_4,
                Clock			=> clock,
				Reset			=> reset );

   MEM:  dmemory
	generic map (n)
	PORT MAP (	read_data 		=> read_data,
				address 		=> add,
				write_data 		=> read_data_2,
				SW              => SEswitch,
				MemRead 		=> MemRead, 
				Memwrite 		=> MemWrite, 
                clock 			=> clock,  
				reset 			=> reset );
																
	PER:  perifers
	PORT MAP(	memWrite        => MemWrite,
				MemRead         => MemRead,   
				CS_ctl          => CS_ctl,             
				data     	    => read_data_2(7 downto 0),
				SW	      	    => Switch,      	   
				clock     	    => clock,
				reset      	    => reset,
				LedG      	    => LedG,
				LedR            => LedR,
				Hex0            => H0,
				Hex1      	    => H1,
				Hex2      	    => H2,
				Hex3     	    => H3);
				
	he0:		hex_decoder  port map ( x=>H0(3 DOWNTO 0),Hout => Hex0 );
	he1:		hex_decoder  port map ( x=>H1(3 DOWNTO 0),Hout => Hex1 );
	he2:		hex_decoder  port map ( x=>H2(3 DOWNTO 0),Hout => Hex2 );
	he3:		hex_decoder  port map ( x=>H3(3 DOWNTO 0),Hout => Hex3 );
END structure;

