library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all; 
 
entity freq_divider is 
	GENERIC( m : INTEGER :=1 );
	port ( InClk : in std_logic;	
		    OutClk: out std_logic); 
end freq_divider;
---------------------------------------------------------------
architecture rtl of freq_divider is
    signal q_int : std_logic_vector (27 downto 0) :=x"0000000";
begin
	process (InClk)
	begin
		if (rising_edge(InClk)) then	   
			q_int <= q_int + 1;
		end if;
    end process;
	OutClk <= q_int(m);
end rtl;



