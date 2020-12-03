library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity para_S is
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
end entity para_S;

architecture behavior of para_S is
begin
    algorithm : process(clk)
    begin
        if rising_edge(clk) then
            if sigma = '0' then -- negative rotation
                x_o <= x_i + (shift_right(y_i, PARAMETER_RI)); -- sign +
                y_o <= y_i - (shift_right(x_i, PARAMETER_RI)); -- sign -
            else -- positive rotation
                x_o <= x_i - (shift_right(y_i, PARAMETER_RI)); -- sign -
                y_o <= y_i + (shift_right(x_i, PARAMETER_RI)); -- sign +
            end if;
        end if;
    end process algorithm;
end behavior;
