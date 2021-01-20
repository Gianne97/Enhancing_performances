library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.numeric_std.all;
    use IEEE.fixed_float_types.all;
    use IEEE.fixed_pkg.all;
    
entity testbench is
    end testbench;
    
    architecture tb of testbench is
    
    component basic_cordic is
    GENERIC (
        NMB_ITERATIONS  :   integer := 40;
        PRECISION_FP    :   integer := 62
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
    signal sin_out, cos_out : sfixed (1 downto -62);
    signal sig_in : sfixed (1 downto -62);
    

begin
       
    -- connect DUT with tb signals
    DUT:
        basic_cordic
        generic map(NMB_ITERATIONS => 40, PRECISION_FP => 62)
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
        
    -- apply the test angles 
    sig_in <= to_sfixed(0.15123, 1, - 62);
    sig_start <= '1' after 100 ns;
    
    print: process(sig_clk)
    begin
        if(sig_clk='1' and sig_clk'event) then
            if (sig_rdy='1') then
            for i in -62 to 1 loop
                end loop;
                for i in -1 to 62 loop
                report "x_o(" &  integer'image(-i) &")="& std_logic'image(cos_out(i));
                end loop;
                for i in -62 to 1 loop
                  report "y_o(" &  integer'image(i) &")="& std_logic'image(sin_out(i));
                end loop;

                assert false report "end of simulation reached";
            end if;
        end if;
    end process print;
    
        
    --assert false report "end of simulation reached";
end;
