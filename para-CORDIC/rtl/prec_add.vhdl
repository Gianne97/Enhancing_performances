library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity prec_add is
  generic(
    B    :   integer := 16;
    L    :   integer := 4
    );
    port(
      i_theta_H : in signed(0 to B-L);
      sigma : in std_logic_vector(0 to L-1);
      o_theta_H : out signed(0 to B-L)
    );
end entity prec_add;

architecture beh of prec_add is

  type E_TABLE is array (0 to L-1) of signed(0 to B-L);
  signal e : E_TABLE:=("100001001011000010","110101000011110100","111110101010001000","111111110101010100","111111111110101010","111111111111110101","111111111111111110");

  type t_array is array (0 to L) of signed(0 to B-L);
  signal theta_arr : t_array;

begin
  
  theta_arr(0)<=i_theta_H;
  o_theta_H<=theta_arr(L);

  gen_add: 
   for i in 0 to L-1 generate
     theta_arr(i+1)<= theta_arr(i)+e(i) when sigma(i)='1' else
                      theta_arr(i)-e(i);
   end generate gen_add;

end architecture beh;

