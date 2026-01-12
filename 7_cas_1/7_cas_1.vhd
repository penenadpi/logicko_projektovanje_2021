library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

------------------------------------------------------------------
-- DEVICE UNDER TEST (PAL)
------------------------------------------------------------------
entity pal_full is
    port (
        A, B, C : in  std_logic;
        F1, F2  : out std_logic
    );
end entity;

architecture rtl of pal_full is
    --------------------------------------------------------------------
    -- Parametri (3 ulaza, 4 produkta, 2 izlaza)
    --------------------------------------------------------------------
    constant N : integer := 3;
    constant M : integer := 4;
    constant K : integer := 2;

    signal X    : std_logic_vector(N-1 downto 0);
    signal invX : std_logic_vector(N-1 downto 0);
    signal P    : std_logic_vector(M-1 downto 0);

    --------------------------------------------------------------------
    -- AND matrica: programabilni produkti
    -- 2-bitni kod: "10"=negirani ulaz, "01"=ulaz, "00"=nije ukljucen
    --------------------------------------------------------------------
    type and_type is array (0 to M-1, 0 to N-1) of std_logic_vector(1 downto 0);
    constant and_sel : and_type :=
    (
        ( "10", "01", "00" ), -- p0 = A'·B
        ( "01", "10", "00" ), -- p1 = A·B'
        ( "01", "01", "10" ), -- p2 = A·B·C'
        ( "00", "00", "00" )  -- p3 = ne koristi ulaze
    );

    --------------------------------------------------------------------
    -- OR matrica: koji produkt ide na koji izlaz
    --------------------------------------------------------------------
    type or_type is array (0 to K-1) of std_logic_vector(M-1 downto 0);
    constant or_sel : or_type :=
    (
        "1100", -- F1 = p0 OR p1
        "0010"  -- F2 = p2
    );

begin
    -------------------------------------------------------------
    -- formiramo vektore ulaza i negacija
    -------------------------------------------------------------
    X    <= A & B & C;
    invX <= not X;

    -------------------------------------------------------------
    -- AND ravnina
    -------------------------------------------------------------
    gen_and : for p in 0 to M-1 generate
        process (X, invX)
            variable prod : std_logic := '1';
        begin
            for i in 0 to N-1 loop
                if and_sel(p, i)(0) = '1' then
                    prod := prod and invX(i);
                elsif and_sel(p, i)(1) = '1' then
                    prod := prod and X(i);
                end if;
            end loop;
            P(p) <= prod;
        end process;
    end generate;

    -------------------------------------------------------------
    -- OR ravnina
    -------------------------------------------------------------
    gen_or : for k in 0 to K-1 generate
        process (P)
            variable outv : std_logic := '0';
        begin
            for p in 0 to M-1 loop
                if or_sel(k)(p) = '1' then
                    outv := outv or P(p);
                end if;
            end loop;
            if k = 0 then
                F1 <= outv;
            else
                F2 <= outv;
            end if;
        end process;
    end generate;

end architecture;

------------------------------------------------------------------
-- TESTBENCH (nema portova!)
------------------------------------------------------------------
entity pal_full_tb is
end entity;

architecture tb of pal_full_tb is
    signal A, B, C : std_logic := '0';
    signal F1, F2  : std_logic;
begin
    -- Instanca DUT
    uut: entity work.pal_full
        port map(
            A => A,
            B => B,
            C => C,
            F1 => F1,
            F2 => F2
        );

    -- Stimulacija: sve kombinacije ABC
    stim: process
        variable v : std_logic_vector(2 downto 0);
    begin
        for i in 0 to 7 loop
            v := std_logic_vector(to_unsigned(i, 3));
            A <= v(2);
            B <= v(1);
            C <= v(0);
            wait for 10 ns;
        end loop;
        wait; -- stop simulacije
    end process;
end architecture;

