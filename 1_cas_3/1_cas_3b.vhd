entity System1_3 is
port (ABC : in bit_vector(2 downto 0);
F: out bit);
end entity;
architecture System1_3_arch of System1_3 is
begin
with (ABC) select
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
		port (ABC : in bit_vector(2 downto 0);
		F: out bit);
	end component;
	signal ABC_TB: bit_vector(2 downto 0);
	signal F_TB : bit;
	
begin
	DUT1: System1_3 port map (ABC => ABC_TB, F => F_TB);

	STIMULUS : process

	begin
		ABC_TB <= "001"; wait for 100 ps;
		ABC_TB <= "111"; wait for 100 ps;
	end process;

end architecture;
