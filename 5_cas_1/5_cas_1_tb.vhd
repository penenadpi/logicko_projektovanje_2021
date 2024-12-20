
Library IEEE;
use IEEE.std_logic_1164.all;

entity Seq_Det_behavioral is
	port (Clock, Reset : in std_logic;
		DIN		 : in std_logic;
		FOUND		 : out std_logic);
end entity;

architecture Seq_Det_behavioral_arch of Seq_Det_behavioral is	
	type State_Type is (Start, D0_0, D0_1, D1_0, D1_1, D2_0, D2_1);
	signal current_state, next_state : State_Type;	
begin

STATE_MEMORY : process (Clock, Reset)
		begin
 			if (Reset='0') then
				current_state <= Start;
			elsif (Clock'event and Clock='1') then 
				current_state <= next_state;
			end if;
end process;

	


NEXT_STATE_LOGIC : process (current_state, DIN)
		begin
			case (current_state) is
 				when Start => if (DIN = '1') then
							next_state <= D0_1;
						  else 
							next_state <= D0_0;
						  end if;
				when D0_0 =>  if (DIN = '1') then
							next_state <= D1_1;
						  else 
							next_state <= D1_0;
						  end if;
				when D1_1 =>  if (DIN = '1') then
							next_state <= D2_1;
						  else 
							next_state <= D2_0;
						  end if;
				when D0_1 =>  next_state <= D1_0;
				when D1_0 =>  next_state <= D2_1;
				when D2_0 =>  next_state <= Start;
				when D2_1 =>  next_state <= Start;
				when others => next_state <= Start;
				end case;
				end process;
	
OUTPUT_LOGIC : process (current_state, DIN)
		begin
			case (current_state) is
 				when D2_0   => if (DIN = '1') then
							  FOUND <= '1';
						   else 
							  FOUND <= '0';
						   end if;
				when others => FOUND <= '0';
end case;
	end process;

end architecture;



Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Seq_Det_behavioral_TB is
end entity;

architecture Seq_Det_behavioral_TB_arch of Seq_Det_behavioral_TB is
component Seq_Det_behavioral is
	port (Clock, Reset : in std_logic;
		DIN		 : in std_logic;
		FOUND		 : out std_logic);
end component;

	signal Clock_TB : std_logic;
	signal Reset_TB: std_logic;
	signal DIN_TB : std_logic;
	signal FOUND_TB : std_logic;
begin
	DUT1: Seq_Det_behavioral port map (Clock => Clock_TB, Reset => Reset_TB, DIN => DIN_TB, FOUND=>FOUND_TB);

	STIMULUS : process

	begin	
		Reset_TB<='0';
		Clock_TB <= '0'; wait for 100 ps;
		Clock_TB <= '1'; wait for 100 ps;	

		Reset_TB<='1';
		DIN_TB<='0';

		Clock_TB <= '0'; wait for 100 ps;
		Clock_TB <= '1'; wait for 100 ps;	

		DIN_TB<='1';

		Clock_TB <= '0'; wait for 100 ps;
		Clock_TB <= '1'; wait for 100 ps;	


		DIN_TB<='0';

		Clock_TB <= '0'; wait for 100 ps;
		Clock_TB <= '1'; wait for 100 ps;	


		DIN_TB<='1';

		Clock_TB <= '0'; wait for 100 ps;
		Clock_TB <= '1'; wait for 100 ps;	
		
	
	
	end process;

end architecture;
