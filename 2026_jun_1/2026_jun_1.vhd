-- ============================================================
-- LOGICKO PROJEKTOVANJE - JUNSKI 2026.
--
-- ZADATAK 1
--
-- Realizovati:
-- 1. Multiplekser 2-na-1 koriscenjem konkurentne dodele
--    signala i logickih operatora.
--
-- 2. Multiplekser 4-na-1 komponentnim projektovanjem,
--    koriscenjem tri instance multipleksera 2-na-1.
--
-- 3. Samoproveravajuci test bench koji:
--    - ucitava test vektore iz fajla "ulaz.txt"
--    - koristi ulazni vektor kao ulaz DUT-a
--    - odredjuje ocekivani rezultat
--    - proverava rezultat pomocu assert/report
--    - upisuje rezultat u "output.txt"
--
-- Format ulaznog vektora:
--
-- i0 i1 i2 i3 s0 s1
--
-- odnosno:
--
-- X(5) = i0
-- X(4) = i1
-- X(3) = i2
-- X(2) = i3
-- X(1) = s0
-- X(0) = s1
--
-- ============================================================



-- ============================================================
-- 1. MULTIPLEKSER 2-NA-1
--
-- s = 0 -> F = i0
-- s = 1 -> F = i1
--
-- Koristi se konkurentna dodela signala i logicki operatori.
--
-- Funkcija:
--
-- F = (not s and i0) or (s and i1)
--
-- ============================================================

entity MUX2 is
port (
    i0, i1 : in bit;
    s      : in bit;
    F      : out bit
);
end entity;


architecture MUX2_arch of MUX2 is
begin

    -- Konkurentna dodela signala
    F <= ((not s) and i0) or (s and i1);

end architecture;



-- ============================================================
-- 2. MULTIPLEKSER 4-NA-1
--
-- Komponentna realizacija pomocu tri MUX2 komponente.
--
--
--        i0 -------\
--                   MUX2 ---- F1 ----\
--        i1 -------/   s1              \
--                                      MUX2 ---- F
--        i2 -------\                   /
--                   MUX2 ---- F2 ----/
--        i3 -------/   s1          s0
--
--
-- Za selektorske ulaze:
--
-- s0 s1
--
-- 0  0   -> i0
-- 0  1   -> i1
-- 1  0   -> i2
-- 1  1   -> i3
--
-- Ulazi sistema predstavljeni su jednim vektorom:
--
-- X = i0 i1 i2 i3 s0 s1
--
-- ============================================================

entity MUX4 is
port (
    X : in bit_vector(5 downto 0);
    F : out bit
);
end entity;


architecture MUX4_arch of MUX4 is

    -- Izlazi prva dva multipleksera
    signal F1, F2 : bit;


    -- Deklaracija komponente MUX2

    component MUX2 is
        port (
            i0, i1 : in bit;
            s      : in bit;
            F      : out bit
        );
    end component;


begin

    -- --------------------------------------------------------
    -- Prvi MUX2
    --
    -- Bira izmedju i0 i i1 pomocu selektora s1
    --
    -- X(5) = i0
    -- X(4) = i1
    -- X(0) = s1
    -- --------------------------------------------------------

    U1 : MUX2
        port map (
            i0 => X(5),
            i1 => X(4),
            s  => X(0),
            F  => F1
        );


    -- --------------------------------------------------------
    -- Drugi MUX2
    --
    -- Bira izmedju i2 i i3 pomocu selektora s1
    --
    -- X(3) = i2
    -- X(2) = i3
    -- X(0) = s1
    -- --------------------------------------------------------

    U2 : MUX2
        port map (
            i0 => X(3),
            i1 => X(2),
            s  => X(0),
            F  => F2
        );


    -- --------------------------------------------------------
    -- Treci MUX2
    --
    -- Bira izmedju izlaza F1 i F2 pomocu s0.
    --
    -- s0 = 0 -> F = F1
    -- s0 = 1 -> F = F2
    --
    -- X(1) = s0
    -- --------------------------------------------------------

    U3 : MUX2
        port map (
            i0 => F1,
            i1 => F2,
            s  => X(1),
            F  => F
        );


end architecture;



-- ============================================================
-- 3. TEST BENCH
--
-- Test bench:
--
-- 1. Otvara fajl ulaz.txt
-- 2. Cita po jedan vektor iz svakog reda
-- 3. Prosledjuje vektor DUT-u
-- 4. Izracunava ocekivanu vrednost
-- 5. Koristi assert/report za proveru
-- 6. Upisuje rezultat u output.txt
--
-- ============================================================

