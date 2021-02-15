import sys
import math
import matplotlib.pyplot as plt
from bin_conv import *

data = sys.stdin.read()
_lines = list()
a = 0
b = 0

for c in data:
    b = b + 1
    if c == '\n':
        _lines.append(data[a:b-1])
        a = b

#the first 2 lines are not needed
lines = _lines[2:]
thetas = list()
sins = list()
coss = list()

for i in range(100):
    B = len(lines[i*3][6:])
    thetas.append(binStr2float(lines[i*3][6:], B))
    coss.append(binStr2float(lines[i*3+1][4:], B))
    sins.append(binStr2float(lines[i*3+2][4:], B))


with open("paraCordicResults_" + str(B) + ".txt","w") as f:
    f.write("theta;cos(theta);sin(theta)\n")
    for t,c,s in zip(thetas, coss, sins):
        f.write(str(t) + ';' + str(c) + ';' + str(s) + "\n")

'''
errors_sin= list()
errors_cos= list()
for t,c,s in zip(thetas, coss, sins):
    errors_cos.append(abs((math.cos(t) - c))*100)
    errors_sin.append(abs((math.sin(t) - s))*100)

print("Errors:")
print(thetas)
print(errors_cos)
print(errors_sin)

plt.plot(thetas, errors_cos,label='error cos')
plt.plot(thetas, errors_sin,label='error sin')
plt.xlabel('input angle in rad')
plt.ylabel('error in %')
plt.grid()
plt.legend()
plt.savefig("errors_fpax_"+str(B))
'''








