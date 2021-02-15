import math

with open("thetas", "w") as f:
    #f.write(np.array_str(np.arange(-math.pi/4, math.pi/4, math.pi/200) ,max_line_width=1000000))
    f.write("[")
    for i in range(100):
        f.write(str((-math.pi/4) + i * (math.pi/200)) + ',')

    f.write("]")


with open("thetas2", "w") as f:
    #f.write(np.array_str(np.arange(-math.pi/4, math.pi/4, math.pi/200) ,max_line_width=1000000))
    for i in range(100):
        f.write(str((-math.pi/4) + i * (math.pi/200)) + ' ')

