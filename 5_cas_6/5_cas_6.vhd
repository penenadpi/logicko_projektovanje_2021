Library IEEE;
use IEEE.std_logic_1164.all;

entity Shift_Register is
	port (Clock, Reset 	     : in std_logic;
		Din 		 	     : in std_logic_vector(15 downto 0);		
		A, B, C, D, E, F, G, H : out std_logic_vector(15 downto 0));
end entity;

architecture Shift_Register_arch of Shift_Register is		
	signal DA, DB, DC, DD, DE, DF, DG, DH: std_logic_vector(15 downto 0);
	begin

Reg_Proc : process (Clock, Reset)
		begin
 			if (Reset='0') then
DA <= x"0001"; DB <= x"0002"; DC <= x"0003"; DD <= x"0000";
DE <= x"0000"; DF <= x"0000"; DG <= x"0000"; DH <= x"0000";
			elsif (Clock'event and Clock='1') then
				DA <= Din; DB <= DA; DC <= DB; DD <= DC;
DE <= DD; DF <= DE; DG <= DF; DH <= DG;
end if;
	end process;
	A <= DA; B <= DB; C <= DC; D <= DD; E <= DE; F <= DF; G <= DG; H <= DH; 

end architecture;


Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Shift_Register_TB is
end entity;

architecture Shift_Register_TB_arch of Shift_Register_TB is
component Shift_Register is
	port (Clock, Reset 	     : in std_logic;
		Din 		 	     : in std_logic_vector(15 downto 0);		
		A, B, C, D, E, F, G, H : out std_logic_vector(15 downto 0));
end component;

	signal Clock_TB : std_logic;
	signal Reset_TB: std_logic;
	signal Din_TB 		 	     : std_logic_vector(15 downto 0);		
	signal A_TB, B_TB, C_TB, D_TB, E_TB, F_TB, G_TB, H_TB : std_logic_vector(15 downto 0);
	
begin
	DUT1: Shift_Register port map (Clock => Clock_TB, Reset => Reset_TB, Din => Din_TB, A => A_TB,  B => B_TB,  C => C_TB,  D => D_TB,  E => E_TB,  F => F_TB,  G => G_TB,  H => H_TB );

	STIMULUS : process

	begin
	
		Reset_TB <= '0'; wait for 100 ps;
		Reset_TB <= '1'; wait for 100 ps;
		Din_TB <= x"0004"; wait for 100 ps;
		Clock_TB <= '0'; wait for 100 ps;
		Clock_TB <= '1'; wait for 100 ps;	
		Clock_TB <= '0'; wait for 100 ps;
		Clock_TB <= '1'; wait for 100 ps;	
			
	end process;

end architecture;
