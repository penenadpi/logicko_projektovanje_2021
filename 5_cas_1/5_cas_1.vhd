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

