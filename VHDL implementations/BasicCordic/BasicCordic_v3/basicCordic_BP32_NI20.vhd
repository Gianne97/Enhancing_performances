library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.numeric_std.all;
    use IEEE.fixed_float_types.all;
    use IEEE.fixed_pkg.all;
    
entity basic_cordic is
    GENERIC (
        NMB_ITERATIONS  :   integer := 20;
        PRECISION_FP    :   integer := 31
    );
    
port (
        angle_i : in sfixed (1 downto - PRECISION_FP);
        start_i : in std_logic;
        clock_i : in std_logic;
        sin_o : out sfixed (1 downto - PRECISION_FP);
        cos_o : out sfixed (1 downto - PRECISION_FP);
        rdy_o : out std_logic);
    end basic_cordic;
    
architecture behavior of basic_cordic is
    type rotAngles is array (0 to 19) of sfixed(1 downto - PRECISION_FP);
    constant LUTangles : rotAngles := (
		to_sfixed(0.785398163397448, 1, - PRECISION_FP),
		to_sfixed(0.463647609000806, 1, - PRECISION_FP),
		to_sfixed(0.244978663126864, 1, - PRECISION_FP),
		to_sfixed(0.124354994546761, 1, - PRECISION_FP),
		to_sfixed(0.062418809995957, 1, - PRECISION_FP),
		to_sfixed(0.031239833430268, 1, - PRECISION_FP),
		to_sfixed(0.015623728620477, 1, - PRECISION_FP),
		to_sfixed(0.007812341060101, 1, - PRECISION_FP),
		to_sfixed(0.003906230131967, 1, - PRECISION_FP),
		to_sfixed(0.001953122516479, 1, - PRECISION_FP),
		to_sfixed(0.000976562189559, 1, - PRECISION_FP),
		to_sfixed(0.000488281211195, 1, - PRECISION_FP),
		to_sfixed(0.000244140620149, 1, - PRECISION_FP),
		to_sfixed(0.000122070311894, 1, - PRECISION_FP),
		to_sfixed(0.000061035156174, 1, - PRECISION_FP),
		to_sfixed(0.000030517578116, 1, - PRECISION_FP),
		to_sfixed(0.000015258789061, 1, - PRECISION_FP),
		to_sfixed(0.000007629394531, 1, - PRECISION_FP),
		to_sfixed(0.000003814697266, 1, - PRECISION_FP),
		to_sfixed(0.000001907348633, 1, - PRECISION_FP)
);

    type mul_factor is array (0 to 19) of sfixed(1 downto - PRECISION_FP);
    constant LUT_K : mul_factor := (
		to_sfixed(0.707106781186547, 1, - PRECISION_FP),
		to_sfixed(0.632455532033676, 1, - PRECISION_FP),
		to_sfixed(0.613571991077896, 1, - PRECISION_FP),
		to_sfixed(0.608833912517752, 1, - PRECISION_FP),
		to_sfixed(0.607648256256168, 1, - PRECISION_FP),
		to_sfixed(0.607351770141296, 1, - PRECISION_FP),
		to_sfixed(0.607277644093526, 1, - PRECISION_FP),
		to_sfixed(0.607259112298893, 1, - PRECISION_FP),
		to_sfixed(0.607254479332562, 1, - PRECISION_FP),
		to_sfixed(0.607253321089875, 1, - PRECISION_FP),
		to_sfixed(0.607253031529134, 1, - PRECISION_FP),
		to_sfixed(0.607252959138945, 1, - PRECISION_FP),
		to_sfixed(0.607252941041397, 1, - PRECISION_FP),
		to_sfixed(0.607252936517010, 1, - PRECISION_FP),
		to_sfixed(0.607252935385914, 1, - PRECISION_FP),
		to_sfixed(0.607252935103139, 1, - PRECISION_FP),
		to_sfixed(0.607252935032446, 1, - PRECISION_FP),
		to_sfixed(0.607252935014772, 1, - PRECISION_FP),
		to_sfixed(0.607252935010354, 1, - PRECISION_FP),
		to_sfixed(0.607252935009249, 1, - PRECISION_FP)
);

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