library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity testbench is
end testbench; 

architecture tb of testbench is

component para_S is
  generic (
    PRECISION_FP    :   integer := 9;
    PARAMETER_RI : integer := 3
    );      
  port(
    clk : in std_logic;
    sigma : in std_logic;
    x_i : in unsigned(PRECISION_FP-1 downto 0);
    y_i : in unsigned(PRECISION_FP-1 downto 0);
    x_o : out unsigned(PRECISION_FP-1 downto 0);
    y_o : out unsigned(PRECISION_FP-1 downto 0)
);
end component;

component clkGen is
  port (clk : out std_logic);
end component;

signal sig_clk, sig_sigma: std_logic;
signal sig_xi, sig_xo, sig_yi, sig_yo: unsigned (8 downto 0);

begin
   -- clockgenerator
   mClkGen : clkGen port map(
  	clk => sig_clk
   );

   -- conncet DUT with tb signals
   DUT:
       para_S
       generic map(PRECISION_FP => 9, PARAMETER_RI => 3)
       port map(
       clk => sig_clk,
       sigma => sig_sigma,
       x_i => sig_xi,
       x_o => sig_xo,
       y_i => sig_yi,
       y_o => sig_yo);


   -- apply test signals
   sig_xi <= "101010100";
   sig_yi <= "111111111";
   sig_sigma <= '0', '1' after 40 ps;

   assert false report "end of simulation reached";

end;