library std;
use std.textio.all;


entity MUX4_TB is
end entity;


architecture MUX4_TB_arch of MUX4_TB is


    -- ========================================================
    -- Deklaracija DUT komponente
    -- ========================================================

    component MUX4 is
        port (
            X : in bit_vector(5 downto 0);
            F : out bit
        );
    end component;


    -- Ulazni vektor test bench-a

    signal X_TB : bit_vector(5 downto 0);


    -- Izlaz DUT-a

    signal F_TB : bit;


begin


    -- ========================================================
    -- DUT - Device Under Test
    -- ========================================================

    DUT1 : MUX4
        port map (
            X => X_TB,
            F => F_TB
        );



    -- ========================================================
    -- Proces za ucitavanje i proveru test vektora
    -- ========================================================

    STIMULUS : process


        -- ----------------------------------------------------
        -- Ulazni fajl
        -- ----------------------------------------------------

        file input_file : text open read_mode is "ulaz.txt";


        -- ----------------------------------------------------
        -- Izlazni fajl
        -- ----------------------------------------------------

        file output_file : text open write_mode is "output.txt";


        -- Red koji se cita iz ulaznog fajla

        variable input_line : line;


        -- Red koji se upisuje u izlazni fajl

        variable output_line : line;


        -- Vektor procitan iz fajla

        variable X_VAR : bit_vector(5 downto 0);


        -- Ocekivani izlaz

        variable EXPECTED_F : bit;


        -- Brojac testova

        variable TEST_NO : integer := 0;


    begin


        -- ====================================================
        -- Citanje fajla red po red
        -- ====================================================

        while not endfile(input_file) loop


            -- ------------------------------------------------
            -- Procitaj jedan red
            -- ------------------------------------------------

            readline(input_file, input_line);


            -- ------------------------------------------------
            -- Procitaj vektor oblika:
            --
            -- i0 i1 i2 i3 s0 s1
            --
            -- Na primer:
            --
            -- 101000
            -- ------------------------------------------------

            read(input_line, X_VAR);


            -- Povecanje broja testa

            TEST_NO := TEST_NO + 1;


            -- ------------------------------------------------
            -- Prosledjivanje kompletnog ulaznog vektora DUT-u
            -- ------------------------------------------------

            X_TB <= X_VAR;


            -- Cekanje da se propagiraju vrednosti kroz
            -- tri nivoa komponenti

            wait for 100 ps;



            -- =================================================
            -- Izracunavanje ocekivanog rezultata
            --
            -- X(1) = s0
            -- X(0) = s1
            --
            -- s0s1 = 00 -> i0 = X(5)
            -- s0s1 = 01 -> i1 = X(4)
            -- s0s1 = 10 -> i2 = X(3)
            -- s0s1 = 11 -> i3 = X(2)
            -- =================================================

            if X_VAR(1) = '0' and X_VAR(0) = '0' then

                EXPECTED_F := X_VAR(5);


            elsif X_VAR(1) = '0' and X_VAR(0) = '1' then

                EXPECTED_F := X_VAR(4);


            elsif X_VAR(1) = '1' and X_VAR(0) = '0' then

                EXPECTED_F := X_VAR(3);


            else

                EXPECTED_F := X_VAR(2);

            end if;



            -- =================================================
            -- Samoprovera rezultata
            --
            -- Ako rezultat nije jednak ocekivanom,
            -- assert generise poruku o gresci.
            -- =================================================

            assert F_TB = EXPECTED_F

                report "GRESKA: Neispravan izlaz multipleksera!"

                severity error;



            -- =================================================
            -- REPORT ZA USPESNO IZVRSEN TEST
            -- =================================================

            if F_TB = EXPECTED_F then

                report "Test " &
                       integer'image(TEST_NO) &
                       " je uspesno izvrsen."

                severity note;

            end if;



            -- =================================================
            -- Upis rezultata u output.txt
            --
            -- Format:
            --
            -- ulazni_vektor izlaz
            --
            -- Na primer:
            --
            -- 101000 1
            -- =================================================

            write(output_line, X_VAR);

            write(output_line, string'(" "));

            write(output_line, F_TB);

            writeline(output_file, output_line);


        end loop;



        -- ====================================================
        -- Zavrsna poruka
        -- ====================================================

        report "Testiranje je zavrseno."

        severity note;


        wait;


    end process;


end architecture;
