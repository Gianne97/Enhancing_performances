import sys
import scipy.io

if len(sys.argv)==2:
    file_name=sys.argv[1]
    
mat=scipy.io.loadmat(file_name)

print(mat)
