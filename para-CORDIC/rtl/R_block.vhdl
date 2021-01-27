library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity R_block is
    generic (
      B    :   integer := 16;
      L    :   integer := 4
    );
    port(
      sigma : in std_logic_vector(0 to L-1);
      x_i : in signed(0 to B-1);
      y_i : in signed(0 to B-1);
      x_o : out signed(0 to B-1);
      y_o : out signed(0 to B-1)
    );
end entity R_block;

architecture beh of R_block is
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

signal x0 : signed(0 to B-1);
signal y0 : signed(0 to B-1);
signal x1 : signed(0 to B-1);
signal y1 : signed(0 to B-1);
signal x2 : signed(0 to B-1);
signal y2 : signed(0 to B-1);
signal x3 : signed(0 to B-1);
signal y3 : signed(0 to B-1);
signal x4 : signed(0 to B-1);
signal y4 : signed(0 to B-1);
signal x5 : signed(0 to B-1);
signal y5 : signed(0 to B-1);
signal x6 : signed(0 to B-1);
signal y6 : signed(0 to B-1);
signal x7 : signed(0 to B-1);
signal y7 : signed(0 to B-1);
signal x8 : signed(0 to B-1);
signal y8 : signed(0 to B-1);
signal x9 : signed(0 to B-1);
signal y9 : signed(0 to B-1);
signal x10 : signed(0 to B-1);
signal y10 : signed(0 to B-1);
begin
dut0: para_S
	generic map(
		B => B,
		PARAMETER_RI => 1
		)
	port map(
		sigma => sigma(0),
		x_i => x0,
		y_i => y0,
		x_o => x1,
		y_o => y1
	); 

dut1: para_S
	generic map(
		B => B,
		PARAMETER_RI => 5
		)
	port map(
		sigma => sigma(0),
		x_i => x1,
		y_i => y1,
		x_o => x2,
		y_o => y2
	); 

dut2: para_S
	generic map(
		B => B,
		PARAMETER_RI => 8
		)
	port map(
		sigma => sigma(0),
		x_i => x2,
		y_i => y2,
		x_o => x3,
		y_o => y3
	); 

dut3: para_S
	generic map(
		B => B,
		PARAMETER_RI => 2
		)
	port map(
		sigma => sigma(1),
		x_i => x3,
		y_i => y3,
		x_o => x4,
		y_o => y4
	); 

dut4: para_S
	generic map(
		B => B,
		PARAMETER_RI => 8
		)
	port map(
		sigma => sigma(1),
		x_i => x4,
		y_i => y4,
		x_o => x5,
		y_o => y5
	); 

dut5: para_S
	generic map(
		B => B,
		PARAMETER_RI => 3
		)
	port map(
		sigma => sigma(2),
		x_i => x5,
		y_i => y5,
		x_o => x6,
		y_o => y6
	); 

dut6: para_S
	generic map(
		B => B,
		PARAMETER_RI => 4
		)
	port map(
		sigma => sigma(3),
		x_i => x6,
		y_i => y6,
		x_o => x7,
		y_o => y7
	); 

dut7: para_S
	generic map(
		B => B,
		PARAMETER_RI => 5
		)
	port map(
		sigma => sigma(4),
		x_i => x7,
		y_i => y7,
		x_o => x8,
		y_o => y8
	); 

dut8: para_S
	generic map(
		B => B,
		PARAMETER_RI => 6
		)
	port map(
		sigma => sigma(5),
		x_i => x8,
		y_i => y8,
		x_o => x9,
		y_o => y9
	); 

dut9: para_S
	generic map(
		B => B,
		PARAMETER_RI => 7
		)
	port map(
		sigma => sigma(6),
		x_i => x9,
		y_i => y9,
		x_o => x10,
		y_o => y10
	); 

x0<=x_i;
y0<=y_i;
x_o<=x10;
y_o<=y10;
end architecture beh;