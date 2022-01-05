library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.numeric_std_unsigned.all;

entity rom_16x8_async is
	port (address  : in std_logic_vector(3 downto 0);
		data_out : out std_logic_vector(7 downto 0));
end entity;

architecture rom_16x8_async_arch of rom_16x8_async is	
	type ROM_type is array (0 to 15) of std_logic_vector(7 downto 0);

	constant ROM : ROM_type := (0  => x"00",
					    1  => x"11",	
					    2  => x"22",	
					    3  => x"33",	
					    4  => x"44",	
					    5  => x"55",	
					    6  => x"66",	
					    7  => x"77",	
					    8  => x"88",	
					    9  => x"99",	
					    10 => x"AA",	
					    11 => x"BB",	
					    12 => x"CC",	
					    13 => x"DD",	
					    14 => x"EE",	
					    15 => x"FF");
begin	
	
	data_out <= ROM(to_integer(unsigned(address)));
end architecture;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.numeric_std_unsigned.all;

entity rom_16x8_async_TB is 
end entity; 
architecture rom_16x8_async_TB_arch of rom_16x8_async_TB is 
component rom_16x8_async 
port (address  : in std_logic_vector(3 downto 0);
		data_out : out std_logic_vector(7 downto 0));
end component; 
signal address_TB  : std_logic_vector(3 downto 0);
signal data_out_TB : std_logic_vector(7 downto 0); 
begin 
DUT1: rom_16x8_async port map (address => address_TB, 
 data_out => data_out_TB); 
STIMULUS : process
begin
for i in 0 to 15 loop 
address_TB <= std_logic_vector(to_unsigned(i,4));
report "adress= " & to_string(address_TB) & 
 " data_out=" & to_string(data_out_TB);
wait for 30 ns;
		end loop;
end process;
end architecture; 

