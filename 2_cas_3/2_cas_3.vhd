entity decoder_7seg_4in is
	port (A : in  bit_vector (3 downto 0);
		F : out bit_vector (6 downto 0));
end entity;

architecture decoder_7seg_4in_arch of decoder_7seg_4in is
begin
	with (A) select 
F <= "1111110" when "0000",
     "0110000" when "0001",
     "1101101" when "0010",
     "1111001" when "0011",
     "0110011" when "0100",
     "1011011" when "0101",
     "1011111" when "0110",
     "1110000" when "0111",
     "1111111" when "1000",
     "1111011" when "1001",
     "1110111" when "1010",
     "0011111" when "1011",
     "0001101" when "1100",
     "0111101" when "1101",
     "1001111" when "1110",
     "1000111" when "1111";
end architecture;



entity decoder_7seg_4in_TB is
end entity;

architecture decoder_7seg_4in_TB_arch of decoder_7seg_4in_TB is
component decoder_7seg_4in
	port (A : in  bit_vector (3 downto 0);
		F : out bit_vector (6 downto 0));
end component;

	signal A_TB : bit_vector (3 downto 0);
	signal F_TB : bit_vector(6 downto 0);
	
begin
	DUT1: decoder_7seg_4in port map (A => A_TB, F => F_TB);

	STIMULUS : process

	begin
		A_TB <= "0000"; wait for 100 ps;
		A_TB <= "0001"; wait for 100 ps;
		A_TB <= "1001"; wait for 100 ps;
	end process;

end architecture;



