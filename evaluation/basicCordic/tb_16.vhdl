library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.numeric_std.all;
    use IEEE.fixed_float_types.all;
    use IEEE.fixed_pkg.all;
    use STD.textio.all;
    use ieee.std_logic_textio.all;
    
entity testbench is
    end testbench;
    
    architecture tb of testbench is
    
    component basic_cordic is
    GENERIC (
        NMB_ITERATIONS  :   integer := 40;
        PRECISION_FP    :   integer := 15
    );
    
port (
        angle_i : in sfixed (1 downto - PRECISION_FP);
        start_i : in std_logic;
        clock_i : in std_logic;
        sin_o : out sfixed (1 downto - PRECISION_FP);
        cos_o : out sfixed (1 downto - PRECISION_FP);
        rdy_o : out std_logic);
    end component;
    
component clkGen is
    port (clk : out std_logic);
    end component;
    
signal sig_clk, sig_start, sig_rdy: std_logic;
    signal sin_out, cos_out : sfixed (1 downto -15);
    signal sig_in : sfixed (1 downto -15);
    

begin
       
    -- connect DUT with tb signals
    DUT:
        basic_cordic
        generic map(NMB_ITERATIONS => 40, PRECISION_FP => 15)
        port map(
        angle_i => sig_in,
        start_i => sig_start,
        clock_i => sig_clk,
        rdy_o => sig_rdy,
        sin_o => sin_out,
        cos_o => cos_out);
            
    -- clockgenerator
    mClkGen : clkGen port map(
        clk => sig_clk
    );
        
    -- apply a test angle as input
    stimuli: process
    begin
        sig_in <= to_sfixed(-0.785398, 1, - 15);
        sig_start <= '1';
        wait until sig_rdy = '1';
        sig_start <= '0';
        wait for 30 ns;
        sig_in <= to_sfixed(-0.523599, 1, - 15);
        sig_start <= '1';
        wait until sig_rdy = '1';
        sig_start <= '0';
        wait for 30 ns;
        sig_in <= to_sfixed(-0.392699, 1, - 15);
        sig_start <= '1';
        wait until sig_rdy = '1';
        sig_start <= '0';
        wait for 30 ns;
        sig_in <= to_sfixed(0.01, 1, - 15);
        sig_start <= '1';
        wait until sig_rdy = '1';
        sig_start <= '0';
        wait for 30 ns;
        sig_in <= to_sfixed(0.392699, 1, - 15);
        sig_start <= '1';
        wait until sig_rdy = '1';
        sig_start <= '0';
        wait for 30 ns;
        sig_in <= to_sfixed(0.523599, 1, - 15);
        sig_start <= '1';
        wait until sig_rdy = '1';
        sig_start <= '0';
        wait for 30 ns;
        sig_in <= to_sfixed(0.392699, 1, - 15);
        sig_start <= '1';
        wait until sig_rdy = '1';
        
    end process stimuli;
        
end;

