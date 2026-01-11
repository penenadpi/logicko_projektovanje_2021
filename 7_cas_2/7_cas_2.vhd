
Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity mux2 is
    port (
        sel : in  std_logic;
        x0  : in  std_logic;
        x1  : in  std_logic;
        y   : out std_logic
    );
end entity;

architecture rtl of mux2 is
begin
    y <= x0 when sel = '0' else x1;
end architecture;

Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity lut4_mux is
    port (
        A,B,C,D: in std_logic;
        F          : out std_logic
    );
end entity;

architecture rtl of lut4_mux is

    -- LUT inicijalizacija
    constant LUT : std_logic_vector(15 downto 0) :=
        "0000101000001010";

    -- MUX
    component mux2 is
        port (
            sel : in  std_logic;
            x0  : in  std_logic;
            x1  : in  std_logic;
            y   : out std_logic
        );
    end component;

    signal m0 : std_logic_vector(7 downto 0);
    signal m1 : std_logic_vector(3 downto 0);
    signal m2 : std_logic_vector(1 downto 0);

begin
    -----------------------------------------------------------------------------
    -- 1. D (16 -> 8)
    -----------------------------------------------------------------------------
    gen_mux0 : for i in 0 to 7 generate
        mux_inst : mux2
            port map (
                sel => D,
                x0  => LUT(2*i),
                x1  => LUT(2*i + 1),
                y   => m0(i)
            );
    end generate;

    -----------------------------------------------------------------------------
    -- 2. C (8->4)
    -----------------------------------------------------------------------------
    gen_mux1 : for i in 0 to 3 generate
        mux_inst : mux2
            port map (
                sel => C,
                x0  => m0(2*i),
                x1  => m0(2*i + 1),
                y   => m1(i)
            );
    end generate;

    -----------------------------------------------------------------------------
    -- 3. B (4->2)
    -----------------------------------------------------------------------------
    gen_mux2 : for i in 0 to 1 generate
        mux_inst : mux2
            port map (
                sel => B,
                x0  => m1(2*i),
                x1  => m1(2*i + 1),
                y   => m2(i)
            );
    end generate;

    -----------------------------------------------------------------------------
    -- 4 A (2 -> 1)
    -----------------------------------------------------------------------------
    mux_last : mux2
        port map (
            sel => A,
            x0  => m2(0),
            x1  => m2(1),
            y   => F
        );

end architecture;

Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity lut4_mux_tb is
end entity;

architecture tb of lut4_mux_tb is

    -- UUT port signals
    signal A, B, C, D : std_logic := '0';
    signal F          : std_logic;

begin
    -- Instantiate Device Under Test (DUT)
    uut : entity work.lut4_mux
        port map (
            A => A,
            B => B,
            C => C,
            D => D,
            F => F
        );

    -- Stimulus process: iterate through all 16 inputs
    stimulus : process
        variable v : std_logic_vector(3 downto 0);
    begin
        for i in 0 to 15 loop
            v := std_logic_vector(to_unsigned(i, 4));
            A <= v(3);
            B <= v(2);
            C <= v(1);
            D <= v(0);

            wait for 10 ns;
        end loop;

        wait; -- stop simulation
    end process;

end architecture;