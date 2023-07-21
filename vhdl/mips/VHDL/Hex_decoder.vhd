LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
-------------------------------------
ENTITY hex_decoder IS
  PORT (  X: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		  Hout: OUT STD_LOGIC_VECTOR(6 downto 0)); 
END hex_decoder;
------------- complete the top Architecture code --------------
ARCHITECTURE struct OF hex_decoder IS 
	
BEGIN
process(x)
begin
    case x is
    when "0000" => Hout <= "1000000"; -- "0"        
    when "0001" => Hout <= "1111001"; -- "1"     
    when "0010" => Hout <= "0100100"; -- "2"     
    when "0011" => Hout <= "0110000"; -- "3"     
    when "0100" => Hout <= "0011001"; -- "4"     
    when "0101" => Hout <= "0010010"; -- "5"     
    when "0110" => Hout <= "0000010"; -- "6"     
    when "0111" => Hout <= "1111000"; -- "7"     
    when "1000" => Hout <= "0000000"; -- "8"        
    when "1001" => Hout <= "0010000"; -- "9"     
    when "1010" => Hout <= "0100000"; -- a       
    when "1011" => Hout <= "0000011"; -- b       
    when "1100" => Hout <= "1000110"; -- C       
    when "1101" => Hout <= "0100001"; -- d       
    when "1110" => Hout <= "0000110"; -- E       
    when "1111" => Hout <= "0001110"; -- F 
    when others => Hout <= "0001110"; -- F ;      
    end case;
end process;
	

	
END struct;

