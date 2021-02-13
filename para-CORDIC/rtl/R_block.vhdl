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
signal x11 : signed(0 to B-1);
signal y11 : signed(0 to B-1);
signal x12 : signed(0 to B-1);
signal y12 : signed(0 to B-1);
signal x13 : signed(0 to B-1);
signal y13 : signed(0 to B-1);
signal x14 : signed(0 to B-1);
signal y14 : signed(0 to B-1);
signal x15 : signed(0 to B-1);
signal y15 : signed(0 to B-1);
signal x16 : signed(0 to B-1);
signal y16 : signed(0 to B-1);
signal x17 : signed(0 to B-1);
signal y17 : signed(0 to B-1);
signal x18 : signed(0 to B-1);
signal y18 : signed(0 to B-1);
signal x19 : signed(0 to B-1);
signal y19 : signed(0 to B-1);
signal x20 : signed(0 to B-1);
signal y20 : signed(0 to B-1);
signal x21 : signed(0 to B-1);
signal y21 : signed(0 to B-1);
signal x22 : signed(0 to B-1);
signal y22 : signed(0 to B-1);
signal x23 : signed(0 to B-1);
signal y23 : signed(0 to B-1);
signal x24 : signed(0 to B-1);
signal y24 : signed(0 to B-1);
signal x25 : signed(0 to B-1);
signal y25 : signed(0 to B-1);
signal x26 : signed(0 to B-1);
signal y26 : signed(0 to B-1);
signal x27 : signed(0 to B-1);
signal y27 : signed(0 to B-1);
signal x28 : signed(0 to B-1);
signal y28 : signed(0 to B-1);
signal x29 : signed(0 to B-1);
signal y29 : signed(0 to B-1);
signal x30 : signed(0 to B-1);
signal y30 : signed(0 to B-1);
signal x31 : signed(0 to B-1);
signal y31 : signed(0 to B-1);
signal x32 : signed(0 to B-1);
signal y32 : signed(0 to B-1);
signal x33 : signed(0 to B-1);
signal y33 : signed(0 to B-1);
signal x34 : signed(0 to B-1);
signal y34 : signed(0 to B-1);
signal x35 : signed(0 to B-1);
signal y35 : signed(0 to B-1);
signal x36 : signed(0 to B-1);
signal y36 : signed(0 to B-1);
signal x37 : signed(0 to B-1);
signal y37 : signed(0 to B-1);
signal x38 : signed(0 to B-1);
signal y38 : signed(0 to B-1);
signal x39 : signed(0 to B-1);
signal y39 : signed(0 to B-1);
signal x40 : signed(0 to B-1);
signal y40 : signed(0 to B-1);
signal x41 : signed(0 to B-1);
signal y41 : signed(0 to B-1);
signal x42 : signed(0 to B-1);
signal y42 : signed(0 to B-1);
signal x43 : signed(0 to B-1);
signal y43 : signed(0 to B-1);
signal x44 : signed(0 to B-1);
signal y44 : signed(0 to B-1);
signal x45 : signed(0 to B-1);
signal y45 : signed(0 to B-1);
signal x46 : signed(0 to B-1);
signal y46 : signed(0 to B-1);
signal x47 : signed(0 to B-1);
signal y47 : signed(0 to B-1);
signal x48 : signed(0 to B-1);
signal y48 : signed(0 to B-1);
signal x49 : signed(0 to B-1);
signal y49 : signed(0 to B-1);
signal x50 : signed(0 to B-1);
signal y50 : signed(0 to B-1);
signal x51 : signed(0 to B-1);
signal y51 : signed(0 to B-1);
signal x52 : signed(0 to B-1);
signal y52 : signed(0 to B-1);
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
		PARAMETER_RI => 10
		)
	port map(
		sigma => sigma(0),
		x_i => x3,
		y_i => y3,
		x_o => x4,
		y_o => y4
	); 

dut4: para_S
	generic map(
		B => B,
		PARAMETER_RI => 13
		)
	port map(
		sigma => sigma(0),
		x_i => x4,
		y_i => y4,
		x_o => x5,
		y_o => y5
	); 

dut5: para_S
	generic map(
		B => B,
		PARAMETER_RI => 14
		)
	port map(
		sigma => sigma(0),
		x_i => x5,
		y_i => y5,
		x_o => x6,
		y_o => y6
	); 

dut6: para_S
	generic map(
		B => B,
		PARAMETER_RI => 15
		)
	port map(
		sigma => sigma(0),
		x_i => x6,
		y_i => y6,
		x_o => x7,
		y_o => y7
	); 

dut7: para_S
	generic map(
		B => B,
		PARAMETER_RI => 16
		)
	port map(
		sigma => sigma(0),
		x_i => x7,
		y_i => y7,
		x_o => x8,
		y_o => y8
	); 

dut8: para_S
	generic map(
		B => B,
		PARAMETER_RI => 21
		)
	port map(
		sigma => sigma(0),
		x_i => x8,
		y_i => y8,
		x_o => x9,
		y_o => y9
	); 

