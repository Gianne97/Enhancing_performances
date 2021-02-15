library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_pcordic is
  generic(
    B    :   integer := 64;
    L : integer := 20
    );
end entity tb_pcordic;

architecture beh of tb_pcordic is
  constant clk_period : time := 10 ns;
  constant N_periods: integer:= 100;
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
	theta<="1001101101111000000100101010111011101111010010111010000000000000";
	wait for clk_period;
	theta<="1001110101111010110010101010000100110010001100001000010000000000";
	wait for clk_period;
	theta<="1001111101111101100000101001001101110101000101010110100000000000";
	wait for clk_period;
	theta<="1010000110000000001110101000010110110111111110100100100000000000";
	wait for clk_period;
	theta<="1010001110000010111100100111011111111010110111110010110000000000";
	wait for clk_period;
	theta<="1010010110000101101010100110101000111101110001000001000000000000";
	wait for clk_period;
	theta<="1010011110001000011000100101110010000000101010001111010000000000";
	wait for clk_period;
	theta<="1010100110001011000110100100111011000011100011011101100000000000";
	wait for clk_period;
	theta<="1010101110001101110100100100000100000110011100101011100000000000";
	wait for clk_period;
	theta<="1010110110010000100010100011001101001001010101111001110000000000";
	wait for clk_period;
	theta<="1010111110010011010000100010010110001100001111001000000000000000";
	wait for clk_period;
	theta<="1011000110010101111110100001011111001111001000010110010000000000";
	wait for clk_period;
	theta<="1011001110011000101100100000101000010010000001100100100000000000";
	wait for clk_period;
	theta<="1011010110011011011010011111110001010100111010110010100000000000";
	wait for clk_period;
	theta<="1011011110011110001000011110111010010111110100000001000000000000";
	wait for clk_period;
	theta<="1011100110100000110110011110000011011010101101001111000000000000";
	wait for clk_period;
	theta<="1011101110100011100100011101001100011101100110011101010000000000";
	wait for clk_period;
	theta<="1011110110100110010010011100010101100000011111101011100000000000";
	wait for clk_period;
	theta<="1011111110101001000000011011011110100011011000111001100000000000";
	wait for clk_period;
	theta<="1100000110101011101110011010100111100110010010001000000000000000";
	wait for clk_period;
	theta<="1100001110101110011100011001110000101001001011010110000000000000";
	wait for clk_period;
	theta<="1100010110110001001010011000111001101100000100100100010000000000";
	wait for clk_period;
	theta<="1100011110110011111000011000000010101110111101110010100000000000";
	wait for clk_period;
	theta<="1100100110110110100110010111001011110001110111000000100000000000";
	wait for clk_period;
	theta<="1100101110111001010100010110010100110100110000001111000000000000";
	wait for clk_period;
	theta<="1100110110111100000010010101011101110111101001011101000000000000";
	wait for clk_period;
	theta<="1100111110111110110000010100100110111010100010101011010000000000";
	wait for clk_period;
	theta<="1101000111000001011110010011101111111101011011111001100000000000";
	wait for clk_period;
	theta<="1101001111000100001100010010111001000000010101000111110000000000";
	wait for clk_period;
	theta<="1101010111000110111010010010000010000011001110010110000000000000";
	wait for clk_period;
	theta<="1101011111001001101000010001001011000110000111100100000000000000";
	wait for clk_period;
	theta<="1101100111001100010110010000010100001001000000110010010000000000";
	wait for clk_period;
	theta<="1101101111001111000100001111011101001011111010000000100000000000";
	wait for clk_period;
	theta<="1101110111010001110010001110100110001110110011001110110000000000";
	wait for clk_period;
	theta<="1101111111010100100000001101101111010001101100011101000000000000";
	wait for clk_period;
	theta<="1110000111010111001110001100111000010100100101101011000000000000";
	wait for clk_period;
	theta<="1110001111011001111100001100000001010111011110111001010000000000";
	wait for clk_period;
	theta<="1110010111011100101010001011001010011010011000000111100000000000";
	wait for clk_period;
	theta<="1110011111011111011000001010010011011101010001010101110000000000";
	wait for clk_period;
	theta<="1110100111100010000110001001011100100000001010100100000000000000";
	wait for clk_period;
	theta<="1110101111100100110100001000100101100011000011110010000000000000";
	wait for clk_period;
	theta<="1110110111100111100010000111101110100101111101000000010000000000";
	wait for clk_period;
	theta<="1110111111101010010000000110110111101000110110001110100000000000";
	wait for clk_period;
	theta<="1111000111101100111110000110000000101011101111011100110000000000";
	wait for clk_period;
	theta<="1111001111101111101100000101001001101110101000101011000000000000";
	wait for clk_period;
	theta<="1111010111110010011010000100010010110001100001111001010000000000";
	wait for clk_period;
	theta<="1111011111110101001000000011011011110100011011000111010000000000";
	wait for clk_period;
	theta<="1111100111110111110110000010100100110111010100010101100000000000";
	wait for clk_period;
	theta<="1111101111111010100100000001101101111010001101100011110000000000";
	wait for clk_period;
	theta<="1111110111111101010010000000110110111101000110110010000000000000";
	wait for clk_period;
	theta<="0000000000000000000000000000000000000000000000000000010000000000";
	wait for clk_period;
	theta<="0000001000000010101101111111001001000010111001001110010000000000";
	wait for clk_period;
	theta<="0000010000000101011011111110010010000101110010011100100000000000";
	wait for clk_period;
	theta<="0000011000001000001001111101011011001000101011101010110000000000";
	wait for clk_period;
	theta<="0000100000001010110111111100100100001011100100111001000000000000";
	wait for clk_period;
	theta<="0000101000001101100101111011101101001110011110000111010000000000";
	wait for clk_period;
	theta<="0000110000010000010011111010110110010001010111010101100000000000";
	wait for clk_period;
	theta<="0000111000010011000001111001111111010100010000100011100000000000";
	wait for clk_period;
	theta<="0001000000010101101111111001001000010111001001110001110000000000";
	wait for clk_period;
	theta<="0001001000011000011101111000010001011010000011000000000000000000";
	wait for clk_period;
	theta<="0001010000011011001011110111011010011100111100001110010000000000";
	wait for clk_period;
	theta<="0001011000011101111001110110100011011111110101011100100000000000";
	wait for clk_period;
	theta<="0001100000100000100111110101101100100010101110101010100000000000";
	wait for clk_period;
	theta<="0001101000100011010101110100110101100101100111111000110000000000";
	wait for clk_period;
	theta<="0001110000100110000011110011111110101000100001000111000000000000";
	wait for clk_period;
	theta<="0001111000101000110001110011000111101011011010010101000000000000";
	wait for clk_period;
	theta<="0010000000101011011111110010010000101110010011100011100000000000";
	wait for clk_period;
	theta<="0010001000101110001101110001011001110001001100110001100000000000";
	wait for clk_period;
	theta<="0010010000110000111011110000100010110100000110000000000000000000";
	wait for clk_period;
	theta<="0010011000110011101001101111101011110110111111001110000000000000";
	wait for clk_period;
	theta<="0010100000110110010111101110110100111001111000011100000000000000";
	wait for clk_period;
	theta<="0010101000111001000101101101111101111100110001101010100000000000";
	wait for clk_period;
	theta<="0010110000111011110011101101000110111111101010111000100000000000";
	wait for clk_period;
	theta<="0010111000111110100001101100010000000010100100000111000000000000";
	wait for clk_period;
	theta<="0011000001000001001111101011011001000101011101010101000000000000";
	wait for clk_period;
	theta<="0011001001000011111101101010100010001000010110100011000000000000";
	wait for clk_period;
	theta<="0011010001000110101011101001101011001011001111110001100000000000";
	wait for clk_period;
	theta<="0011011001001001011001101000110100001110001000111111100000000000";
	wait for clk_period;
	theta<="0011100001001100000111100111111101010001000010001110000000000000";
	wait for clk_period;
	theta<="0011101001001110110101100111000110010011111011011100000000000000";
	wait for clk_period;
	theta<="0011110001010001100011100110001111010110110100101010000000000000";
	wait for clk_period;
	theta<="0011111001010100010001100101011000011001101101111000100000000000";
	wait for clk_period;
	theta<="0100000001010110111111100100100001011100100111000110100000000000";
	wait for clk_period;
	theta<="0100001001011001101101100011101010011111100000010101000000000000";
	wait for clk_period;
	theta<="0100010001011100011011100010110011100010011001100011000000000000";
	wait for clk_period;
	theta<="0100011001011111001001100001111100100101010010110001100000000000";
	wait for clk_period;
	theta<="0100100001100001110111100001000101101000001011111111100000000000";
	wait for clk_period;
	theta<="0100101001100100100101100000001110101011000101001101100000000000";
	wait for clk_period;
	theta<="0100110001100111010011011111010111101101111110011100000000000000";
	wait for clk_period;
	theta<="0100111001101010000001011110100000110000110111101010000000000000";
	wait for clk_period;
	theta<="0101000001101100101111011101101001110011110000111000100000000000";
	wait for clk_period;
	theta<="0101001001101111011101011100110010110110101010000110100000000000";
	wait for clk_period;
	theta<="0101010001110010001011011011111011111001100011010100100000000000";
	wait for clk_period;
	theta<="0101011001110100111001011011000100111100011100100011000000000000";
	wait for clk_period;
	theta<="0101100001110111100111011010001101111111010101110001000000000000";
	wait for clk_period;
	theta<="0101101001111010010101011001010111000010001110111111100000000000";
	wait for clk_period;
	theta<="0101110001111101000011011000100000000101001000001101100000000000";
	wait for clk_period;
	theta<="0101111001111111110001010111101001001000000001011011100000000000";
	wait for clk_period;
	theta<="0110000010000010011111010110110010001010111010101010000000000000";
	wait for clk_period;
	theta<="0110001010000101001101010101111011001101110011111000000000000000";
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
