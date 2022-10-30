entity INV1 is
port (A : in bit;
 F : out bit);
end entity;
architecture INV1_arch of INV1 is
begin
F <= not A;
end architecture;
entity AND3 is
port (A,B,C : in bit;
 F : out bit);
end entity;
architecture AND3_arch of AND3 is
begin
F <= A and B and C;
end architecture;
entity OR4 is
port (A,B,C,D : in bit;
 F : out bit);
end entity;
architecture OR4_arch of OR4 is
begin
F <= A or B or C or D;
end architecture;


entity ComponentsSystem is
port (A,B,C : in bit;
 F : out bit);
end entity;

architecture ComponentsSystem_arch of ComponentsSystem is
signal An, Bn, Cn : bit;
signal m1, m3, m4, m6 : bit;
component INV1 is
port (A : in bit;
 F : out bit);
end component;
component AND3 is
port (A,B,C : in bit;
 F : out bit);
end component;
component OR4 is
port (A,B,C,D : in bit;
 F : out bit);
end component;
begin
U1 : INV1 port map (A=>A, F=>An);
U2 : INV1 port map (A=>B, F=>Bn);
U3 : INV1 port map (A=>C, F=>Cn);
U4 : AND3 port map (A=>An, B=>Bn, C=>C, F=>m1);
U5 : AND3 port map (A=>An, B=>B, C=>C, F=>m3);
U6 : AND3 port map (A=>A, B=>Bn, C=>Cn, F=>m4);
U7 : AND3 port map (A=>A, B=>B, C=>Cn, F=>m6);
U8 : OR4 port map (A=>m1, B=>m3, C=>m4, D=>m6, F=>F);
end architecture;

entity ComponentsSystem_TB is
end entity;

architecture ComponentsSystem_TB_arch of ComponentsSystem_TB is
	component ComponentsSystem
		port (A,B,C : in bit;
		F: out bit);
	end component;
	signal A_TB, B_TB, C_TB : bit;
	signal F_TB : bit;
	
begin
	DUT1: ComponentsSystem port map (A => A_TB, B => B_TB, C => C_TB, F => F_TB);

	STIMULUS : process

	begin
		A_TB <= '0'; B_TB <= '1'; C_TB <='1'; wait for 100 ps;
		A_TB <= '1'; B_TB <= '1'; C_TB <='1'; wait for 100 ps;
	end process;

end architecture;