library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux8to1 is
    Port (
        A   : in  bit_vector(7 downto 0);
        Sel : in  bit_vector(2 downto 0);
        F   : out bit
    );
end mux8to1;

architecture mux8to1_arch of mux8to1 is
begin

    -- Selection signal assignment
    with Sel select
        F <= A(0) when "000",
             A(1) when "001",
             A(2) when "010",
             A(3) when "011",
             A(4) when "100",
             A(5) when "101",
             A(6) when "110",
             A(7) when "111",
             '0'  when others;

end architecture;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_mux8to1 is
end tb_mux8to1;

architecture tb_mux8to1_arch of tb_mux8to1 is

    signal A_TB   : bit_vector(7 downto 0);
    signal Sel_TB : bit_vector(2 downto 0);
    signal F_TB   : bit;

begin

    -- Instantiate the Unit Under Test (UUT)
    UUT: entity work.mux8to1
        port map (
            A   => A_TB,
            Sel => Sel_TB,
            F   => F_TB
        );

    -- Test process
    process
    begin
        -- Test vector 1
        A_TB   <= "10101010";
        Sel_TB <= "000";  -- F = A0
        wait for 10 ns;

        Sel_TB <= "001";  -- F = A1
        wait for 10 ns;

        -- End simulation
        wait;
    end process;

end architecture;

