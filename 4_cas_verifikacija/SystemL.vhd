Library IEEE;
use IEEE.std_logic_1164.all;
entity SystemL is
	port (ABCD : in std_logic_vector(3 downto 0);
		F: out std_logic);
end entity;

architecture SystemL_arch of SystemL is	
begin
	SystemL_Proc : process (ABCD)
		begin
 			case (ABCD) is
				when "0001" | "0011" | "1001" | "1011"  => F <= '1';
				when others 				=> F <= '0';
			end case;
		end process;
end architecture;


Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;

library STD;
use STD.textio.all;

entity SystemL_TB is
end entity;

architecture SystemL_TB_arch of SystemL_TB is

	component SystemL
		port (ABCD : in std_logic_vector(3 downto 0);
		F: out std_logic);
	end component;  

signal ABCD_TB : std_logic_vector(3 downto 0);
signal F_TB : std_logic;

begin

DUT1 : SystemL port map (ABCD => ABCD_TB,
				 F	=> F_TB);

STIMULUS: process
   begin
	ABCD_TB <= "0000"; wait for 10 ns;
	assert (F_TB='0') report "Test je neuspesan za 0000" severity FAILURE;
	assert (F_TB='1') report "Test je uspesan za 0000" severity NOTE;

ABCD_TB <= "0001"; wait for 10 ns;
	assert (F_TB='1') report "Test je neuspesan za 0001" severity FAILURE;
	assert (F_TB='0') report "Test je uspesan za 0001" severity NOTE;
   end process;
end architecture;
