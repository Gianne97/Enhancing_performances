library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity pcordic is
    generic(
      PRECISION_FP    :   integer := 16
    );
    port(
      clk : in std_logic;
      theta : in signed(0 to PRECISION_FP-1);    
      x_o : out signed(0 to PRECISION_FP-1);
      y_o : out signed(0 to PRECISION_FP-1)
    );
end entity pcordic;         

architecture beh of pcordic is

  signal sigma : std_logic_vector(0 to PRECISION_FP-1);
  signal x0 : signed(0 to PRECISION_FP-1);
  signal y0 : signed(0 to PRECISION_FP-1);
  
  component R_block is
    generic (
      PRECISION_FP    :   integer := 9
    );
    port(
      sigma : in std_logic_vector(0 to PRECISION_FP-1);      
      x_i : in signed(0 to PRECISION_FP-1);
      y_i : in signed(0 to PRECISION_FP-1);
      x_o : out signed(0 to PRECISION_FP-1);
      y_o : out signed(0 to PRECISION_FP-1)
    );
  end component R_block;


begin

  sigma(0)<=not theta(0);
  sigma(1 to PRECISION_FP-1)<=std_logic_vector(theta(1 to PRECISION_FP-1));

  x0(0)<='0';
  x0(1 to PRECISION_FP-1)<=(others => '1');
  y0<=(others => '0');
  
  rr: R_block
    generic map(
      PRECISION_FP => PRECISION_FP
      )
    port map(
      sigma => sigma,                    
      x_i => x0,
      y_i => y0,
      x_o => x_o,
      y_o => y_o
      );    

      
      


end architecture beh;
