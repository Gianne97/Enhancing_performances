import numpy as np
from bin_conv import *
from fpax_table import kk
import sys

R_TABLE=[[1,5,8,10,13,14,15,16,21,22,23],[2,8,10,13,16,20,22],[3,11,13,15,18,22],[4,14,16,18,20],[5,17,19,21,23],[6,20,22],[7,23]]
N_I_TABLE=[[2],[3,2],[5,3,3],[8,5,5,4,3,2],[11,7,6,5,5,3,2]]
B_TABLE={16:0,24:1,32:2,54:3,64:4}
L_TABLE=[4,7,10,17,20]

K_TABLE=(0.8582265202736465425914502702653408050537109375,0.83262806798460864410316162320668809115886688232421875,0.85162519496141741992545348693965934216976165771484375,0.85814796287294614618446075837709940969944000244140625,0.8582265202736465425914502702653408050537109375)

e16=[5.11255757e-03, 5.02133687e-03, 6.45005453e-04, 8.11900040e-05]
e24=[1.20632744e-03, 1.11510674e-03, 6.45005453e-04, 8.11900040e-05,1.01665697e-05, 1.27137952e-06, 1.58939899e-07]


def fixed_shift(x,i,BB):
    shifter=2**(BB-1)
    if x&shifter:
        shifted_x=x>>i
        shifted_x|=shifter
    else:
        shifted_x=x>>i
    return shifted_x

def S_op(x,y,sigma,s_i,BB):
    temp=x
    if(sigma==1):
        x-=fixed_shift(y,s_i,BB)
        y+=fixed_shift(temp,s_i,BB)
    else:
        x+=fixed_shift(y,s_i,BB)
        y-=fixed_shift(temp,s_i,BB)
    return x,y


def print_xy(x,y,BB=16):
    float_x,float_y=(fixed2float(x,BB),fixed2float(y,BB))
    print("x= %.10f y= %.10f"%(float_x,float_y))
    print("x= %s y= %s"%(print_bin(x,BB),print_bin(y,BB)))
    print("x= %s y= %s"%(hex(x),hex(y)))
        

    
if __name__=="__main__":
    BB=16
    B=0
    L=4
    if len(sys.argv):
        theta=float(sys.argv[1])
        theta=float2fixed(theta,BB)

    print("theta: %f"%(fixed2float(theta,BB)))
    print("theta: %s"%print_bin(theta,BB))

    theta_H=theta &  (2**(BB-L)-1)
    theta_L=theta & ~(2**(BB-L)-1)    

    print("theta_L: %f "%fixed2float(theta_L,BB))
    print("theta_L: %s "%print_bin(theta_L,BB))
    print("theta_H: %f "%fixed2float(theta_H,BB))
    print("theta_H: %s "%print_bin(theta_H,BB))

    sigma_L=fixed2bbr1(fixed2binArr(theta_L,BB))
    
    print(sigma_L)
    
    K=K_TABLE[0]
    x=float2fixed(K,BB)
    y=0
    print_xy(x,y,BB)

    p=5
    nn=kk[(BB,p)]
    print(nn)
    for i in range(0,L):
        sigma=sigma_L[i]
        for n in nn[i][:]:
            if n==0:
                break
            else:
                print(n)
                s_i=n
                print("s_i: %d"%s_i)
                x,y=S_op(x,y,sigma,s_i,BB)
                print_xy(x,y,BB)
                print("")
                
    theta_H-=float2fixed(1/2**L,BB)
    sigma_H=fixed2bbr(theta_H,BB-L+1)
    sigma_H_arr=fixed2binArr(sigma_H,BB-L+1)
    
    print(sigma_H_arr)

    s_i=L
    for sigma in sigma_H_arr:
        x,y=S_op(x,y,sigma,s_i,BB)
        s_i+=1
        print_xy(x,y,BB)
        print("")    

    theta=fixed2float(theta,BB)
    print(y/x)
    print(np.tan(theta))
    print(theta)
    print(BB)

