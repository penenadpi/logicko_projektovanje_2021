-- mod_full_adder.vhd
library ieee;
use ieee.std_logic_1164.all;

entity mod_full_adder is
	port (A, B, Cin : in std_logic;
		Sum, p, g : out std_logic);
end entity;

architecture mod_full_adder_arch of mod_full_adder is		
begin	
Sum <= (A xor B xor Cin) after 2 ns;
p   <= (A or B) 		 after 1 ns;
g   <= (A and B) 		 after 1 ns;
end architecture;

-- cla.vhd
library ieee;
use ieee.std_logic_1164.all;


entity cla_8bit is
	port (A, B : in std_logic_vector(7 downto 0);
		Sum  : out std_logic_vector(7 downto 0);
		Cout : out std_logic);
end entity;

architecture cla_8bit_arch of cla_8bit is	
	component mod_full_adder
port (A, B, Cin : in std_logic;
			Sum, p, g : out std_logic);
	end component;
 
	signal C0, C1, C2, C3, C4, C5, C6, C7 : std_logic;
	signal p, g					  : std_logic_vector(7 downto 0);
begin	
C0   <= '0';
C1   <= g(0) or (p(0) and C0) after 2 ns;
C2   <= g(1) or (p(1) and C1) after 2 ns;
C3   <= g(2) or (p(2) and C2) after 2 ns;
C4   <= g(3) or (p(3) and C3) after 2 ns;
C5   <= g(4) or (p(4) and C4) after 2 ns;
C6   <= g(5) or (p(5) and C5) after 2 ns;
C7   <= g(6) or (p(6) and C6) after 2 ns;
Cout <= g(7) or (p(7) and C7) after 2 ns;

A0 : mod_full_adder port map (A(0), B(0), C0, Sum(0), p(0), g(0)); 
A1 : mod_full_adder port map (A(1), B(1), C1, Sum(1), p(1), g(1));
A2 : mod_full_adder port map (A(2), B(2), C2, Sum(2), p(2), g(2));
A3 : mod_full_adder port map (A(3), B(3), C3, Sum(3), p(3), g(3));
A4 : mod_full_adder port map (A(4), B(4), C4, Sum(4), p(4), g(4));
A5 : mod_full_adder port map (A(5), B(5), C5, Sum(5), p(5), g(5));
A6 : mod_full_adder port map (A(6), B(6), C6, Sum(6), p(6), g(6));
A7 : mod_full_adder port map (A(7), B(7), C7, Sum(7), p(7), g(7));
end architecture;

-- cla_tb.vhd
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cla_8bit_TB is
end entity;

architecture cla_8bit_TB_arch of cla_8bit_TB is	
	component cla_8bit
port (A, B : in std_logic_vector(7 downto 0);
			Sum  : out std_logic_vector(7 downto 0);
			Cout : out std_logic);	
end component; 
	signal A_TB, B_TB, Sum_TB : std_logic_vector(7 downto 0);
signal Cout_TB		  : std_logic;	
begin
DUT : cla_8bit port map (A_TB, B_TB, Sum_TB, Cout_TB);
STIM : process
begin
for i in 0 to 255 loop
	for j in 0 to 255 loop
		A_TB <= std_logic_vector(to_unsigned(i,8));
		B_TB <= std_logic_vector(to_unsigned(j,8));
		wait for 30 ns;
	end loop;
end loop;
	end process;
end architecture;

