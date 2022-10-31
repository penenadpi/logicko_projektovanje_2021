entity mux_8to1 is
port (A : in bit_vector (7 downto 0);
Sel : in bit_vector (2 downto 0);
F : out bit);
end entity;
architecture mux_8to1_arch of mux_8to1 is
begin
F <= A(7) when (Sel = "000") else
 A(6) when (Sel = "001") else
 A(5) when (Sel = "010") else
 A(4) when (Sel = "011") else
 A(3) when (Sel = "100") else
 A(2) when (Sel = "101" ) else
 A(1) when (Sel = "110") else
 A(0) when (Sel = "111" ); 
end architecture;


entity mux_8to1_TB is
end entity;

architecture mux_8to1_TB_arch of mux_8to1_TB is
component mux_8to1 is
port (A : in bit_vector (7 downto 0);
Sel : in bit_vector (2 downto 0);
F : out bit);
end component;

	signal A_TB : bit_vector (7 downto 0);
	signal Sel_TB :  bit_vector(2 downto 0);
	signal F_TB :  bit ;
	
begin
	DUT1: mux_8to1 port map (A => A_TB, Sel=> Sel_TB, F => F_TB);

	STIMULUS : process

	begin
		A_TB <= "00001001"; Sel_TB <= "000"; wait for 100 ps;
		A_TB <= "00001001"; Sel_TB <= "111"; wait for 100 ps;
	end process; 

end architecture;