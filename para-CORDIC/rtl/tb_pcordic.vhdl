library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_pcordic is
  generic(
    B    :   integer := 24;
    L : integer := 7
    );
end entity tb_pcordic;

architecture beh of tb_pcordic is
  constant clk_period : time := 10 ns;
  constant N_periods: integer:= 7;
  signal clk: std_logic;

  signal theta : signed(0 to B-1);
  signal x_o : signed(0 to B-1);
  signal y_o : signed(0 to B-1);

  component pcordic is
    generic(
      B    :   integer := 16;
      L    :   integer := 4
    );
    port(
      clk : in std_logic;
      theta : in signed(0 to B-1);
      x_o : out signed(0 to B-1);
      y_o : out signed(0 to B-1)
    );
  end component pcordic;     

begin

  dut: entity work.pcordic
    generic map(B=>B,L=>L)
    port map (clk=>clk,theta=>theta,x_o=>x_o,y_o=>y_o);
    
  stimul: process
  begin
	theta<="100110110111100000010100";
	wait for clk_period;
	theta<="101111001111101010110101";
	wait for clk_period;
	theta<="110011011011110000001010";
	wait for clk_period;
	theta<="000000010100011110101110";
	wait for clk_period;
	theta<="001100100100001111110101";
	wait for clk_period;
	theta<="010000110000010101001010";
	wait for clk_period;
	theta<="001100100100001111110101";
	wait for clk_period;

	wait;
  end process stimul; 
    
  clkgen : process      
  begin
    for i in 1 to N_periods loop
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
    --report "clk=" & std_logic'image(clk); 
    for i in 0 to B-1 loop
	report "theta(" &  integer'image(i) &")="& std_logic'image(theta(i));
    end loop;
    for i in 0 to B-1 loop
	report "x_o(" &  integer'image(i) &")="& std_logic'image(x_o(i));
    end loop;
    for i in 0 to B-1 loop
      report "y_o(" &  integer'image(i) &")="& std_logic'image(y_o(i));
    end loop;
  end if;
  end process print;

end architecture beh;         
