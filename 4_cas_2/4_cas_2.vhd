Library IEEE;
use IEEE.std_logic_1164.all;
entity SystemI is
	port (ABCD : in std_logic_vector(3 downto 0);
		F: out std_logic);
end entity;

architecture SystemI_arch of SystemI is	
begin
	SystemI_Proc : process (ABCD)
		begin
 			case (ABCD) is
				when "0000" | "0011" | "1001" | "1011"  => F <='1';
				when others 				    => F <='0';
end case;
		end process;
end architecture;



Library IEEE;
use IEEE.std_logic_1164.all;

entity SystemI_TB is
end entity;

architecture SystemI_TB_arch of SystemI_TB is
component SystemI
	port (ABCD : in  std_logic_vector (3 downto 0);
		F : out std_logic);
end component;

	signal ABCD_TB : std_logic_vector (3 downto 0);
	signal F_TB : std_logic;
	
begin
	DUT1: SystemI port map (ABCD => ABCD_TB, F => F_TB);

	STIMULUS : process

	begin
		ABCD_TB <= "1001"; wait for 100 ps;
		ABCD_TB <= "0001"; wait for 100 ps;
		ABCD_TB <= "1011"; wait for 100 ps;
	end process;

end architecture;

