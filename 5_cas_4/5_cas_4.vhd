Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.numeric_std_unsigned.all;

entity Counter_16bit_Up is
	port (Clock, Reset : in std_logic;		
		CNT		 : out std_logic_vector(15 downto 0)
);
end entity;

architecture Counter_16bit_Up_arch of Counter_16bit_Up is		
	
signal CNT_int : integer range 0 to 65535;
begin

COUNTER : process (Clock, Reset)
		begin
 			if (Reset='0') then
CNT_int <= 0;
			elsif (Clock'event and Clock='1') then
				if (CNT_int = 65535) then 
	CNT_int <= 0;
				else
CNT_int <= CNT_int + 1;
				end if;
end if;
	end process;

	CNT <= std_logic_vector(to_unsigned(CNT_int,16));
end architecture;


Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Counter_16bit_Up_TB is
end entity;

architecture Counter_16bit_Up_TB_arch of Counter_16bit_Up_TB is
component Counter_16bit_Up is
	port (Clock, Reset : in std_logic;		
		CNT : out std_logic_vector(15 downto 0));
end component;

	signal Clock_TB : std_logic;
	signal Reset_TB: std_logic;
	signal CNT_TB : std_logic_vector(15 downto 0);
	
begin
	DUT1: Counter_16bit_Up port map (Clock => Clock_TB, Reset => Reset_TB, CNT => CNT_TB);

	STIMULUS : process

	begin
		Clock_TB <= '1'; wait for 100 ps;
		Clock_TB <= '0'; wait for 100 ps;		
	end process;

end architecture;
