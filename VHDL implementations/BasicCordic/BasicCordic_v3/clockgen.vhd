-- Clock Generator
library IEEE;
use IEEE.std_logic_1164.all;


entity clkGen is
  port (clk : out std_logic);
end clkGen;

architecture behavior of clkGen is

constant clk_period : time := 10 ns;

begin
  clkgen : process
  
  begin
  
  	clk <= '0';
    wait for clk_period/2;  
    clk <= '1';
    wait for clk_period/2;  
  end process clkgen;
end behavior;
