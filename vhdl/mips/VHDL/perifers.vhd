
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;



ENTITY  perifers IS
	PORT(	memWrite, MemRead   :in std_logic;
			CS_ctl              :in std_logic_vector (3 downto 0);
			data				:in std_logic_vector (7 downto 0);
			SW      	       :in std_logic_vector (7 downto 0);
			clock, reset		: IN STD_LOGIC;
			LedG,LedR,Hex0,Hex1,Hex2,Hex3 :out std_logic_vector(7 downto 0));
END perifers;

ARCHITECTURE behavior OF perifers IS
SIGNAL CS 		: STD_LOGIC_VECTOR( 5 DOWNTO 0 );
signal en0,en1,en2,en3,en4,en5 : std_logic;

BEGIN		
		en0 <=CS(0) AND memWrite;
		en1 <=CS(1) AND memWrite;
		en2 <=CS(2) AND memWrite;
		en3 <=CS(3) AND memWrite;
		en4 <=CS(4) AND memWrite;
		en5 <=CS(5) AND memWrite;
		
PROCESS ( CS_ctl, clock, reset )
	BEGIN
					-- Select CS values. cs0=LG, cs1=LR, cs2=HEX0, cs3=HEX1, cs4=HEX2, cs5=HEX3
 	CASE CS_ctl(3 downto 0) IS
						
		WHEN "1000" 	=>	CS 	<= "000001" ; 
						
     	WHEN "1001" 	=>	CS 	<= "000010" ;
						
	 	WHEN "1010" 	=>  CS 	<= "000100" ;
						
 	 	WHEN "1011" 	=>  CS 	<= "001000"; 
					
 	 	WHEN "1100" 	=>  CS	<= "010000"; 
						
 	 	WHEN "1101" 	=>	CS 	<= "100000"; 
						
 	 	WHEN OTHERS	=>	CS 	<= "000000"; 
  	END CASE;
  END PROCESS;
			R0:	PROCESS (reset,en0)
					BEGIN
					IF (reset = '1') THEN
						LedG <= x"00";
					ELSIF (RISING_EDGE(en0) and en0='1') THEN		
						LedG <= data;
					END IF; 	 	
				END PROCESS;						
			R1:	PROCESS (reset,en1)
					BEGIN
					IF (reset = '1') THEN
						LedR <= x"00";
					ELSIF (RISING_EDGE(en1) and en1='1') THEN		
						LedR <= data;
					END IF; 	 	
				END PROCESS;
			R2:	PROCESS (reset,en2)
					BEGIN
					IF (reset = '1') THEN
						HEX0 <= x"00";
					ELSIF (RISING_EDGE(en2) and en2='1') THEN		
						HEX0 <= data;
					END IF; 	 	
				END PROCESS;
			R3:	PROCESS (reset,en3)
					BEGIN
					IF (reset = '1') THEN
						HEX1 <= x"00";
					ELSIF (RISING_EDGE(en3) and en3='1') THEN		
						HEX1 <= data;
					END IF; 	 	
				END PROCESS;
			R4:	PROCESS (reset,en4)
					BEGIN
					IF (reset = '1') THEN
						HEX2 <= x"00";
					ELSIF (RISING_EDGE(en4) and en4='1') THEN		
						HEX2 <= data;
					END IF; 	 	
				END PROCESS;	
			R5:	PROCESS (reset,en5)
					BEGIN
					IF (reset = '1') THEN
						HEX3 <= x"00";
					ELSIF (RISING_EDGE(en5) and en5='1') THEN		
						HEX3 <= data;
					END IF; 	 	
				END PROCESS;				


END behavior;
