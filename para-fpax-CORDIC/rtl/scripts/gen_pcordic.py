import json
import sys,getopt
from bin_conv import *


def main():
    B=0
    p=0
    alg_name=0

    opts,args=getopt.getopt(sys.argv[1:],"",["B=","alg=","p="])
    for o in opts:
        if o[0]=="--B":
            B=int(o[1])
        elif o[0]=="--p":
            p=int(o[1])
        elif o[0]=="--alg":
            alg_name=o[1]
        else:
            print("Usage: python3 gen_pcordic.py --alg=pcordic --B=16")
            print("Usage: python3 gen_pcordic.py --alg=fpax --B=16 --p=8")
            return
    
    fd=open("cordic_table.json","r")
    data = json.load(fd)

    BB="i"+str(B)
    R_TABLE=data["R_TABLE"]

    n_i_table=[]
    if alg_name=="pcordic":
        try:
            n_i_table=data["pcordic"][BB]["n_i"]
            L=len(n_i_table)
            K=data["pcordic"][BB]["K"]
            K_str=print_bin(float2fixed(K,B),B)
            E_TABLE=data["pcordic"][BB]["e_i"]
            vhdl_file=gen_R_block(R_TABLE,n_i_table)
            ff=open("R_block.vhdl","w")
            ff.write(vhdl_file)
            ff.close()
            vhdl_file=gen_add_prec(E_TABLE,B,L)
            ff=open("prec_add.vhdl","w")
            ff.write(vhdl_file)
            ff.close()

            template_file=open("../vhdl_templates/pcordic.vhdl.temp","r")
            vhdl_file=template_file.read().format(K_str)
            template_file.close()

            ff=open("pcordic.vhdl","w")
            ff.write(vhdl_file)
            ff.close()      
            
        except KeyError:
            print("Not supported value for B: %s"%(B))
            return            
    elif alg_name=="fpax":
        try:
            n_i_table=data["fpax"]["(%s,%d)"%(BB,p)]["n_i"]
            L=len(n_i_table)
            K=data["fpax"]["(%s,%d)"%(BB,p)]["K"]
            K_str=print_bin(float2fixed(K,B),B)
            vhdl_file=gen_R_block(R_TABLE,n_i_table)
            ff=open("R_block.vhdl","w")
            ff.write(vhdl_file)
            ff.close()

            template_file=open("../vhdl_templates/fpax.vhdl.temp","r")
            vhdl_file=template_file.read().format(K_str,"01"+(B-L-1)*"0")
            template_file.close()

            ff=open("fpax.vhdl","w")
            ff.write(vhdl_file)
            ff.close()      

        except KeyError:
            print("Not supported value for (B,p): (\"%s\",%d)"%(BB,p))
            return
    

    
def gen_R_block(R_TABLE,n_i_table):
    L=len(n_i_table)
    template_file=open("../vhdl_templates/R_block.vhdl.temp","r")
    template=template_file.read()

    ss="  signal {0}{1} : signed(0 to B-1);\n"
    ss0=""
    for i in range(0,L+2):
        ss0+=ss.format("x",i)
        ss0+=ss.format("y",i)

    ss1="  x_o<=x{0};\n  y_o<=y{0};\n".format(L+1)
    ss="""  dut{0}: para_S
    generic map(
      B => B,
      PARAMETER_RI => {0}
      )
    port map(
      sigma => sigma({3}),
      x_i => x{1},
      y_i => y{1},
      x_o => x{2},
      y_o => y{2}
      );\n"""

    ss2=""
    k=0
    for i in range(0,L):
        n_i=n_i_table[i]
        for j in range(0,n_i):
            s_i=R_TABLE[i][j]
            ss2+=ss.format(s_i,k,k+1,i)
            k+=1

    return template.format(ss0,ss1,ss2)


def gen_add_prec(E_TABLE,B,L):
    template_file=open("../vhdl_templates/prec_add.vhdl.temp","r")
    template=template_file.read()

    EStr="("
    for i in range(0,L):
        e=E_TABLE[i]        
        e=print_bin(float2fixed(e,B),B)[L-1:]
        EStr+="\"%s\""%(e)
        if i==L-1:
            EStr+=")"
        else:
            EStr+=","
    return template.format(EStr,"01"+(B-L-1)*"0")
    
if __name__=="__main__":
    main()
    

