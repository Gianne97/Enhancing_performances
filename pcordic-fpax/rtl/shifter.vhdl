library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity shifter is
  generic(
    B    :   integer := 9;
    PARAMETER_RI : integer);
  port(
    x_i : in signed(0 to B-1);
    x_o : out signed(0 to B-1));
end entity shifter;


architecture beh of shifter is

begin
  x_o(0)<=x_i(0);
  x_o(1 to PARAMETER_RI)<=(others=>'0');
  x_o(PARAMETER_RI+1 to B-1)<=x_i(1 to B-1-PARAMETER_RI);

end architecture beh;
  

