entity System1_3 is
port (A,B,C : in bit;
F: out bit);
end entity;
architecture System1_3_arch of System1_3 is
begin
with (A&B&C) select
 F <= '1' when "001",
 '1' when "011",
 '1' when "100",
 '1' when "110",
 '0' when others;
end architecture;


entity System1_3_TB is
end entity;

architecture System1_3_TB_arch of System1_3_TB is
	component System1_3
		port (A,B,C : in bit;
		F: out bit);
	end component;
	signal A_TB,B_TB,C_TB: bit;
	signal F_TB : bit;
	
begin
	DUT1: System1_3 port map (A => A_TB, B=>B_TB, C=>C_TB, F => F_TB);

	STIMULUS : process

	begin
		A_TB <= '0'; B_TB<='0'; C_TB<='1'; wait for 100 ps;
		A_TB <= '1'; B_TB<='1'; C_TB<='1'; wait for 100 ps;
	end process;

end architecture;
