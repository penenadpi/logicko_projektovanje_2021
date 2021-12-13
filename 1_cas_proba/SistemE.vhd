entity SystemE is
port (A,B,C : in bit;
F: out bit);
end entity;
architecture SystemE_arch of SystemE is
	signal An, Bn, Cn : bit;
	signal m1, m3, m4, m6 : bit;
begin
	An <= not A;
	Bn <= not B;
	Cn <= not C;
	m1 <= An and Bn and C;
	m3 <= An and B and C;
	m4 <= A and Bn and Cn;
	m6 <= A and B and Cn;
	F <= m1 or m3 or m4 or m6;
end architecture;

entity SystemE_TB is
end entity;

architecture SystemE_TB_arch of SystemE_TB is
	component SystemE
		port (A,B,C : in bit;
		F: out bit);
	end component;
	signal A_TB, B_TB, C_TB : bit;
	signal F_TB : bit;
	
begin
	DUT1: SystemE port map (A => A_TB, B => B_TB, C => C_TB, F => F_TB);

	STIMULUS : process

	begin
		A_TB <= '0'; B_TB <= '1'; C_TB <='1'; wait for 100 ps;
		A_TB <= '1'; B_TB <= '1'; C_TB <='1'; wait for 100 ps;
	end process;

end architecture;
