Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;

library STD;
use STD.textio.all;

entity SystemI is
	port (ABCD : in std_logic_vector(3 downto 0);
		F: out std_logic);
end entity;

architecture SystemI_arch of SystemI is	
begin
	SystemI_Proc : process (ABCD)
		begin
 			if    (ABCD="0001") then F <= '0';
			elsif (ABCD="1001") then F <= '0';
			elsif (ABCD="1011") then F <= '0';
			elsif (ABCD="1101") then F <= '0';
			else F <= '1';
end if;
		end process;
end architecture;


Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;

library STD;
use STD.textio.all;


entity SystemI_TB is
end entity;

architecture SystemI_TB_arch of SystemI_TB is
	component SystemI
		port (ABCD : in std_logic_vector(3 downto 0);
		F: out std_logic);
	end component;  

signal ABCD_TB : std_logic_vector(3 downto 0);
signal F_TB : std_logic;
signal i : integer;
begin

DUT1 : SystemI port map (ABCD => ABCD_TB,
				 F	=> F_TB);

STIMULUS: process

   file Fout: TEXT open WRITE_MODE is "output";
   file Fin: TEXT open READ_MODE is "input";
   variable current_wline : line;
   variable current_rline : line; 
   variable current_aux : std_logic_vector(3 downto 0);
   begin
    write(current_wline, string'("Input=ABCD, Output=F"));
    writeline(Fout, current_wline);  
	
for i in 0 to 15 loop
	readline(Fin, current_rline);
	read(current_rline, current_aux); 
        ABCD_TB<=current_aux;
	wait for 10 ns;
	write(current_wline, string'("ABCD="));
	write(current_wline, ABCD_TB);
	write(current_wline, string'("F="));
	write(current_wline, F_TB);
	writeline(Fout, current_wline);
end loop;	 
   wait;	
   end process;
end architecture;
