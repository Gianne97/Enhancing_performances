library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.para_pkg.all;

entity para_R is
  generic (
      PRECISION_FP  :  integer := 9;
      PRECISION_THETA : integer := 16;
      PARAMETER_I : integer := 3
    );
    port(
      clk : in std_logic;
      sigma : in std_logic;
      x_i : in unsigned(PRECISION_FP-1 downto 0);
      y_i : in unsigned(PRECISION_FP-1 downto 0);
      x_o : out unsigned(PRECISION_FP-1 downto 0);
      y_o : out unsigned(PRECISION_FP-1 downto 0)
);
end entity para_R;

architecture behavior of para_R is


  component para_S is
    generic (
      PRECISION_FP : integer := 9;
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
  end component;

  constant N : integer := N_OF_I(PARAMETER_I, PRECISION_THETA);
  type R_WIRE is array (0 to N) of unsigned(PRECISION_FP-1 downto 0);
  signal x_temp : R_WIRE;
  signal y_temp : R_WIRE;
  signal clk1 : std_logic;

begin

   GEN_S : for J in 0 to (N - 1) generate
      PARA_S_U : para_S 
      generic map (PRECISION_FP, Si_OF_I(PARAMETER_I, PRECISION_THETA, J))
      port map (
	clk => clk1,
	sigma => sigma, 
	x_i => x_temp(J), 
	y_i => y_temp(J), 
	x_o => x_temp(J+1),
	y_o => y_temp(J+1)
      );
   end generate GEN_S;

   x_temp(0) <= x_i;
   y_temp(0) <= y_i;

   x_o <= x_temp(N);
   y_o <= y_temp(N);
   
   clk1 <= clk;
end architecture;