library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.fixed_float_types.all;
use IEEE.fixed_pkg.all;

entity testbench is
end testbench; 

architecture tb of testbench is

component basic_cordic is -- instance of the cordic unit
GENERIC (
    NMB_ITERATIONS  :   integer := 15; -- change this value
    PRECISION_FP    :   integer := 63  -- change this value
);

port (
    angle_i : in sfixed (1 downto - PRECISION_FP); -- the input angle in radians
    start_i : in std_logic; -- if transitioned from 0 -> 1 the algorithm starts, needs to be 1 until ready is asserted
    clock_i : in std_logic; -- the input clock
    sin_o : out sfixed (1 downto -PRECISION_FP);
    cos_o : out sfixed (1 downto -PRECISION_FP);
    rdy_o : out std_logic); -- is set to 1 if the results are ready
end component;


component clkGen is -- instance of the clock
  port (clk : out std_logic);
end component;

signal sig_clk, sig_start, sig_rdy: std_logic;
signal sin_out, cos_out : sfixed (1 downto -63); -- change these values
signal sig_in : sfixed (1 downto -63); -- change these values

begin

    -- connect DUT with tb signals
    DUT:
        basic_cordic 
        generic map(NMB_ITERATIONS => 15, PRECISION_FP => 63) -- change these values
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

   -- applay a angle of -55 degrees as input
   sig_in <= to_sfixed(0.15123, 1, - 63); -- input angle in radians
   sig_start <= '1' after 100 ns;

   assert false report "end of simulation reached";

end;
