library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity para_S is
  generic (
    PRECISION_FP    :   integer := 16;
    PARAMETER_RI : integer
    );      
  port(
    sigma : in std_logic;
    x_i : in signed(0 to PRECISION_FP-1);
    y_i : in signed(0 to PRECISION_FP-1);
    x_o : out signed(0 to PRECISION_FP-1);
    y_o : out signed(0 to PRECISION_FP-1));
end entity para_S;

architecture beh of para_S is
  signal shifted_x : signed(0 to PRECISION_FP-1);
  signal shifted_y : signed(0 to PRECISION_FP-1);

  signal add1 : signed(0 to PRECISION_FP-1);
  signal add2 : signed(0 to PRECISION_FP-1);
  signal sub1 : signed(0 to PRECISION_FP-1);
  signal sub2 : signed(0 to PRECISION_FP-1);
  signal add : signed(0 to PRECISION_FP-1);        
  signal sub : signed(0 to PRECISION_FP-1);

  component shifter is
    generic(
      PRECISION_FP    :   integer := 9;
      PARAMETER_RI : integer);
    port(
      x_i : in signed(0 to PRECISION_FP-1);
      x_o : out signed(0 to PRECISION_FP-1));
  end component shifter;
  
  
begin  

  sh1: shifter
    generic map(PRECISION_FP=>PRECISION_FP,PARAMETER_RI=>PARAMETER_RI)
    port map(x_i=>x_i,x_o=>shifted_x);

  sh2: shifter
    generic map(PRECISION_FP=>PRECISION_FP,PARAMETER_RI=>PARAMETER_RI)
    port map(x_i=>y_i,x_o=>shifted_y);

  
  add1 <= x_i when sigma='0' else
          y_i;
  add2 <= shifted_y when sigma='0' else
          shifted_x;

  sub1 <= x_i when sigma='1' else
          y_i;
  sub2 <= shifted_y when sigma='1' else
          shifted_x;
  
  add<=add1+add2;
  sub<=sub1-sub2;

  --x_o<=shifted_x;
  x_o <= add when sigma='0' else
         sub;

  y_o <= sub when sigma='0' else
         add;
  

    
end architecture beh;
