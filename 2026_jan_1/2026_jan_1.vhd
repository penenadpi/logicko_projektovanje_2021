-- ============================================================
-- ZADATAK 1
--
-- Osnovni sistem:
-- F = SUM(1,3,6)
--
-- Zatim se dve instance sistema SystemE povezuju
-- komponentnim projektovanjem.
--
-- Ulazi konacnog sistema:
-- X(5) = A1
-- X(4) = B1
-- X(3) = C1
-- X(2) = A2
-- X(1) = B2
-- X(0) = C2
--
-- Izlaz:
-- F = F1 XOR F2
--
-- Test bench koristi 5 proizvoljnih test vektora
-- i rezultate izlaza F upisuje u output.txt.
-- ============================================================


-- ============================================================
-- 1. OSNOVNI SISTEM SystemE
--
-- F = SUM(A,B,C)(1,3,6)
--
-- m1 = 001
-- m3 = 011
-- m6 = 110
-- ============================================================

entity SystemE is
port (
    A, B, C : in bit;
    F       : out bit
);
end entity;


architecture SystemE_arch of SystemE is
begin

    -- Uslovna dodela signala.
    -- F je 1 samo za minterme 1, 3 i 6.

    F <= '1' when (A='0' and B='0' and C='1') else
         '1' when (A='0' and B='1' and C='1') else
         '1' when (A='1' and B='1' and C='0') else
         '0';

end architecture;



-- ============================================================
-- 2. XOR KOMPONENTA
--
-- Koristi se za povezivanje izlaza F1 i F2
-- dve instance sistema SystemE.
-- ============================================================

entity XOR2 is
port (
    A, B : in bit;
    F    : out bit
);
end entity;


architecture XOR2_arch of XOR2 is
begin

    F <= A xor B;

end architecture;



-- ============================================================
-- 3. KOMPONENTNO PROJEKTOVAN SISTEM
--
-- Sistem ima sest ulaza predstavljenih jednim vektorom:
--
-- X = A1 B1 C1 A2 B2 C2
--
-- Prva instanca:
-- SystemE(A1,B1,C1) -> F1
--
-- Druga instanca:
-- SystemE(A2,B2,C2) -> F2
--
-- Konacni izlaz:
-- F = F1 XOR F2
-- ============================================================

entity ComponentsSystem6 is
port (
    X : in bit_vector(5 downto 0);
    F : out bit
);
end entity;


architecture ComponentsSystem6_arch of ComponentsSystem6 is

    -- Interni signali za izlaze dva SystemE sistema
    signal F1, F2 : bit;


    -- Deklaracija komponente SystemE

    component SystemE is
        port (
            A, B, C : in bit;
            F       : out bit
        );
    end component;


    -- Deklaracija XOR komponente

    component XOR2 is
        port (
            A, B : in bit;
            F    : out bit
        );
    end component;


begin

    -- --------------------------------------------------------
    -- Prva instanca SystemE
    --
    -- X(5) = A1
    -- X(4) = B1
    -- X(3) = C1
    -- --------------------------------------------------------

    U1 : SystemE
        port map (
            A => X(5),
            B => X(4),
            C => X(3),
            F => F1
        );


    -- --------------------------------------------------------
    -- Druga instanca SystemE
    --
    -- X(2) = A2
    -- X(1) = B2
    -- X(0) = C2
    -- --------------------------------------------------------

    U2 : SystemE
        port map (
            A => X(2),
            B => X(1),
            C => X(0),
            F => F2
        );


    -- --------------------------------------------------------
    -- Povezivanje izlaza F1 i F2 XOR kolom
    --
    -- F = F1 XOR F2
    -- --------------------------------------------------------

    U3 : XOR2
        port map (
            A => F1,
            B => F2,
            F => F
        );

end architecture;



-- ============================================================
-- 4. TEST BENCH
--
-- Testira se 5 proizvoljnih ulaznih vektora.
--
-- Vektor ima format:
--
-- A1 B1 C1 A2 B2 C2
--
-- Rezultat F za svaki test upisuje se u:
--
-- output.txt
-- ============================================================

library std;
use std.textio.all;


entity ComponentsSystem6_TB is
end entity;


architecture ComponentsSystem6_TB_arch of ComponentsSystem6_TB is


    -- Deklaracija komponente koja predstavlja DUT
    -- DUT = Device Under Test

    component ComponentsSystem6 is
        port (
            X : in bit_vector(5 downto 0);
            F : out bit
        );
    end component;


    -- Signali test bench-a

    signal X_TB : bit_vector(5 downto 0);
    signal F_TB : bit;


begin


    -- ========================================================
    -- Instanciranje sistema koji se testira
    -- ========================================================

    DUT1 : ComponentsSystem6
        port map (
            X => X_TB,
            F => F_TB
        );


    -- ========================================================
    -- Proces za generisanje test vektora
    -- ========================================================

    STIMULUS : process


        -- Eksterni fajl u koji se upisuju rezultati

        file output_file : text open write_mode is "output.txt";


        -- Promenljiva koja predstavlja jedan red fajla

        variable output_line : line;


    begin


        -- ====================================================
        -- TEST 1
        --
        -- A1B1C1 = 001 -> F1 = 1
        -- A2B2C2 = 000 -> F2 = 0
        --
        -- F = 1 XOR 0 = 1
        -- ====================================================

        X_TB <= "001000";

        wait for 100 ps;

        write(output_line, F_TB);
        writeline(output_file, output_line);



        -- ====================================================
        -- TEST 2
        --
        -- A1B1C1 = 001 -> F1 = 1
        -- A2B2C2 = 011 -> F2 = 1
        --
        -- F = 1 XOR 1 = 0
        -- ====================================================

        X_TB <= "001011";

        wait for 100 ps;

        write(output_line, F_TB);
        writeline(output_file, output_line);



        -- ====================================================
        -- TEST 3
        --
        -- A1B1C1 = 110 -> F1 = 1
        -- A2B2C2 = 001 -> F2 = 1
        --
        -- F = 1 XOR 1 = 0
        -- ====================================================

        X_TB <= "110001";

        wait for 100 ps;

        write(output_line, F_TB);
        writeline(output_file, output_line);



        -- ====================================================
        -- TEST 4
        --
        -- A1B1C1 = 111 -> F1 = 0
        -- A2B2C2 = 000 -> F2 = 0
        --
        -- F = 0 XOR 0 = 0
        -- ====================================================

        X_TB <= "111000";

        wait for 100 ps;

        write(output_line, F_TB);
        writeline(output_file, output_line);



        -- ====================================================
        -- TEST 5
        --
        -- A1B1C1 = 011 -> F1 = 1
        -- A2B2C2 = 110 -> F2 = 1
        --
        -- F = 1 XOR 1 = 0
        -- ====================================================

        X_TB <= "011110";

        wait for 100 ps;

        write(output_line, F_TB);
        writeline(output_file, output_line);



        -- Zavrsen test bench.
        -- wait bez vremenskog intervala trajno zaustavlja proces.

        wait;


    end process;


end architecture;
