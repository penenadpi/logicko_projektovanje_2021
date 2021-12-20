Library IEEE;
use IEEE.std_logic_1164.all;
entity ShiftRegister is
	port (D : 	  in  std_logic_vector(3 downto 0);
		Clock : in  std_logic;	
		W : out std_logic_vector(3 downto 0);
X : out std_logic_vector(3 downto 0);
Y : out std_logic_vector(3 downto 0);
Z : out std_logic_vector(3 downto 0));
end entity;

architecture ShiftRegister_arch of ShiftRegister is	
begin
	ShiftRegister_Proc : process (Clock)
		begin
			if (rising_edge(Clock)) then
				Z <= Y;				
 				Y <= X;
				X <= W;
				W <= D;
			End if;
		end process;
end architecture;

