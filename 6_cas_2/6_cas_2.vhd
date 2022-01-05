library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.numeric_std_unsigned.all;

entity rom_16x8_sync is
	port (clock	   : in std_logic;
address  : in std_logic_vector(3 downto 0);
		data_out : out std_logic_vector(7 downto 0));
end entity;

architecture rom_16x8_sync_arch of rom_16x8_sync is	
	type ROM_type is array (0 to 15) of std_logic_vector(7 downto 0);

	constant ROM : ROM_type := (0  => x"FF",
					    1  => x"EE",	
					    2  => x"DD",	
					    3  => x"CC",	
					    4  => x"BB",	
					    5  => x"AA",	
					    6  => x"99",	
					    7  => x"88",	
					    8  => x"77",	
					    9  => x"66",	
					    10 => x"55",	
					    11 => x"44",	
					    12 => x"33",	
					    13 => x"22",	
					    14 => x"11",	
					    15 => x"00");
begin	
	
	MEMORY : process (clock)
		begin
			if (clock'event and clock='1') then
				data_out <= ROM(to_integer(unsigned(address)));
			end if;
	end process;

end architecture;


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.numeric_std_unsigned.all;

entity rom_16x8_sync_TB is 
end entity; 

architecture rom_16x8_sync_TB_arch of rom_16x8_sync_TB is 
component rom_16x8_sync 
port (clock : std_logic;
address  : in std_logic_vector(3 downto 0);
		data_out : out std_logic_vector(7 downto 0));
end component; 
signal clock_TB 	 : std_logic;
signal address_TB  : std_logic_vector(3 downto 0);
signal data_out_TB : std_logic_vector(7 downto 0); 
begin 
DUT1: rom_16x8_sync port map (clock => clock_TB,
address => address_TB, 
data_out => data_out_TB); 

CLOCK_PROCESS : process
begin
	clock_TB <= '0'; wait for 5 ns;
	clock_TB <= '1'; wait for 5 ns;
	clock_TB <= '0'; wait for 5 ns;
	clock_TB <= '1'; wait for 5 ns;
end process;

STIMULUS : process

begin
for i in 0 to 15 loop
	wait until rising_edge(clock_TB); 
address_TB <= std_logic_vector(to_unsigned(i,4));
	 
report "adress= " & to_string(address_TB) & 
 " data_out=" & to_string(data_out_TB);
wait until rising_edge(clock_TB); 
		end loop; 
end process;
end architecture; 

