library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity R_block is
    generic (
      PRECISION_FP    :   integer := 9
    );
    port(
      clk : in std_logic;
      sigma : in std_logic_vector(0 downto PRECISION_FP-1);
      x_i : in signed(0 downto PRECISION_FP-1);
      y_i : in signed(0 downto PRECISION_FP-1);
      x_o : out signed(0 downto PRECISION_FP-1);
      y_o : out signed(0 downto PRECISION_FP-1)
    );
end entity R_block;

architecture beh of R_block is
component para_S is
  generic (
    PRECISION_FP    :   integer := 9;
    PARAMETER_RI : integer
    );      
  port(
    clk : in std_logic;
    sigma : in std_logic;
    x_i : in signed(0 downto PRECISION_FP-1);
    y_i : in signed(0 downto PRECISION_FP-1);
    x_o : out signed(0 downto PRECISION_FP-1);
    y_o : out signed(0 downto PRECISION_FP-1)
    );
end component para_S;

signal x0 : signed(0 downto PRECISION_FP-1);
signal y0 : signed(0 downto PRECISION_FP-1);
signal x1 : signed(0 downto PRECISION_FP-1);
signal y1 : signed(0 downto PRECISION_FP-1);
signal x2 : signed(0 downto PRECISION_FP-1);
signal y2 : signed(0 downto PRECISION_FP-1);
signal x3 : signed(0 downto PRECISION_FP-1);
signal y3 : signed(0 downto PRECISION_FP-1);
signal x4 : signed(0 downto PRECISION_FP-1);
signal y4 : signed(0 downto PRECISION_FP-1);
signal x5 : signed(0 downto PRECISION_FP-1);
signal y5 : signed(0 downto PRECISION_FP-1);
signal x6 : signed(0 downto PRECISION_FP-1);
signal y6 : signed(0 downto PRECISION_FP-1);
signal x7 : signed(0 downto PRECISION_FP-1);
signal y7 : signed(0 downto PRECISION_FP-1);
signal x8 : signed(0 downto PRECISION_FP-1);
signal y8 : signed(0 downto PRECISION_FP-1);
signal x9 : signed(0 downto PRECISION_FP-1);
signal y9 : signed(0 downto PRECISION_FP-1);
signal x10 : signed(0 downto PRECISION_FP-1);
signal y10 : signed(0 downto PRECISION_FP-1);
signal x11 : signed(0 downto PRECISION_FP-1);
signal y11 : signed(0 downto PRECISION_FP-1);
signal x12 : signed(0 downto PRECISION_FP-1);
signal y12 : signed(0 downto PRECISION_FP-1);
signal x13 : signed(0 downto PRECISION_FP-1);
signal y13 : signed(0 downto PRECISION_FP-1);
signal x14 : signed(0 downto PRECISION_FP-1);
signal y14 : signed(0 downto PRECISION_FP-1);
signal x15 : signed(0 downto PRECISION_FP-1);
signal y15 : signed(0 downto PRECISION_FP-1);
signal x16 : signed(0 downto PRECISION_FP-1);
signal y16 : signed(0 downto PRECISION_FP-1);
signal x17 : signed(0 downto PRECISION_FP-1);
signal y17 : signed(0 downto PRECISION_FP-1);
signal x18 : signed(0 downto PRECISION_FP-1);
signal y18 : signed(0 downto PRECISION_FP-1);
begin
dut0: para_S
	generic map(
		PRECISION_FP => 9,
		PARAMETER_RI => 1
		)
	port map(
		clk => clk,
		sigma => sigma(0),
		x_i => x0,
		y_i => y0,
		x_o => x1,
		y_o => y1
	); 

dut1: para_S
	generic map(
		PRECISION_FP => 9,
		PARAMETER_RI => 5
		)
	port map(
		clk => clk,
		sigma => sigma(0),
		x_i => x1,
		y_i => y1,
		x_o => x2,
		y_o => y2
	); 

dut2: para_S
	generic map(
		PRECISION_FP => 9,
		PARAMETER_RI => 8
		)
	port map(
		clk => clk,
		sigma => sigma(0),
		x_i => x2,
		y_i => y2,
		x_o => x3,
		y_o => y3
	); 

