#!/usr/bin/bash

set -e
echo "starting evaluation"



cd ../para-CORDIC/rtl/
#for each B calcualte different sin/cos values and save the value in a file
for _B in 16 24 32 54 64
do
    make clean
    #make B=$_B theta="[-0.785398,-0.523599,-0.392699,0,0.785398,0.523599,0.392699]"
    make B=$_B theta="[-0.785398,-0.523599,-0.392699,0.01,0.392699,0.523599,0.392699]"
    #cd ../../
    make sim B=$_B | (cd ../../evaluation; python3 eval.py)

done
