import math
import numpy as np

#specify the number of bits WITHOUT the sign bit
numberOfBits = 16

#specify the numbe of iterations for the cordic basic algorithm
numberOfIterations = 40 #max up to 50

#specify the input angle in radians
input_angle = 0.15123
input_angles = [-0.785398,-0.523599,-0.392699,0.01,0.392699,0.523599,0.392699]

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
    begin
        sig_in <= to_sfixed(""" + str(input_angles[0]) + """, 1, - """ + str(nmbBits - 1) + """);
        sig_start <= '1';
        wait until sig_rdy = '1';
        sig_start <= '0';
        wait for 30 ns;
        sig_in <= to_sfixed(""" + str(input_angles[1]) + """, 1, - """ + str(nmbBits - 1) + """);
        sig_start <= '1';
        wait until sig_rdy = '1';
        sig_start <= '0';
        wait for 30 ns;
        sig_in <= to_sfixed(""" + str(input_angles[2]) + """, 1, - """ + str(nmbBits - 1) + """);
        sig_start <= '1';
        wait until sig_rdy = '1';
        sig_start <= '0';
        wait for 30 ns;
        sig_in <= to_sfixed(""" + str(input_angles[3]) + """, 1, - """ + str(nmbBits - 1) + """);
        sig_start <= '1';
        wait until sig_rdy = '1';
        sig_start <= '0';
        wait for 30 ns;
        sig_in <= to_sfixed(""" + str(input_angles[4]) + """, 1, - """ + str(nmbBits - 1) + """);
        sig_start <= '1';
        wait until sig_rdy = '1';
        sig_start <= '0';
        wait for 30 ns;
        sig_in <= to_sfixed(""" + str(input_angles[5]) + """, 1, - """ + str(nmbBits - 1) + """);
        sig_start <= '1';
        wait until sig_rdy = '1';
        sig_start <= '0';
        wait for 30 ns;
        sig_in <= to_sfixed(""" + str(input_angles[6]) + """, 1, - """ + str(nmbBits - 1) + """);
        sig_start <= '1';
        wait until sig_rdy = '1';
        
    end process stimuli;
        
end;
"""
    print(archi)
    
printIncludes()
printEntity(numberOfBits, numberOfIterations)
printarchitecture(numberOfBits, numberOfIterations, input_angle)
