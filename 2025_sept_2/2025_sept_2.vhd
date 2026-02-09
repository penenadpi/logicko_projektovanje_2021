library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mem_8x2 is
    Port (
        clk   : in  std_logic;
        we    : in  std_logic;
        addr  : in  std_logic_vector(2 downto 0);
        din   : in  std_logic_vector(1 downto 0);
        dout  : out std_logic_vector(1 downto 0)
    );
end mem_8x2;
	
architecture behavioral of mem_8x2 is
    type mem_type is array (0 to 7) of std_logic_vector(1 downto 0);
    signal mem : mem_type := (others => "00");
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if we = '1' then
                mem(to_integer(unsigned(addr))) <= din;
            else
                dout <= mem(to_integer(unsigned(addr)));
            end if;
        end if;
    end process;
end architecture;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_mem_8x2 is
end tb_mem_8x2;

architecture sim of tb_mem_8x2 is
    signal clk_tb  : std_logic := '0';
    signal we_tb   : std_logic := '0';
    signal addr_tb : std_logic_vector(2 downto 0) := "000";
    signal din_tb  : std_logic_vector(1 downto 0) := "00";
    signal dout_tb : std_logic_vector(1 downto 0);

    constant clk_period : time := 3 ns;
begin
    -- DUT
    uut: entity work.mem_8x2
        port map (
            clk  => clk_tb,
            we   => we_tb,
            addr => addr_tb,
            din  => din_tb,
            dout => dout_tb
        );

    -- Clock generator
    clk_process : process
    begin
        while true loop
            clk_tb <= '0';
            wait for clk_period/2;
            clk_tb <= '1';
            wait for clk_period/2;
        end loop;
    end process;

    -- Stimulus
    stim_proc : process
    begin
        -- WRITE "01" to all addresses
        we_tb  <= '1';
        din_tb <= "01";

        for i in 0 to 7 loop
            addr_tb <= std_logic_vector(to_unsigned(i, 3));
            wait for clk_period;
        end loop;

        -- READ from all addresses
        we_tb <= '0';

        for i in 0 to 7 loop
            addr_tb <= std_logic_vector(to_unsigned(i, 3));
            wait for clk_period;
            assert dout_tb = "01"
                report "ERROR at address " & integer'image(i)
                severity error;
        end loop;

        report "Simulation finished successfully!" severity note;
        wait;
    end process;
end architecture;

