import re
import sys

if __name__=="__main__":
    if(len(sys.argv)==2):
       f=open(sys.argv[1])
    else:
       f=open("/dev/stdin")
       
    while True:
        line=f.readline()
        if not line:
            break
        mm=re.search("\w+\.vhdl:\d+:\d+:@(\d+)ns:\(report note\): ([a-zA-Z_]+)\((\w+)\)='([01])'\n",line)
        if mm:
            #print(line)
            ind=mm.group(3)
            var_name=mm.group(2)
            bit_val=mm.group(4)
            if(ind=="0"):
                print("\n%s="%(var_name),end="")
            print(bit_val,end="")
            continue
        mm=re.search("\w+\.vhdl:\d+:\d+:@(\d+)ns:\(report note\): ([a-zA-Z_]+)='([01])'\n",line)
        if mm:
            var_name=mm.group(2)
            bit_val=mm.group(3)            
            print("\n%s=%s"%(var_name,bit_val),end="")
    print("")
            
            
