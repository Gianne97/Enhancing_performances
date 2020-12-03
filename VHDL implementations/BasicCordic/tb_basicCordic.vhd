library IEEE;
use IEEE.std_logic_1164.all;
--use IEEE.std_artih.all;
use IEEE.fixed_float_types.all;
use IEEE.fixed_pkg.all;

entity testbench is
end testbench; 

architecture tb of testbench is

component basic_cordic is
GENERIC (
    NMB_ITERATIONS  :   integer := 10;
    PRECISION_FP    :   integer := 9
);

port (
    angle_i : in sfixed (7 downto -2); -- the input angle in radiant
    start_i : in std_logic; -- if transitioned from 0 -> 1 the algorithm starts, needs to be 1 until ready is asserted
    clock_i : in std_logic; -- the input clock
    sin_o : out sfixed (1 downto -PRECISION_FP);
    cos_o : out sfixed (1 downto -PRECISION_FP);
    rdy_o : out std_logic); -- is set to 1 if the results are ready
end component;


component clkGen is
  port (clk : out std_logic);
end component;

signal sig_clk, sig_start, sig_rdy: std_logic;
signal sin_out, cos_out : sfixed (1 downto -15);
signal sig_in : sfixed (7 downto -2);

begin

    -- connect DUT with tb signals
    DUT:
        basic_cordic 
        generic map(NMB_ITERATIONS => 15, PRECISION_FP => 15)
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

   -- applay a angle of -55° as input
   sig_in <= to_sfixed(-85, 7, -2);
   sig_start <= '1' after 100 ns;

   assert false report "end of simulation reached";

end;
