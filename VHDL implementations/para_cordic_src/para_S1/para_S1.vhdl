library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity para_S1 is
  generic (
    PRECISION_FP    :   integer := 9;
    NMB_OF_BITS_FOR_I : integer := 3
    );      
  port(
    clk : in std_logic;
    sigma : in std_logic;
    i : in unsigned(NMB_OF_BITS_FOR_I-1 downto 0);
    x_i : in unsigned(PRECISION_FP-1 downto 0);
    y_i : in unsigned(PRECISION_FP-1 downto 0);
    x_o : out unsigned(PRECISION_FP-1 downto 0);
    y_o : out unsigned(PRECISION_FP-1 downto 0)
);
end entity para_S1;

architecture behavior of para_S1 is
begin
    algorithm : process(clk)
    begin
        if rising_edge(clk) then
            if sigma = '0' then -- negative direction
                x_o <= x_i + (shift_right(y_i, to_integer(i))); -- sign +
                y_o <= y_i - (shift_right(x_i, to_integer(i))); -- sign -
            else -- positive direction
                x_o <= x_i - (shift_right(y_i, to_integer(i))); -- sign -
                y_o <= y_i + (shift_right(x_i, to_integer(i))); -- sign +
            end if;
        end if;
    end process algorithm;
end behavior;
