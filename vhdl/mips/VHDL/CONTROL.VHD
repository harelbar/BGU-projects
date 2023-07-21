		-- control module (implements MIPS control unit)
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;

ENTITY control IS
   PORT( 	
	Opcode 		: IN 	STD_LOGIC_VECTOR( 5 DOWNTO 0 );
	func_opc	: IN 	STD_LOGIC_VECTOR( 5 DOWNTO 0 );
	RegDst 		: OUT 	STD_LOGIC;
	ALUSrc 		: OUT 	STD_LOGIC;
	MemtoReg 	: OUT 	STD_LOGIC_VECTOR ( 1 downto 0);
	RegWrite 	: OUT 	STD_LOGIC;
	MemRead 	: OUT 	STD_LOGIC;
	MemWrite 	: OUT 	STD_LOGIC;
	Branch 		: OUT 	STD_LOGIC;
	BranchNeq   : OUT 	STD_LOGIC;
	ALUop 		: OUT 	STD_LOGIC_VECTOR( 1 DOWNTO 0 );
	LUI 		: OUT 	STD_LOGIC;
	Jump	    : OUT 	STD_LOGIC;
	JR   	    : OUT 	STD_LOGIC;
	ADDI  	    : OUT 	STD_LOGIC;
	MUL  	    : OUT 	STD_LOGIC;
	clock, reset: IN 	STD_LOGIC );

END control;

ARCHITECTURE behavior OF control IS

	SIGNAL  R_format, Lw, Sw, Beq, SLUI, Bnq, JAL,SJ,J,SADDI,SMUL,SANDI,SORI,SXORI,shift,SLTI,Imm	: STD_LOGIC;

BEGIN           
				-- Code to generate control signals using opcode bits
	R_format 	<=  '1'  WHEN  Opcode = "000000"  ELSE '0';
	Lw          <=  '1'  WHEN  Opcode = "100011"  ELSE '0';
 	Sw          <=  '1'  WHEN  Opcode = "101011"  ELSE '0';
   	Beq         <=  '1'  WHEN  Opcode = "000100"  ELSE '0';
	Bnq			<=  '1'  WHEN  Opcode = "000101"  ELSE '0';
	SLUI   	    <=  '1'  WHEN  Opcode = "001111"  ELSE '0';
	JAL   	    <=  '1'  WHEN  Opcode = "000011"  ELSE '0';
	J   	    <=  '1'  WHEN  Opcode = "000010"  ELSE '0';
	SADDI		<=  '1'  WHEN  Opcode = "001000"  ELSE '0';
	SMUL		<=  '1'  WHEN  Opcode = "011100"  ELSE '0';
	SANDI		<=  '1'  WHEN  Opcode = "001100"  ELSE '0';
	SORI		<=  '1'  WHEN  Opcode = "001101"  ELSE '0';
	SXORI		<=  '1'  WHEN  Opcode = "001110"  ELSE '0';
	SLTI		<=  '1'  WHEN  Opcode = "001010"  ELSE '0';
	SJ   	    <=  '1'  WHEN  func_opc = "001000"  ELSE '0';
	shift   	<=  '1'  WHEN  func_opc = "000000" or func_opc = "000010" ELSE '0';	
	JR          <=  R_format and SJ;
	Imm			<=  SLUI OR SADDI or SORI or SXORI or SANDI or SLTI;
	Jump		<=  J or JAL;
  	RegDst    	<=  (R_format or SMUL) or ( shift and R_format);
 	ALUSrc  	<=  Lw OR Sw or Imm;
	MemtoReg(0)	<=  Lw;
	MemtoReg(1)	<=  JAL;
  	RegWrite 	<=  R_format OR Lw  or SMUL or JAL or Imm;
  	MemRead 	<=  Lw;
   	MemWrite 	<=  Sw; 
 	Branch      <=  Beq;
	BranchNeq   <=  Bnq;
	LUI         <=  SLUI;
	ADDI        <=  SADDI;
	MUL         <=  SMUL;
	ALUOp( 1 ) 	<=  R_format or Imm;
	ALUOp( 0 ) 	<=  Beq; 

   END behavior;


