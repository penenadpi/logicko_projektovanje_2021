Library IEEE;
use IEEE.std_logic_1164.all;
entity counter_integer_up is
	port (Count : out integer);
end entity;

architecture counter_integer_up_arch of counter_integer_up is	
signal i : integer;
begin
	counter_integer_up_Proc : process

		begin
			for i in 0 to 31 loop
					Count <= i;	
			report integer'image(Count);
 				wait for 10 ns;
			
			end loop;
		end process;
end architecture;

