import math
import numpy as np
import sys

#specify the number of bits WITHOUT the sign bit e.g. 32
numberOfBits = int(sys.argv[1])

#specify the numbe of iterations for the cordic basic algorithm
numberOfIterations = int(sys.argv[2]) #max up to 50

#specify the input angle in radians
input_angles = [-0.7853981633974483,-0.7696902001294993,-0.7539822368615503,-0.7382742735936014,-0.7225663103256524,-0.7068583470577035,-0.6911503837897545,-0.6754424205218055,-0.6597344572538566,-0.6440264939859076,-0.6283185307179586,-0.6126105674500096,-0.5969026041820606,-0.5811946409141118,-0.5654866776461627,-0.5497787143782138,-0.5340707511102648,-0.5183627878423158,-0.5026548245743669,-0.4869468613064179,-0.47123889803846897,-0.45553093477052,-0.439822971502571,-0.42411500823462206,-0.40840704496667307,-0.3926990816987241,-0.37699111843077515,-0.36128315516282616,-0.3455751918948772,-0.32986722862692824,-0.31415926535897926,-0.2984513020910303,-0.28274333882308134,-0.26703537555513235,-0.25132741228718336,-0.23561944901923448,-0.2199114857512855,-0.2042035224833365,-0.18849555921538752,-0.17278759594743853,-0.15707963267948966,-0.14137166941154067,-0.12566370614359168,-0.10995574287564269,-0.0942477796076937,-0.07853981633974472,-0.06283185307179584,-0.04712388980384685,-0.031415926535897865,-0.015707963267948877,1.1102230246251565e-16,0.015707963267948988,0.031415926535897976,0.04712388980384696,0.06283185307179595,0.07853981633974494,0.09424777960769393,0.1099557428756428,0.1256637061435918,0.14137166941154078,0.15707963267948977,0.17278759594743875,0.18849555921538763,0.20420352248333662,0.2199114857512856,0.23561944901923448,0.2513274122871836,0.26703537555513246,0.28274333882308156,0.29845130209103043,0.3141592653589793,0.3298672286269284,0.3455751918948773,0.3612831551628264,0.37699111843077526,0.39269908169872414,0.40840704496667324,0.4241150082346221,0.4398229715025712,0.4555309347705201,0.47123889803846897,0.48694686130641807,0.5026548245743669,0.518362787842316,0.5340707511102649,0.549778714378214,0.5654866776461629,0.5811946409141118,0.5969026041820609,0.6126105674500097,0.6283185307179588,0.6440264939859077,0.6597344572538566,0.6754424205218057,0.6911503837897546,0.7068583470577037,0.7225663103256525,0.7382742735936014,0.7539822368615505,0.7696902001294994]

def printIncludes():
    includes="""library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.numeric_std.all;
    use IEEE.fixed_float_types.all;
    use IEEE.fixed_pkg.all;
    """
    print(includes)

def printEntity(nmbBits, nmbIterations):
    entity_dec="""entity basic_cordic is
    GENERIC (
        NMB_ITERATIONS  :   integer := """ + str(nmbIterations) + """;
        PRECISION_FP    :   integer := """ + str(nmbBits - 1) + """
    );
    """
    print(entity_dec)

    port="""port (
        angle_i : in sfixed (1 downto - PRECISION_FP);
        start_i : in std_logic;
        clock_i : in std_logic;
        sin_o : out sfixed (1 downto - PRECISION_FP);
        cos_o : out sfixed (1 downto - PRECISION_FP);
        rdy_o : out std_logic);
    end basic_cordic;
    """
    print(port)

def printArchitectureDeclarations(nmbBits, nmbIterations):
    archi = """architecture behavior of basic_cordic is
    type rotAngles is array (0 to """ + str(nmbIterations - 1) + """) of sfixed(1 downto - PRECISION_FP);
    constant LUTangles : rotAngles := ("""
    print(archi)
    for i in range(nmbIterations):
        bufferStr = "{:.15f}".format(math.atan(2**(-i)))
        if i < nmbIterations - 1:
            print("\t\tto_sfixed(" + bufferStr + ", 1, - PRECISION_FP),")
        else:
            print("\t\tto_sfixed(" + bufferStr + ", 1, - PRECISION_FP)")
    
    print(");")
    archi2 = """
    type mul_factor is array (0 to """ + str(nmbIterations - 1) + """) of sfixed(1 downto - PRECISION_FP);
    constant LUT_K : mul_factor := ("""
    print(archi2)
    max_value = 27
    i = np.arange(0, max_value, 1)
    nth = 1/np.sqrt(1 + (1/2)**(2*i))
    res = np.cumprod(nth)
    for i in range(nmbIterations):
        if i < max_value-1:
            bufferStr = "{:.15f}".format(res[i])
        else:
            bufferStr = "{:.15f}".format(res[max_value-1])
        if i < nmbIterations - 1:
            print("\t\tto_sfixed(" + bufferStr + ", 1, - PRECISION_FP),")
        else:
            print("\t\tto_sfixed(" + bufferStr + ", 1, - PRECISION_FP)")
    print(");")

