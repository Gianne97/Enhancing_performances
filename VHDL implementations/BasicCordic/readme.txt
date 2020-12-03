GENERAL:

The implementation of the basic cordic is in the file basicCordic.vhd.
The module takes an input angle in degrees from -90 to 90. And outputs the sinus and cosinus of the given angle. The number of iterations can be specified using a generic statement (maximum up to 15 iterations). Internally fixed point calculations are used. This is basically integer arithemtic with an offset. The ieee library supports this since 2008. The number of bits after the comma (on the left side) can also be specified with an generic statement.

HOW TO BUILD THE TESTBENCH:

The free software ghdl was used to elaborate and simulate the basic cordic core with a simple testbench where the input angle can be specified. The testbench generates a wafeform diagrame which can be looked at with gtkwave.

building process: 
enter those commands in a terminal:

make
make run




