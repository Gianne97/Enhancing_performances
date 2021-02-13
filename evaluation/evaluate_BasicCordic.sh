#!/usr/bin/bash

set -e
echo "starting evaluation"


cd ../VHDL_implementations/BasicCordic/
#for each B calcualte different sin/cos values and save the value in a file

rm -f basicCordic.vhd
rm -f tb_basicCordic.vhd
python3 create_BC.py 16 10 > basicCordic.vhd
python3 create_BC_TB.py 16 10 > tb_basicCordic.vhd
make run | (cd ../../evaluation; python3 evalBasicCordic.py 16 10)

rm -f basicCordic.vhd
rm -f tb_basicCordic.vhd
python3 create_BC.py 16 14 > basicCordic.vhd
python3 create_BC_TB.py 16 14 > tb_basicCordic.vhd
make run | (cd ../../evaluation; python3 evalBasicCordic.py 16 14)

rm -f basicCordic.vhd
rm -f tb_basicCordic.vhd
python3 create_BC.py 24 10 > basicCordic.vhd
python3 create_BC_TB.py 24 10 > tb_basicCordic.vhd
make run | (cd ../../evaluation; python3 evalBasicCordic.py 24 10)


rm -f basicCordic.vhd
rm -f tb_basicCordic.vhd
python3 create_BC.py 24 15 > basicCordic.vhd
python3 create_BC_TB.py 24 15 > tb_basicCordic.vhd
make run | (cd ../../evaluation; python3 evalBasicCordic.py 24 15)


rm -f basicCordic.vhd
rm -f tb_basicCordic.vhd
python3 create_BC.py 24 22 > basicCordic.vhd
python3 create_BC_TB.py 24 22 > tb_basicCordic.vhd
make run | (cd ../../evaluation; python3 evalBasicCordic.py 24 22)


rm -f basicCordic.vhd
rm -f tb_basicCordic.vhd
python3 create_BC.py 32 10 > basicCordic.vhd
python3 create_BC_TB.py 32 10 > tb_basicCordic.vhd
make run | (cd ../../evaluation; python3 evalBasicCordic.py 32 10)

rm -f basicCordic.vhd
rm -f tb_basicCordic.vhd
python3 create_BC.py 32 15 > basicCordic.vhd
python3 create_BC_TB.py 32 15 > tb_basicCordic.vhd
make run | (cd ../../evaluation; python3 evalBasicCordic.py 32 15)


rm -f basicCordic.vhd
rm -f tb_basicCordic.vhd
python3 create_BC.py 32 20 > basicCordic.vhd
python3 create_BC_TB.py 32 20 > tb_basicCordic.vhd
make run | (cd ../../evaluation; python3 evalBasicCordic.py 32 20)


rm -f basicCordic.vhd
rm -f tb_basicCordic.vhd
python3 create_BC.py 32 25 > basicCordic.vhd
python3 create_BC_TB.py 32 25 > tb_basicCordic.vhd
make run | (cd ../../evaluation; python3 evalBasicCordic.py 32 25)

rm -f basicCordic.vhd
rm -f tb_basicCordic.vhd
python3 create_BC.py 32 30 > basicCordic.vhd
python3 create_BC_TB.py 32 30 > tb_basicCordic.vhd
make run | (cd ../../evaluation; python3 evalBasicCordic.py 32 30)