dut9: para_S
	generic map(
		B => B,
		PARAMETER_RI => 22
		)
	port map(
		sigma => sigma(0),
		x_i => x9,
		y_i => y9,
		x_o => x10,
		y_o => y10
	); 

dut10: para_S
	generic map(
		B => B,
		PARAMETER_RI => 23
		)
	port map(
		sigma => sigma(0),
		x_i => x10,
		y_i => y10,
		x_o => x11,
		y_o => y11
	); 

dut11: para_S
	generic map(
		B => B,
		PARAMETER_RI => 2
		)
	port map(
		sigma => sigma(1),
		x_i => x11,
		y_i => y11,
		x_o => x12,
		y_o => y12
	); 

dut12: para_S
	generic map(
		B => B,
		PARAMETER_RI => 8
		)
	port map(
		sigma => sigma(1),
		x_i => x12,
		y_i => y12,
		x_o => x13,
		y_o => y13
	); 

dut13: para_S
	generic map(
		B => B,
		PARAMETER_RI => 10
		)
	port map(
		sigma => sigma(1),
		x_i => x13,
		y_i => y13,
		x_o => x14,
		y_o => y14
	); 

dut14: para_S
	generic map(
		B => B,
		PARAMETER_RI => 13
		)
	port map(
		sigma => sigma(1),
		x_i => x14,
		y_i => y14,
		x_o => x15,
		y_o => y15
	); 

dut15: para_S
	generic map(
		B => B,
		PARAMETER_RI => 16
		)
	port map(
		sigma => sigma(1),
		x_i => x15,
		y_i => y15,
		x_o => x16,
		y_o => y16
	); 

dut16: para_S
	generic map(
		B => B,
		PARAMETER_RI => 20
		)
	port map(
		sigma => sigma(1),
		x_i => x16,
		y_i => y16,
		x_o => x17,
		y_o => y17
	); 

dut17: para_S
	generic map(
		B => B,
		PARAMETER_RI => 22
		)
	port map(
		sigma => sigma(1),
		x_i => x17,
		y_i => y17,
		x_o => x18,
		y_o => y18
	); 

dut18: para_S
	generic map(
		B => B,
		PARAMETER_RI => 3
		)
	port map(
		sigma => sigma(2),
		x_i => x18,
		y_i => y18,
		x_o => x19,
		y_o => y19
	); 

dut19: para_S
	generic map(
		B => B,
		PARAMETER_RI => 11
		)
	port map(
		sigma => sigma(2),
		x_i => x19,
		y_i => y19,
		x_o => x20,
		y_o => y20
	); 

dut20: para_S
	generic map(
		B => B,
		PARAMETER_RI => 13
		)
	port map(
		sigma => sigma(2),
		x_i => x20,
		y_i => y20,
		x_o => x21,
		y_o => y21
	); 

dut21: para_S
	generic map(
		B => B,
		PARAMETER_RI => 15
		)
	port map(
		sigma => sigma(2),
		x_i => x21,
		y_i => y21,
		x_o => x22,
		y_o => y22
	); 

dut22: para_S
	generic map(
		B => B,
		PARAMETER_RI => 18
		)
	port map(
		sigma => sigma(2),
		x_i => x22,
		y_i => y22,
		x_o => x23,
		y_o => y23
	); 

dut23: para_S
	generic map(
		B => B,
		PARAMETER_RI => 22
		)
	port map(
		sigma => sigma(2),
		x_i => x23,
		y_i => y23,
		x_o => x24,
		y_o => y24
	); 

dut24: para_S
	generic map(
		B => B,
		PARAMETER_RI => 4
		)
	port map(
		sigma => sigma(3),
		x_i => x24,
		y_i => y24,
		x_o => x25,
		y_o => y25
	); 

dut25: para_S
	generic map(
		B => B,
		PARAMETER_RI => 14
		)
	port map(
		sigma => sigma(3),
		x_i => x25,
		y_i => y25,
		x_o => x26,
		y_o => y26
	); 

dut26: para_S
	generic map(
		B => B,
		PARAMETER_RI => 16
		)
	port map(
		sigma => sigma(3),
		x_i => x26,
		y_i => y26,
		x_o => x27,
		y_o => y27
	); 

dut27: para_S
	generic map(
		B => B,
		PARAMETER_RI => 18
		)
	port map(
		sigma => sigma(3),
		x_i => x27,
		y_i => y27,
		x_o => x28,
		y_o => y28
	); 

dut28: para_S
	generic map(
		B => B,
		PARAMETER_RI => 20
		)
	port map(
		sigma => sigma(3),
		x_i => x28,
		y_i => y28,
		x_o => x29,
		y_o => y29
	); 

dut29: para_S
	generic map(
		B => B,
		PARAMETER_RI => 5
		)
	port map(
		sigma => sigma(4),
		x_i => x29,
		y_i => y29,
		x_o => x30,
		y_o => y30
	); 

dut30: para_S
	generic map(
		B => B,
		PARAMETER_RI => 17
		)
	port map(
		sigma => sigma(4),
		x_i => x30,
		y_i => y30,
		x_o => x31,
		y_o => y31
	); 

