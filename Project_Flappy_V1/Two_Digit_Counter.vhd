library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Two_Digit_Counter is
    port (clk, Init, Enable : in std_logic;
          tenth_out, first_out : out std_logic_vector(3 downto 0);
          display1, display2 : out std_logic_vector(6 downto 0)
    );
end entity;

architecture behaviour of Two_Digit_Counter is

signal f_direction : std_logic := '1';
signal tenth_enable, first_enable : std_logic := '0';
signal t_tenth_enable, t_first_enable, t_tenth_latch : std_logic := '0';
signal s_tenth_out : std_logic_vector(3 downto 0) := "0000";
signal s_first_out : std_logic_vector(3 downto 0) := "0000";


component Four_bit_Counter is
    port (clk, Direction, Init, Enable : in std_logic;
          Q_out : out std_logic_vector(3 downto 0));
end component Four_bit_Counter;

component BCD_to_7Seg is
     port (BCD_digit : in std_logic_vector(3 downto 0);
           SevenSeg_out : out std_logic_vector(6 downto 0));
end component BCD_to_7Seg;

begin
	tenth_counter : Four_bit_Counter port map(clk, f_direction, Init, tenth_enable, s_tenth_out);
	first_counter : Four_bit_Counter port map(clk, f_direction, Init, first_Enable, s_first_out);
	  
  d_1: BCD_to_7Seg port map (BCD_digit => s_first_out, SevenSeg_out => display1);
  d_2: BCD_to_7Seg port map (BCD_digit => s_tenth_out, SevenSeg_out => display2);

  process(clk)
    begin
    
    if(rising_edge(clk)) then 
      if(enable = '1') then
        t_first_enable <= '1';
        
        if(s_first_out = "1001" and t_tenth_enable <= '0' and t_tenth_latch <= '0') then
          t_tenth_enable <= '1';
          t_tenth_latch <= '1';
        end if;
        
        if(s_first_out = "0000" and t_tenth_latch <= '1') then
          t_tenth_latch <= '0';
        end if;
        
      else
        t_first_enable <= '0';
        t_tenth_enable <= '0';
      end if;
    end if;
      
  end process;
  
  first_enable <= t_first_enable;
  tenth_enable <= t_tenth_enable;
	tenth_out <= s_tenth_out;
	first_out <= s_first_out;

end architecture;