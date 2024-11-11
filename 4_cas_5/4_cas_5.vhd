-- Koristiti 1076-2008
-- Project->Desni klik na .vhd->Properties->VHDL->1076-2008
Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity counter_integer_up is
	port (Count : inout std_logic_vector(4 downto 0));
end entity;

architecture counter_integer_up_arch of counter_integer_up is	
signal i : integer;
begin
	counter_integer_up_Proc : process

		begin
			for i in 0 to 31 loop
					Count <= std_logic_vector(to_unsigned(i, 5));		
 				wait for 10 ns;
				report  to_string(Count);
			end loop;
		end process;
end architecture;

