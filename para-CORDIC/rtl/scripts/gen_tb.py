import sys
import getopt
from bin_conv import *


R_TABLE=[[1,5,8,10,13,14,15,16,21,22,23],[2,8,10,13,16,20,22],[3,11,13,15,18,22],[4,14,16,18,20],[5,17,19,21,23],[6,20,22],[7,23]]
N_I_TABLE=[[2],[3,2],[5,3,3],[8,5,5,4,3,2],[11,7,6,5,5,3,2]]
B_TABLE={16:0,24:1,32:2,54:3,64:4}
L_TABLE=[4,7,10,17,20]


tbStr="""library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb is
  generic(
    B    :   integer := {1};
    L : integer := {2}
    );
end entity tb;

architecture beh of tb is
  constant clk_period : time := 10 ns;
  constant N_periods: integer:= {0};
  signal clk: std_logic;

  signal theta : signed(0 to B-1);
  signal x_o : signed(0 to B-1);
  signal y_o : signed(0 to B-1);

  component {4} is
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
  end component {4};     

begin

  dut: entity work.{4}
    generic map(B=>B,L=>L)
    port map (clk=>clk,theta=>theta,x_o=>x_o,y_o=>y_o);
    
  stimul: process
  begin
{3}
\twait;
  end process stimul; 
    
  clkgen : process      
  begin
    for i in 1 to N_periods loop
      clk <= '0';
      wait for clk_period/2;  
      clk <= '1';
      wait for clk_period/2;
    end loop;
    wait;
    
  end process clkgen;

 print: process(clk)
  begin
    if(clk='1' and clk'event) then
    --report "clk=" & std_logic'image(clk); 
    for i in 0 to B-1 loop
	report "theta(" &  integer'image(i) &")="& std_logic'image(theta(i));
    end loop;
    for i in 0 to B-1 loop
	report "x_o(" &  integer'image(i) &")="& std_logic'image(x_o(i));
    end loop;
    for i in 0 to B-1 loop
      report "y_o(" &  integer'image(i) &")="& std_logic'image(y_o(i));
    end loop;
  end if;
  end process print;

end architecture beh;         
"""




def main():
    if len(sys.argv)==4:
        opts,args=getopt.getopt(sys.argv[1:],"",['alg=','B=','theta='])
        for o in opts:
            if o[0]=="--B":
                B=int(o[1])
            elif o[0]=="--alg":
                entity_name=o[1]
            elif o[0]=="--theta":
                theta=[]
                if o[1][0]=="[":
                    ss=o[1][1:-1]
                    ss=ss.split(',')
                    for s in ss:
                        theta.append(float(s))
                else:
                    theta.append(float(o[1]))
    else:
        print("Usage: python3 gen_tb.py -Bval -thetaval")
        return

    try:
        b=B_TABLE[B]
    except KeyError:
        print("Not supported parameter B=%s"%(B))
        return
    
    L=L_TABLE[b]


    N_periods=len(theta)

    stimStr=""
    for th in theta:
        theta_bin=print_bin(float2fixed(th,B),B)
        stimStr+="\ttheta<=\"%s\";\n"%(theta_bin)
        stimStr+="\twait for clk_period;\n"
        
    fd=open("tb.vhdl","w")
    fd.write(tbStr.format(N_periods,B,L,stimStr,entity_name))

if __name__=="__main__":
    main()
