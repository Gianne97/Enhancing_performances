--  This is the implementation of the non approximated cordic algorithm
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.fixed_float_types.all;
use IEEE.fixed_pkg.all;

entity basic_cordic is
GENERIC (
            NMB_ITERATIONS  :   integer := 15;   -- 15 is the maximum right now
            PRECISION_FP    :   integer := 9    -- gives the number which are used on the right side of the fixed point
);
port (
    angle_i : in sfixed (7 downto -2); -- the input angle in grad
    start_i : in std_logic; -- if transitioned from 0 -> 1 the algorithm starts, needs to be 1 until ready is asserted
    clock_i : in std_logic; -- the input clock
    sin_o : out sfixed (1 downto -PRECISION_FP);
    cos_o : out sfixed (1 downto -PRECISION_FP);
    rdy_o : out std_logic); -- is set to 1 if the results are ready
end basic_cordic;

architecture behavior of basic_cordic is
    -- look up table for the atan values of 2⁻i
    type rotAngles is array (0 to (14)) of sfixed(7 downto -PRECISION_FP);
    constant LUTangles : rotAngles := (
        to_sfixed(45, 7, -PRECISION_FP),
        to_sfixed(26.56505, 7, -PRECISION_FP),
        to_sfixed(14.03624, 7, -PRECISION_FP),
        to_sfixed(7.12502, 7, -PRECISION_FP),
        to_sfixed(3.57633, 7, -PRECISION_FP),
        to_sfixed(1.78991, 7, -PRECISION_FP),
        to_sfixed(0.89517, 7, -PRECISION_FP),
        to_sfixed(0.44761, 7, -PRECISION_FP),
        to_sfixed(0.22381, 7, -PRECISION_FP),
        to_sfixed(0.11190, 7, -PRECISION_FP),
        to_sfixed(0.05595, 7, -PRECISION_FP),
        to_sfixed(0.02798, 7, -PRECISION_FP),
        to_sfixed(0.01398, 7, -PRECISION_FP),
        to_sfixed(0.00699, 7, -PRECISION_FP),
        to_sfixed(0.00349, 7, -PRECISION_FP)
    );
begin

    algorithm : process(clock_i)
        variable state : integer := 0;
        variable z : sfixed (7 downto -PRECISION_FP);
        variable x : sfixed (1 downto -PRECISION_FP);
        variable y : sfixed (1 downto -PRECISION_FP);
        variable bufx : sfixed (1 downto -PRECISION_FP);
        variable bufy : sfixed (1 downto -PRECISION_FP);
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
                            x := to_sfixed(0.6072, 1, -PRECISION_FP);
                            y := x;
                            z := resize(arg => z - LUTangles(0), size_res => z);
                        elsif z < 0 then
                            x := to_sfixed(0.6072, 1, -PRECISION_FP);
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
                -- inactiva state, set all outputs to their inital values
                rdy_o <= '0';
                state := 0;
                sin_o <= to_sfixed(0.6072, 1, -PRECISION_FP);
                cos_o <= to_sfixed(0, 1, -PRECISION_FP);        
            end if;
        end if;
    end process algorithm;
end behavior;
