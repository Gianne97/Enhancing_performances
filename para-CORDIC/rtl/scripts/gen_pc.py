import sys,getopt
from bin_conv import *

R_TABLE=[[1,5,8,10,13,14,15,16,21,22,23],[2,8,10,13,16,20,22],[3,11,13,15,18,22],[4,14,16,18,20],[5,17,19,21,23],[6,20,22],[7,23]]
N_I_TABLE=[[2],[3,2],[5,3,3],[8,5,5,4,3,2],[11,7,6,5,5,3,2]]
B_TABLE={16:0,24:1,32:2,54:3,64:4}
L_TABLE=[4,7,10,17,20]
K_TABLE=(0.8582265202736465425914502702653408050537109375,0.83262806798460864410316162320668809115886688232421875,0.85162519496141741992545348693965934216976165771484375,0.85814796287294614618446075837709940969944000244140625,0.8582265202736465425914502702653408050537109375)
E_TABLE=(-0.046302489843790484, -0.005341921221036272, -0.0006551365751309712, -8.150756627502143e-05, -1.017650125595404e-05, -1.2716899438248996e-06, -1.589496000081042e-07, -1.9868336191553038e-08, -2.483530655000149e-09, -3.104409765277566e-10, -3.880511092579225e-11, -4.850638499805798e-12, -6.063297921469341e-13, -7.579122063023497e-14, -9.473900884713476e-15, -1.1842367635562373e-15, -1.4802917192805604e-16, -1.850343473277019e-17, -2.312823462477867e-18, -2.8904999325053e-19)

ERRORS={'e16': [5.11255757e-03, 5.02133687e-03, 6.45005453e-04, 8.11900040e-05], 'e24': [1.20632744e-03, 1.11510674e-03, 6.45005453e-04, 8.11900040e-05,1.01665697e-05, 1.27137952e-06, 1.58939899e-07], 'e32': [1.07694936e-04, 1.38544552e-04, 3.46539301e-05, 8.11900040e-05,1.01665697e-05, 1.27137952e-06, 1.58939899e-07, 1.98680330e-08,2.48352118e-09, 3.10440681e-10], 'e54': [8.83412155e-07, 2.61776338e-07, 3.21654769e-07, 1.08136154e-06,6.29826568e-07, 3.17705207e-07, 1.58939899e-07, 1.98680330e-08,2.48352118e-09, 3.10440681e-10, 3.88051017e-11, 4.85063823e-12,6.06329792e-13, 7.57912274e-14, 9.47390427e-15, 1.18423846e-15,1.48030019e-16], 'e64': [4.89471278e-08, 2.33577591e-08, 8.32361898e-08, 1.27687225e-07,3.37801201e-08, 7.92866277e-08, 3.97306093e-08, 1.98680330e-08,2.48352118e-09, 3.10440681e-10, 3.88051017e-11, 4.85063823e-12,6.06329792e-13, 7.57912274e-14, 9.47390427e-15, 1.18423846e-15,1.48030019e-16, 1.85038582e-17, 2.31303522e-18, 2.89155872e-19]}

ERROR_INDS={0:"e16",1:"e24",2:"e32",3:"e54",4:"e64"}

pcStr="""library IEEE;
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
"""

paStr="""library IEEE;
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
  signal e : E_TABLE:={0};

  type t_array is array (0 to L) of signed(0 to B-L);
  signal theta_arr : t_array;

begin
  
  theta_arr(0)<=i_theta_H;
  o_theta_H<=theta_arr(L)-\"{1}\";

  gen_add: 
   for i in 0 to L-1 generate
     theta_arr(i+1)<= theta_arr(i)+e(i) when sigma(i)='1' else
                      theta_arr(i)-e(i);
   end generate gen_add;

end architecture beh;
"""


def main():
    if len(sys.argv)==3:
        opts,args=getopt.getopt(sys.argv[1:],"",["B=","name="])
        for o in opts:
            if o[0]=="--B":
                B=int(o[1])
            elif o[0]=="--name":
                file=o[1]
    else:
        print("Usage: python3 gen_pc.py --B=val --name=name")
        return

    try:
        b=B_TABLE[B]
    except KeyError:
        print("Not supported parameter B=%s"%(B))
        return

    e_ind=ERROR_INDS[b]
    errs=ERRORS[e_ind]
    
    L=L_TABLE[b]
    K=K_TABLE[b]
    K=print_bin(float2fixed(K,B),B)
    EStr="("
    for i in range(0,L):
        e=errs[i]
        e=print_bin(float2fixed(e,B),B)[L-1:]
        EStr+="\"%s\""%(e)
        if i==L-1:
            EStr+=")"
        else:
            EStr+=","

    if file=="pcordic.vhdl":
        print(pcStr.format(K))
    elif file=="prec_add.vhdl":
        print(paStr.format(EStr,"01"+(B-L-1)*"0"))

if __name__=="__main__":
    main()



