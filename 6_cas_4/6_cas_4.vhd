library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.numeric_std_unsigned.all;

entity rw_16x8_sync is
	port (clock : in std_logic;
address  : in std_logic_vector(3 downto 0);
		data_in  : in std_logic_vector(7 downto 0);
		WE	   : in std_logic;
		data_out : out std_logic_vector(7 downto 0));
end entity;

architecture rw_16x8_sync_arch of rw_16x8_sync is	
	type RW_type is array (0 to 15) of std_logic_vector(7 downto 0);
	signal RW : RW_type;
	
begin	
	
	MEMORY : process (clock)
	begin
		if (clock'event and clock='1') then
			if (WE = '1') then
				RW(to_integer(unsigned(address))) <= data_in;
			else
				data_out <= RW(to_integer(unsigned(address)));
			end if;
		end if;
	end process;

end architecture;

entity rw_16x8_sync_TB is 
end entity; 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.numeric_std_unsigned.all;


architecture rw_16x8_sync_TB_arch of rw_16x8_sync_TB is 
component rw_16x8_sync 
port (clock   : in std_logic;
address  : in std_logic_vector(3 downto 0);
	data_in  : in std_logic_vector(7 downto 0);
	WE	   : in std_logic;
	data_out : out std_logic_vector(7 downto 0));
end component;
signal clock_TB	 : std_logic; 
signal address_TB  : std_logic_vector(3 downto 0);
signal data_in_TB  : std_logic_vector(7 downto 0);
signal WE_TB			 : std_logic;
signal data_out_TB : std_logic_vector(7 downto 0); 
begin 
DUT1: rw_16x8_sync port map (clock => clock_TB,
     address => address_TB,
     data_in => data_in_TB,
     WE => WE_TB,
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
WE_TB <= '0'; 
wait for 80 ns;
for i in 0 to 15 loop
		wait until rising_edge(clock_TB);
address_TB <= std_logic_vector(to_unsigned(i,4));
wait until rising_edge(clock_TB); 
report "adress= " & to_string(address_TB) & 
 " data_out= " & to_string(data_out_TB);
wait for 80 ns;
	end loop;

WE_TB <= '1';
wait for 80 ns;
for i in 0 to 15 loop
wait until rising_edge(clock_TB);
address_TB <= std_logic_vector(to_unsigned(i,4));
wait until rising_edge(clock_TB); 
	data_in_TB <= std_logic_vector(to_unsigned(i,8));	
wait for 80 ns;
end loop;

WE_TB <= '0';
wait for 80 ns;
for i in 0 to 15 loop	
	wait until rising_edge(clock_TB);
address_TB <= std_logic_vector(to_unsigned(i,4));
wait until rising_edge(clock_TB); 
report "adress= " & to_string(address_TB) & 
 " data_out= " & to_string(data_out_TB);
wait for 80 ns;
end loop;

end process;

end architecture; 

