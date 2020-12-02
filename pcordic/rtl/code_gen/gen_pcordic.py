includes="""library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

"""

entity_dec="""entity R_block is
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
"""

paraS_comp="""component para_S is
  generic (
    PRECISION_FP    :   integer;
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
"""

instantiation="""dut{0}: para_S
\tgeneric map(
\t\tPRECISION_FP => {1},
\t\tPARAMETER_RI => {5}
\t\t)
\tport map(
\t\tclk => clk,
\t\tsigma => sigma({2}),
\t\tx_i => x{3},
\t\ty_i => y{3},
\t\tx_o => x{4},
\t\ty_o => y{4}
\t); 
"""

R_TABLE=[[1,5,8,10,13,14,15,16,21,22,23],[2,8,10,13,16,20,22],[3,11,13,15,18,22],[4,14,16,18,20],[5,17,19,21,23],[6,20,22],[7,23]]
N_I_TABLE=[[2],[3,2],[5,3,3],[8,5,5,4,3,2],[11,7,6,5,5,3,2]]
B_TABLE={16:0,24:1,32:2,54:3,64:4}
L_TABLE=[4,7,10,17,20]

B=32
b=B_TABLE[B]
L=L_TABLE[b]
N=L
for n_i in N_I_TABLE[b]:
    N+=n_i-1
RR=[]
sigma=[]

for i in range(0,N):
    if i<len(N_I_TABLE[b]):
        for m in range(0,N_I_TABLE[b][i]):
            RR.append(R_TABLE[i][m])
            sigma.append(i)
    else:
        RR.append(i+1)
        sigma.append(i)





print(includes)
print(entity_dec)
print("architecture beh of R_block is")
print(paraS_comp)

for i in range(0,N+1):
    print("signal x%d : signed(0 downto PRECISION_FP-1);"%(i)) 
    print("signal y%d : signed(0 downto PRECISION_FP-1);"%(i))


    
print("begin")
for i in range(0,N):
    print(instantiation.format(i,9,sigma[i],i,i+1,RR[i]))


print("x0<=x_i;")
print("y0<=y_i;")

print("x_o<=x%d;"%(N))
print("y_o<=y%d;"%(N))

print("end architecture beh;")
