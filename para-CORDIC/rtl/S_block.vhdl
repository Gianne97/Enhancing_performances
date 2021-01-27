library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity S_block is
  generic(
    B    :   integer := 16;
    L : integer := 4
    );
    port(
      sigma : in std_logic_vector(0 to B-L-1);
      x_i : in signed(0 to B-1);
      y_i : in signed(0 to B-1);
      x_o : out signed(0 to B-1);
      y_o : out signed(0 to B-1)
    );
end entity S_block;

architecture beh of S_block is

  component para_S is
    generic (
      B    :   integer;
      PARAMETER_RI : integer
      );      
    port(
      sigma : in std_logic;
      x_i : in signed(0 to B-1);
      y_i : in signed(0 to B-1);
      x_o : out signed(0 to B-1);
      y_o : out signed(0 to B-1)
      );
  end component para_S;

  type mem is array (0 to B-L) of signed(0 to B-1);
  signal x : mem;
  signal y : mem;

begin

  x(0)<=x_i;
  y(0)<=y_i;
  x_o<=x(B-L);
  y_o<=y(B-L);
  
  S_loop:
  for i in 0 to B-L-1 generate
    S: para_S
	generic map(
		B => B,
		PARAMETER_RI => i+L
		)
	port map(
		sigma => sigma(i),
		x_i => x(i),
		y_i => y(i),
		x_o => x(i+1),
		y_o => y(i+1)
	); 
  end generate S_loop;
  

end architecture beh;
