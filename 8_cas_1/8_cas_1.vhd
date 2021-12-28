-- half_adder.vhd
library ieee;
use ieee.std_logic_1164.all;

entity half_adder is
	port (A, B      : in std_logic;
		Sum, Cout : out std_logic);
end entity;

architecture half_adder_arch of half_adder is		
begin	
Sum <= A xor B after 1 ns;
Cout <= A and B after 1 ns;
end architecture;


-- full_adder.vhd
library ieee;
use ieee.std_logic_1164.all;

entity full_adder is
	port (A, B, Cin : in std_logic;
		Sum, Cout : out std_logic);
end entity;

architecture full_adder_arch of full_adder is		
component half_adder
port (A, B : in std_logic;
		Sum, Cout  : out std_logic);
	end component;
	signal HA1_Sum, HA1_Cout, HA2_Cout : std_logic;
begin	
HA1 : half_adder port map (A, B, HA1_Sum, HA1_Cout);
HA2 : half_adder port map (HA1_Sum, Cin, Sum, HA2_Cout);
Cout <= HA1_Cout or HA2_Cout after 1 ns;
end architecture;

-- rca.vhd
library ieee;
use ieee.std_logic_1164.all;

entity rca_8bit is
	port (A, B : in std_logic_vector(7 downto 0);
		Sum  : out std_logic_vector(7 downto 0);
		Cout : out std_logic);
end entity;

architecture rca_8bit_arch of rca_8bit is	
	component full_adder
port (A, B, Cin : in std_logic;
			Sum, Cout : out std_logic);
	end component;
 
	signal C1, C2, C3, C4, C5, C6, C7 : std_logic;
begin	
A0 : full_adder port map (A(0), B(0), '0', Sum(0), C1);
A1 : full_adder port map (A(1), B(1), C1, Sum(1), C2);
A2 : full_adder port map (A(2), B(2), C2, Sum(2), C3);
A3 : full_adder port map (A(3), B(3), C3, Sum(3), C4);
A4 : full_adder port map (A(4), B(4), C4, Sum(4), C5);
A5 : full_adder port map (A(5), B(5), C5, Sum(5), C6);
A6 : full_adder port map (A(6), B(6), C6, Sum(6), C7);
A7 : full_adder port map (A(7), B(7), C7, Sum(7), Cout);
end architecture;

-- rca_tb.vhd
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rca_8bit_TB is
end entity;

architecture rca_8bit_TB_arch of rca_8bit_TB is	
	component rca_8bit
port (A, B : in std_logic_vector(7 downto 0);
			Sum  : out std_logic_vector(7 downto 0);
			Cout : out std_logic);	
end component; 
	signal A_TB, B_TB, Sum_TB : std_logic_vector(7 downto 0);
signal Cout_TB		  : std_logic;	
begin
DUT : rca_8bit port map (A_TB, B_TB, Sum_TB, Cout_TB);
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

