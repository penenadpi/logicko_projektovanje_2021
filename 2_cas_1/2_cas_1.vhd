entity decoder_1hot_4to16 is
	port (A : in  bit_vector (3 downto 0);
		F : out bit_vector (15 downto 0));
end entity;

architecture decoder_1hot_4to16_arch of decoder_1hot_4to16 is	
begin
	F(0) <= not A(3) and not A(2) and not A(1) and not A(0);
	F(1) <= not A(3) and not A(2) and not A(1) and A(0);
	F(2) <= not A(3) and not A(2) and A(1) and not A(0);
	F(3) <= not A(3) and not A(2) and A(1) and A(0);
	F(4) <= not A(3) and A(2) and not A(1) and not A(0);
	F(5) <= not A(3) and A(2) and not A(1) and A(0);
	F(6) <= not A(3) and A(2) and A(1) and not A(0);
	F(7) <= not A(3) and A(2) and A(1) and A(0);
	F(8) <= A(3) and not A(2) and not A(1) and not A(0);
	F(9) <= A(3) and not A(2) and not A(1) and A(0);
	F(10) <= A(3) and not A(2) and A(1) and not A(0);
	F(11) <= A(3) and not A(2) and A(1) and not A(0);
	F(12) <= A(3) and A(2) and not A(1) and not A(0);
	F(13) <= A(3) and A(2) and not A(1) and A(0);
	F(14) <= A(3) and A(2) and A(1) and not A(0);
	F(15) <= A(3) and A(2) and A(1) and A(0);
end architecture;


entity decoder_1hot_4to16_TB is
end entity;

architecture decoder_1hot_4to16_TB_arch of decoder_1hot_4to16_TB is
component decoder_1hot_4to16
	port (A : in  bit_vector (3 downto 0);
		F : out bit_vector (15 downto 0));
end component;

	signal A_TB : bit_vector (3 downto 0);
	signal F_TB : bit_vector(15 downto 0);
	
begin
	DUT1: decoder_1hot_4to16 port map (A => A_TB, F => F_TB);

	STIMULUS : process

	begin
		A_TB <= "0001"; wait for 100 ps;
		A_TB <= "1000"; wait for 100 ps;
		A_TB <= "1001"; wait for 100 ps;
	end process;

end architecture;

