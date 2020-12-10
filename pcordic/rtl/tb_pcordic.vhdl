library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity tb_pcordic is
    generic(PRECISION_FP    :   integer := 16);
end entity tb_pcordic;

architecture beh of tb_pcordic is
  constant clk_period : time := 10 ns;
  constant N_periods: integer:= 1;
  signal clk: std_logic;

  constant NMB_ITERATIONS  :   integer := 15;   
  --constant PRECISION_FP    :   integer := 9;

  signal theta : signed(0 to PRECISION_FP-1);    
  signal x_o : signed(0 to PRECISION_FP-1);
  signal y_o : signed(0 to PRECISION_FP-1);

  component pcordic is
    generic(
      PRECISION_FP    :   integer := 9
    );
    port(
      clk : in std_logic;
      theta : in signed(0 to PRECISION_FP-1);    
      x_o : out signed(0 to PRECISION_FP-1);
      y_o : out signed(0 to PRECISION_FP-1)
    );
  end component pcordic;     


begin

  dut: entity work.pcordic
    generic map(PRECISION_FP=>PRECISION_FP)
    port map (clk=>clk,theta=>theta,x_o=>x_o,y_o=>y_o);
    
  stimul: process
  begin
    theta<=(others => '0');

    wait;
  end process stimul; 
    
  clkgen : process      
  begin
    for i in 0 to N_periods loop
      clk <= '0';
      wait for clk_period/2;  
      clk <= '1';
      wait for clk_period/2;
    end loop;
    wait;
    
  end process clkgen;

 print: process(clk)
  begin
    if(clk='1' and clk'event) then
    report "clk=" & std_logic'image(clk); 

    for i in 0 to PRECISION_FP-1 loop
	report "theta(" &  integer'image(i) &")="& std_logic'image(theta(i));
    end loop;
    for i in 0 to PRECISION_FP-1 loop
	report "x_o(" &  integer'image(i) &")="& std_logic'image(x_o(i));
    end loop;
    for i in 0 to PRECISION_FP-1 loop
      report "y_o(" &  integer'image(i) &")="& std_logic'image(y_o(i));
    end loop;
  end if;
  end process print;


  
  
end architecture beh;         
