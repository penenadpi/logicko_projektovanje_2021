library IEEE;
use IEEE.std_logic_1164.all;

entity demux1to8 is
    port (
        A   : in  std_logic;
        Sel : in  std_logic_vector(2 downto 0);
        F   : out std_logic_vector(7 downto 0)
    );
end demux1to8;

architecture demux1to8_arch of demux1to8 is
begin
    F(0) <= A and (not Sel(2)) and (not Sel(1)) and (not Sel(0));
    F(1) <= A and (not Sel(2)) and (not Sel(1)) and      Sel(0);
    F(2) <= A and (not Sel(2)) and      Sel(1)  and (not Sel(0));
    F(3) <= A and (not Sel(2)) and      Sel(1)  and      Sel(0);
    F(4) <= A and      Sel(2)  and (not Sel(1)) and (not Sel(0));
    F(5) <= A and      Sel(2)  and (not Sel(1)) and      Sel(0);
    F(6) <= A and      Sel(2)  and      Sel(1)  and (not Sel(0));
    F(7) <= A and      Sel(2)  and      Sel(1)  and      Sel(0);
end architecture;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;

entity tb_demux1to8 is
end tb_demux1to8;

architecture tb_demux1to8_arch of tb_demux1to8 is

    signal A_TB   : std_logic;
    signal Sel_TB : std_logic_vector(2 downto 0);
    signal F_TB   : std_logic_vector(7 downto 0);

    file ulaz  : text open read_mode  is "ulaz.txt";
    file izlaz : text open write_mode is "izlaz.txt";

begin

    -- DUT
    DUT: entity work.demux1to8
        port map (
            A   => A_TB,
            Sel => Sel_TB,
            F   => F_TB
        );

    stim_proc: process
        variable L     : line;
        variable Lout  : line;
        variable Ain   : std_logic;
        variable Selin : std_logic_vector(2 downto 0);
        variable ExpF  : std_logic_vector(7 downto 0);
    begin

        while not endfile(ulaz) loop
            readline(ulaz, L);
            read(L, Ain);
            read(L, Selin);

            A_TB   <= Ain;
            Sel_TB <= Selin;
            wait for 10 ns;

            -- o?ekivani izlaz
            ExpF := (others => '0');
            if Ain = '1' then
                ExpF(to_integer(unsigned(Selin))) := '1';
            end if;

            -- upis rezultata
            write(Lout, string'("A="));
            write(Lout, Ain);
            write(Lout, string'(" Sel="));
            write(Lout, Selin);
            write(Lout, string'(" F="));
            write(Lout, F_TB);
            write(Lout, string'(" EXPECTED="));
            write(Lout, ExpF);

            if F_TB = ExpF then
                write(Lout, string'(" OK"));
            else
                write(Lout, string'(" ERROR"));
            end if;

            writeline(izlaz, Lout);
        end loop;

        wait;
    end process;

end architecture;