def printArchitecture():
    archi = """
begin
    algorithm : process(clock_i)
        variable state : integer := 0;
        variable z : sfixed (1 downto - PRECISION_FP);
        variable x : sfixed (1 downto - PRECISION_FP);
        variable y : sfixed (1 downto - PRECISION_FP);
        variable bufx : sfixed (1 downto - PRECISION_FP);
        variable bufy : sfixed (1 downto - PRECISION_FP);
    begin
        if rising_edge(clock_i) then
            if start_i = '1' then
                if state >= NMB_ITERATIONS then
                    -- finished with the calculation
                    sin_o <= y;
                    cos_o <= x;
                    rdy_o <= '1';
                else
                    -- perform the cordic in rotation mode to calculate sin and cos
                    if state = 0 then
                        -- if the input angle is negativ, make it positive and save the sign
                        z := resize(arg => angle_i, size_res => z);
                        -- perfrom the first rotation/iteration
                        if z > 0 then
                            -- input angle is positive
                            x := LUT_K(NMB_ITERATIONS-1);
                            y := x;
                            z := resize(arg => z - LUTangles(0), size_res => z);
                        elsif z < 0 then
                            x := LUT_K(NMB_ITERATIONS-1);
                            y := resize(-x, 1, -PRECISION_FP);
                            z := resize(arg => z + LUTangles(0), size_res => z);
                        else
                            -- input was 0, therefore stop the algorithm right away
                            state := NMB_ITERATIONS;
                            x := to_sfixed(1, 1, -PRECISION_FP);
                            y := to_sfixed(0, 1, -PRECISION_FP);
                        end if;
                    else
                        -- perfrom iterations
                        if z > 0 then
                            bufx := x;
                            if y < 0 then
                                bufy := resize(arg => -y, size_res => bufy);
                                x := resize(arg => (x + (bufy srl state)), size_res => x);
                            else
                                x := resize(arg => (x - (y srl state)), size_res => x);
                            end if;
                            if bufx < 0 then
                                bufx := resize(arg => -bufx, size_res => bufx);
                                y := resize(arg => (y - (bufx srl state)), size_res => y);
                            else
                                y := resize(arg => (y + (bufx srl state)), size_res => y);
                            end if;
                            z := resize(arg => z - LUTangles(state), size_res => z);
                        else
                            bufx := x;
                            if y < 0 then
                                bufy := resize(arg => -y, size_res => bufy);
                                x := resize(arg => (x - (bufy srl state)), size_res => x);
                            else
                                x := resize(arg => (x + (y srl state)), size_res => x);
                            end if;
                            if bufx < 0 then
                                bufx := resize(arg => -bufx, size_res => bufx);
                                y := resize(arg => (y + (bufx srl state)), size_res => y);
                            else
                                y := resize(arg => (y - (bufx srl state)), size_res => y);
                            end if;
                            z := resize(arg => z + LUTangles(state), size_res => z);
                        end if;
                    end if;
                    sin_o <= y;
                    cos_o <= x;
                    state := state + 1;
                end if;
            else
                -- inactive state, set all outputs to their inital values
                rdy_o <= '0';
                state := 0;
                sin_o <= LUT_K(NMB_ITERATIONS-1);
                cos_o <= to_sfixed(0, 1, -PRECISION_FP);        
            end if;
        end if;
    end process algorithm;
end behavior;
"""
    print(archi)

#printIncludes()
#printEntity(numberOfBits, numberOfIterations)
#printArchitectureDeclarations(numberOfBits, numberOfIterations)
#printArchitecture()

def printIncludes():
    includes="""library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.numeric_std.all;
    use IEEE.fixed_float_types.all;
    use IEEE.fixed_pkg.all;
    use STD.textio.all;
    use ieee.std_logic_textio.all;
    use std.env.finish;
    """
    print(includes)

def printEntity(nmbBits, nmbIterations):
    entity_dec="""entity testbench is
    end testbench;
    
    architecture tb of testbench is
    
    component basic_cordic is
    GENERIC (
        NMB_ITERATIONS  :   integer := """ + str(nmbIterations) + """;
        PRECISION_FP    :   integer := """ + str(nmbBits - 1) + """
    );
    """
    print(entity_dec)
    
    port="""port (
        angle_i : in sfixed (1 downto - PRECISION_FP);
        start_i : in std_logic;
        clock_i : in std_logic;
        sin_o : out sfixed (1 downto - PRECISION_FP);
        cos_o : out sfixed (1 downto - PRECISION_FP);
        rdy_o : out std_logic);
    end component;
    """
    print(port)
    
    component="""component clkGen is
    port (clk : out std_logic);
    end component;
    """
    print(component)
    
    signals="""signal sig_clk, sig_start, sig_rdy: std_logic;
    signal sin_out, cos_out : sfixed (1 downto -""" + str(nmbBits - 1) + """);
    signal sig_in : sfixed (1 downto -""" + str(nmbBits - 1) + """);
    """
    print(signals)
    
def printarchitecture(nmbBits, nmbIterations, input_angle):
    archi = """
begin
       
    -- connect DUT with tb signals
    DUT:
        basic_cordic
        generic map(NMB_ITERATIONS => """ + str(nmbIterations) + """, PRECISION_FP => """ + str(nmbBits - 1) + """)
        port map(
        angle_i => sig_in,
        start_i => sig_start,
        clock_i => sig_clk,
        rdy_o => sig_rdy,
        sin_o => sin_out,
        cos_o => cos_out);
            
    -- clockgenerator
    mClkGen : clkGen port map(
        clk => sig_clk
    );
        
    -- apply a test angle as input
    stimuli: process
    begin"""
    print(archi)
    for th in input_angles:
        print("        sig_in <= to_sfixed(" + str(th) + ", 1, - " + str(nmbBits - 1) + ");")
        print("""        sig_start <= '1';
        wait until sig_rdy = '1';
        sig_start <= '0';
        std.textio.write(std.textio.output, to_string(cos_out) & LF);
        std.textio.write(std.textio.output, to_string(sin_out) & LF);
        wait for 20 ns;""")



        
    print("""   finish;
    end process stimuli;
end;
""")
    
printIncludes()
printEntity(numberOfBits, numberOfIterations)
printarchitecture(numberOfBits, numberOfIterations, input_angles)
