library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity fpax is
    generic(
      B    :   integer := 16;
      L    :   integer := 4
    );
    port(
      clk : in std_logic;
      theta : in signed(0 to B-1);      
      x_o : out signed(0 to B-1);
      y_o : out signed(0 to B-1)
    );
end entity fpax;         

architecture beh of fpax is

  signal sigma_L : std_logic_vector(0 to L-1);

  
  signal x0 : signed(0 to B-1);
  signal y0 : signed(0 to B-1);
  
  component R_block is
    generic (
        B    :   integer := 16;
        L : integer := 4
    );
    port(
      sigma : in std_logic_vector(0 to L-1);      
      x_i : in signed(0 to B-1);
      y_i : in signed(0 to B-1);
      x_o : out signed(0 to B-1);
      y_o : out signed(0 to B-1)
    );
  end component R_block;

begin

  sigma_L(0)<=not theta(0);
  sigma_L(1 to L-1)<=std_logic_vector(theta(1 to L-1));

  
  x0<="0110110111011010";
  y0<=(others => '0');
  
  rr: R_block
    generic map(
      B => B,L=>L
      )
    port map(
      sigma => sigma_L,                    
      x_i => x0,
      y_i => y0,      
      x_o => x_L,
      y_o => y_L
    );
      
end architecture beh;

