library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity pcordic is
    generic(
      PRECISION_FP    :   integer := 9
    );
    port(
      clk : in std_logic;
      theta : out signed(0 downto PRECISION_FP-1);    
      x_o : out signed(0 downto PRECISION_FP-1);
      y_o : out signed(0 downto PRECISION_FP-1)
    );
end entity pcordic;         

architecture beh of pcordic is

  component R_block is
    generic (
      PRECISION_FP    :   integer := 9
    );
    port(
      x_i : in signed(0 downto PRECISION_FP-1);
      y_i : in signed(0 downto PRECISION_FP-1);
      x_o : out signed(0 downto PRECISION_FP-1);
      y_o : out signed(0 downto PRECISION_FP-1)
    );
  end component R_block;


    begin

      rr: R_block
        generic map(
          PRECISION_FP => 9
          )
        port map(
          x_i => (others => '1'),
          y_i => (others => '0'),
          x_o => x_o,
          y_o => y_o
        );    

      
      


end architecture beh;
