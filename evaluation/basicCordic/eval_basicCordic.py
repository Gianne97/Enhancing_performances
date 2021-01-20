import sys
import math
import matplotlib.pyplot as plt
'''
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

for i in range(7):
    B = len(lines[i*3][6:])
    thetas.append(binStr2float(lines[i*3][6:], B))
    coss.append(binStr2float(lines[i*3+1][4:], B))
    sins.append(binStr2float(lines[i*3+2][4:], B))

'''
thetas = [-0.785398,-0.523599,-0.392699,0.01,0.392699,0.523599,0.392699]
coss_32 = [1.414213790/2, 1.7320505855/2, 1.8477591/2, 1.999899999/2, 1.8477591/2,1.7320505855/2,1.8477591/2]
sins_32 = [-1.41421333/2, -0.5, -0.765366711/2, 0.019999967/2, 0.765366711/2, 0.5, 0.7653667/2]


#calc the real values for the sins and the error
errors_sin= list()
errors_cos= list()
for t,c,s in zip(thetas, coss_32, sins_32):
    errors_cos.append(abs((math.cos(t) - c))*100)
    errors_sin.append(abs((math.sin(t) - s))*100)

plt.figure(figsize=(9,8))
plt.plot(thetas, errors_cos,label='error cos')
plt.plot(thetas, errors_sin,label='error sin')
plt.xlabel('input angle in rad')
plt.ylabel('error in %')
plt.grid()
plt.legend()
plt.savefig("errors_bCordic"+str(32))

coss_16 = [0.7071228,0.86608886,0.923797,0.9999084,0.92379760, 0.866088867,0.923797]
sins_16 = [-0.7071228, -0.5, -0.38269042, 0.010040283, 0.38269042, 0.5, 0.3826904]


#calc the real values for the sins and the error
errors_sin= list()
errors_cos= list()
for t,c,s in zip(thetas, coss_16, sins_16):
    errors_cos.append(abs((math.cos(t) - c))*100)
    errors_sin.append(abs((math.sin(t) - s))*100)

plt.figure(figsize=(9,8))
plt.plot(thetas, errors_cos,label='error cos')
plt.plot(thetas, errors_sin,label='error sin')
plt.xlabel('input angle in rad')
plt.ylabel('error in %')
plt.grid()
plt.legend()
plt.savefig("errors_bCordic"+str(16))


