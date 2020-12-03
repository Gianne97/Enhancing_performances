import math

angle = -55

x = 1/1.647
y = 0
z = angle

for i in range(16):
    buf = x
    if z > 0:
        x = x - y*2**(-i)
        y = y + buf*2**(-i)
        z = z - math.atan(2**(-i))*360/(2*math.pi)

    else :
        x = x + y*2**(-i)
        y = y - buf*2**(-i)
        z = z + math.atan(2**(-i))*360/(2*math.pi)

    print("z: " + str(z))
    #print(math.atan(2**(-i))*360/(2*math.pi))
    