dut31: para_S
	generic map(
		B => B,
		PARAMETER_RI => 19
		)
	port map(
		sigma => sigma(4),
		x_i => x31,
		y_i => y31,
		x_o => x32,
		y_o => y32
	); 

dut32: para_S
	generic map(
		B => B,
		PARAMETER_RI => 21
		)
	port map(
		sigma => sigma(4),
		x_i => x32,
		y_i => y32,
		x_o => x33,
		y_o => y33
	); 

dut33: para_S
	generic map(
		B => B,
		PARAMETER_RI => 23
		)
	port map(
		sigma => sigma(4),
		x_i => x33,
		y_i => y33,
		x_o => x34,
		y_o => y34
	); 

dut34: para_S
	generic map(
		B => B,
		PARAMETER_RI => 6
		)
	port map(
		sigma => sigma(5),
		x_i => x34,
		y_i => y34,
		x_o => x35,
		y_o => y35
	); 

dut35: para_S
	generic map(
		B => B,
		PARAMETER_RI => 20
		)
	port map(
		sigma => sigma(5),
		x_i => x35,
		y_i => y35,
		x_o => x36,
		y_o => y36
	); 

dut36: para_S
	generic map(
		B => B,
		PARAMETER_RI => 22
		)
	port map(
		sigma => sigma(5),
		x_i => x36,
		y_i => y36,
		x_o => x37,
		y_o => y37
	); 

dut37: para_S
	generic map(
		B => B,
		PARAMETER_RI => 7
		)
	port map(
		sigma => sigma(6),
		x_i => x37,
		y_i => y37,
		x_o => x38,
		y_o => y38
	); 

dut38: para_S
	generic map(
		B => B,
		PARAMETER_RI => 23
		)
	port map(
		sigma => sigma(6),
		x_i => x38,
		y_i => y38,
		x_o => x39,
		y_o => y39
	); 

dut39: para_S
	generic map(
		B => B,
		PARAMETER_RI => 8
		)
	port map(
		sigma => sigma(7),
		x_i => x39,
		y_i => y39,
		x_o => x40,
		y_o => y40
	); 

dut40: para_S
	generic map(
		B => B,
		PARAMETER_RI => 9
		)
	port map(
		sigma => sigma(8),
		x_i => x40,
		y_i => y40,
		x_o => x41,
		y_o => y41
	); 

dut41: para_S
	generic map(
		B => B,
		PARAMETER_RI => 10
		)
	port map(
		sigma => sigma(9),
		x_i => x41,
		y_i => y41,
		x_o => x42,
		y_o => y42
	); 

dut42: para_S
	generic map(
		B => B,
		PARAMETER_RI => 11
		)
	port map(
		sigma => sigma(10),
		x_i => x42,
		y_i => y42,
		x_o => x43,
		y_o => y43
	); 

dut43: para_S
	generic map(
		B => B,
		PARAMETER_RI => 12
		)
	port map(
		sigma => sigma(11),
		x_i => x43,
		y_i => y43,
		x_o => x44,
		y_o => y44
	); 

dut44: para_S
	generic map(
		B => B,
		PARAMETER_RI => 13
		)
	port map(
		sigma => sigma(12),
		x_i => x44,
		y_i => y44,
		x_o => x45,
		y_o => y45
	); 

dut45: para_S
	generic map(
		B => B,
		PARAMETER_RI => 14
		)
	port map(
		sigma => sigma(13),
		x_i => x45,
		y_i => y45,
		x_o => x46,
		y_o => y46
	); 

dut46: para_S
	generic map(
		B => B,
		PARAMETER_RI => 15
		)
	port map(
		sigma => sigma(14),
		x_i => x46,
		y_i => y46,
		x_o => x47,
		y_o => y47
	); 

dut47: para_S
	generic map(
		B => B,
		PARAMETER_RI => 16
		)
	port map(
		sigma => sigma(15),
		x_i => x47,
		y_i => y47,
		x_o => x48,
		y_o => y48
	); 

dut48: para_S
	generic map(
		B => B,
		PARAMETER_RI => 17
		)
	port map(
		sigma => sigma(16),
		x_i => x48,
		y_i => y48,
		x_o => x49,
		y_o => y49
	); 

dut49: para_S
	generic map(
		B => B,
		PARAMETER_RI => 18
		)
	port map(
		sigma => sigma(17),
		x_i => x49,
		y_i => y49,
		x_o => x50,
		y_o => y50
	); 

dut50: para_S
	generic map(
		B => B,
		PARAMETER_RI => 19
		)
	port map(
		sigma => sigma(18),
		x_i => x50,
		y_i => y50,
		x_o => x51,
		y_o => y51
	); 

dut51: para_S
	generic map(
		B => B,
		PARAMETER_RI => 20
		)
	port map(
		sigma => sigma(19),
		x_i => x51,
		y_i => y51,
		x_o => x52,
		y_o => y52
	); 

x0<=x_i;
y0<=y_i;
x_o<=x52;
y_o<=y52;
end architecture beh;
