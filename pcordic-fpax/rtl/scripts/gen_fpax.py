import sys,getopt
from bin_conv import *

R_TABLE=[[1,5,8,10,13,14,15,16,21,22,23],[2,8,10,13,16,20,22],[3,11,13,15,18,22],[4,14,16,18,20],[5,17,19,21,23],[6,20,22],[7,23]]
N_I_TABLE=[[2],[3,2],[5,3,3],[8,5,5,4,3,2],[11,7,6,5,5,3,2]]
B_TABLE={16:0,24:1,32:2,54:3,64:4}
L_TABLE=[4,7,10,17,20]
K_TABLE=(0.8582265202736465425914502702653408050537109375,0.83262806798460864410316162320668809115886688232421875,0.85162519496141741992545348693965934216976165771484375,0.85814796287294614618446075837709940969944000244140625,0.8582265202736465425914502702653408050537109375)
E_TABLE=(-0.046302489843790484, -0.005341921221036272, -0.0006551365751309712, -8.150756627502143e-05, -1.017650125595404e-05, -1.2716899438248996e-06, -1.589496000081042e-07, -1.9868336191553038e-08, -2.483530655000149e-09, -3.104409765277566e-10, -3.880511092579225e-11, -4.850638499805798e-12, -6.063297921469341e-13, -7.579122063023497e-14, -9.473900884713476e-15, -1.1842367635562373e-15, -1.4802917192805604e-16, -1.850343473277019e-17, -2.312823462477867e-18, -2.8904999325053e-19)

fpStr="""library IEEE;
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

  
  x0<="{0}";
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
"""

def main():
    if len(sys.argv)==2:
        opts,args=getopt.getopt(sys.argv[1:],"",["B="])
        for o in opts:
            if o[0]=="--B":
                B=int(o[1])
    else:
        print("Usage: python3 gen_fpax.py --B=val")
        return

    try:
        b=B_TABLE[B]
    except KeyError:
        print("Not supported parameter B=%s"%(B))
        return
    
    L=L_TABLE[b]
    K=K_TABLE[b]
    K=print_bin(float2fixed(K,B),B)


    print(fpStr.format(K))
    
if __name__=="__main__":
    main()
