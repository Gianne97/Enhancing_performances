library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity pcordic is
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
end entity pcordic;         

architecture beh of pcordic is

  signal sigma_L : std_logic_vector(0 to L-1);

  signal theta_H1 : signed(0 to B-L);
  signal theta_H2 : signed(0 to B-L);         
  signal sigma_H : std_logic_vector(0 to B-L-1);
  
  signal x0 : signed(0 to B-1);
  signal y0 : signed(0 to B-1);
  signal x_L : signed(0 to B-1);
  signal y_L : signed(0 to B-1);
  
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

  component prec_add is
      generic(
        B    :   integer := 16;
        L : integer := 4
        );
        port(            
            i_theta_H : in signed(0 to B-L);
            sigma : in std_logic_vector(0 to L-1);
            o_theta_H : out signed(0 to B-L)
            );
    end component prec_add;

  component S_block is
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
  end component S_block;

begin

  sigma_L(0)<=not theta(0);
  sigma_L(1 to L-1)<=std_logic_vector(theta(1 to L-1));

  sigma_H(0)<=not theta_H2(0);
  sigma_H(1 to B-L-1)<=std_logic_vector(theta_H2(1 to B-L-1));  

  theta_H1<=theta(L-1 to B-1);
  
  x0<="01101101000000100000110111101100";
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

  pa: prec_add
    generic map(
      B => B,L=>L
      )
    port map(
      i_theta_H=>theta_H1,
      sigma=>sigma_L,
      o_theta_H=>theta_H2
    );

  ss: S_block
    generic map(
      B => B,L=>L
      )
    port map(
      sigma=>sigma_H,
      x_i=>x_L,
      y_i=>y_L,
      x_o => x_o,
      y_o => y_o
      );        
      
end architecture beh;