dut3: para_S
	generic map(
		PRECISION_FP => 9,
		PARAMETER_RI => 10
		)
	port map(
		clk => clk,
		sigma => sigma(0),
		x_i => x3,
		y_i => y3,
		x_o => x4,
		y_o => y4
	); 

dut4: para_S
	generic map(
		PRECISION_FP => 9,
		PARAMETER_RI => 13
		)
	port map(
		clk => clk,
		sigma => sigma(0),
		x_i => x4,
		y_i => y4,
		x_o => x5,
		y_o => y5
	); 

dut5: para_S
	generic map(
		PRECISION_FP => 9,
		PARAMETER_RI => 2
		)
	port map(
		clk => clk,
		sigma => sigma(1),
		x_i => x5,
		y_i => y5,
		x_o => x6,
		y_o => y6
	); 

dut6: para_S
	generic map(
		PRECISION_FP => 9,
		PARAMETER_RI => 8
		)
	port map(
		clk => clk,
		sigma => sigma(1),
		x_i => x6,
		y_i => y6,
		x_o => x7,
		y_o => y7
	); 

dut7: para_S
	generic map(
		PRECISION_FP => 9,
		PARAMETER_RI => 10
		)
	port map(
		clk => clk,
		sigma => sigma(1),
		x_i => x7,
		y_i => y7,
		x_o => x8,
		y_o => y8
	); 

dut8: para_S
	generic map(
		PRECISION_FP => 9,
		PARAMETER_RI => 3
		)
	port map(
		clk => clk,
		sigma => sigma(2),
		x_i => x8,
		y_i => y8,
		x_o => x9,
		y_o => y9
	); 

dut9: para_S
	generic map(
		PRECISION_FP => 9,
		PARAMETER_RI => 11
		)
	port map(
		clk => clk,
		sigma => sigma(2),
		x_i => x9,
		y_i => y9,
		x_o => x10,
		y_o => y10
	); 

dut10: para_S
	generic map(
		PRECISION_FP => 9,
		PARAMETER_RI => 13
		)
	port map(
		clk => clk,
		sigma => sigma(2),
		x_i => x10,
		y_i => y10,
		x_o => x11,
		y_o => y11
	); 

dut11: para_S
	generic map(
		PRECISION_FP => 9,
		PARAMETER_RI => 4
		)
	port map(
		clk => clk,
		sigma => sigma(3),
		x_i => x11,
		y_i => y11,
		x_o => x12,
		y_o => y12
	); 

dut12: para_S
	generic map(
		PRECISION_FP => 9,
		PARAMETER_RI => 5
		)
	port map(
		clk => clk,
		sigma => sigma(4),
		x_i => x12,
		y_i => y12,
		x_o => x13,
		y_o => y13
	); 

dut13: para_S
	generic map(
		PRECISION_FP => 9,
		PARAMETER_RI => 6
		)
	port map(
		clk => clk,
		sigma => sigma(5),
		x_i => x13,
		y_i => y13,
		x_o => x14,
		y_o => y14
	); 

dut14: para_S
	generic map(
		PRECISION_FP => 9,
		PARAMETER_RI => 7
		)
	port map(
		clk => clk,
		sigma => sigma(6),
		x_i => x14,
		y_i => y14,
		x_o => x15,
		y_o => y15
	); 

dut15: para_S
	generic map(
		PRECISION_FP => 9,
		PARAMETER_RI => 8
		)
	port map(
		clk => clk,
		sigma => sigma(7),
		x_i => x15,
		y_i => y15,
		x_o => x16,
		y_o => y16
	); 

dut16: para_S
	generic map(
		PRECISION_FP => 9,
		PARAMETER_RI => 9
		)
	port map(
		clk => clk,
		sigma => sigma(8),
		x_i => x16,
		y_i => y16,
		x_o => x17,
		y_o => y17
	); 

dut17: para_S
	generic map(
		PRECISION_FP => 9,
		PARAMETER_RI => 10
		)
	port map(
		clk => clk,
		sigma => sigma(9),
		x_i => x17,
		y_i => y17,
		x_o => x18,
		y_o => y18
	); 

x0<=x_i;
y0<=y_i;
x_o<=x18;
y_o<=y18;
end architecture beh;
