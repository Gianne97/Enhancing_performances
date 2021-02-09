def float2fixed(x,BB):
    fixed_x=0
    if x<0.0:
        x=1+x
        fixed_x|=2**(BB-1)
    x=int(x*2**(BB-1))
    fixed_x|=x
    return fixed_x

def fixed2float(x,BB):
    xx=0.0
    shifter=2**(BB-1)
    if(x&shifter):
        xx-=1.0
    shifter=shifter>>1
    for i in range(0,BB-1):
        if(x&shifter):
            xx+=1/2**(i+1)
        shifter=shifter>>1
    return xx

def fixed2binArr(x,BB):
    list1=[]
    shifter=2**(BB-1)
    for i in range(0,BB-1):
        if(x&shifter):
            list1.append(1)
        else:
            list1.append(0)
        shifter=shifter>>1
    return list1

def float2bbr(x,BB):
    bbr=0
    if(x>=0.0):
        bbr|=2**(BB-1)
        xx=int(x*2**(BB))>>1
    else:
        x+=1.0
        xx=int(x*2**(BB))
        xx=xx>>1
    bbr|=xx
    return bbr

def binStr2float(ss,BB):
    x=0.0
    if ss[0]=='1':
        x-=1.0
    for i in range(1,len(ss)):
        if ss[i]=='1':
            x+=1/2**i
    return x


def print_bin(x,BB):
    shifter=2**(BB-1)
    ss=""
    for i in range(0,BB):
        if(x&shifter):
            ss+='1'
        else:
            ss+='0'
        shifter=shifter>>1
    return ss

