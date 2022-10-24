entity System1_2 is
port (A,B,C : in bit;
F: out bit);
end entity;
architecture System1_2_arch of System1_2 is
begin
F <= '1' when (A='0' and B='0' and C='1') else
     '1' when (A='0' and B='1' and C='1') else
     '1' when (A='1' and B='0' and C='0') else
     '1' when (A='1' and B='1' and C='0') else
     '0';
end architecture;

entity System1_2_TB is
end entity;

architecture System1_2_TB_arch of System1_2_TB is
	component System1_2
		port (A,B,C : in bit;
		F: out bit);
	end component;
	signal A_TB, B_TB, C_TB : bit;
	signal F_TB : bit;
	
begin
	DUT1: System1_2 port map (A => A_TB, B => B_TB, C => C_TB, F => F_TB);

	STIMULUS : process

	begin
		A_TB <= '0'; B_TB <= '1'; C_TB <='1'; wait for 100 ps;
		A_TB <= '1'; B_TB <= '1'; C_TB <='1'; wait for 100 ps;
	end process;

end architecture;
