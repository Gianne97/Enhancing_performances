library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity para_R is
  generic (
    PRECISION_FP    :   integer := 9;
    PARAMETER_SI : integer
    );
    port(
      clk : in std_logic;
      sigma : in std_logic;
      x_i : unsigned(0 downto PRECISION_FP-1);
      y_i : unsigned(0 downto PRECISION_FP-1);
      x_o : unsigned(0 downto PRECISION_FP-1);
      y_o : unsigned(0 downto PRECISION_FP-1)
);
end entity para_R;
