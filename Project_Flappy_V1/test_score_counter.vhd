library IEEE;
use  IEEE.STD_LOGIC_1164.all;
use  IEEE.STD_LOGIC_ARITH.all;
use  IEEE.STD_LOGIC_UNSIGNED.all;

entity test_score_counter is
end entity test_score_counter;

architecture a1 of test_score_counter is 

  signal t_pixel_row, t_pixel_col : std_logic_vector(9 downto 0):= conv_std_logic_vector(0,10); -- Input
  signal t_enable, t_clk, t_count, t_reset : std_logic; -- Enable&CLK input, rom_mux_output is output
  signal t_red_out, t_green_out, t_blue_out : std_logic;
  signal t_score_out : std_logic_vector (3 downto 0);

Component Score_Counter is
    port(pixel_row, pixel_col : in std_logic_vector(9 downto 0);
	 Enable, Clk, Count, Reset : in std_logic;
         Red_out, Green_out, Blue_out : out std_logic;
	 score_out : out std_logic_vector(3 downto 0));
end Component;
  begin
      
    DUT: Score_Counter port map(t_pixel_row, t_pixel_col, t_enable, t_clk, t_count, t_reset, t_red_out, t_green_out, t_blue_out, t_score_out);
    
	t_reset <= '1' , '0' after 25 ns;

    init: process
    begin
      t_enable <= '1';
      t_count <= '0', '1' after 100 ns, '0' after 200 ns;
      wait for 1 us;
    end process init;
    
    
    clk_gen: process
    begin
      t_clk <='1';
      wait for 20 ns;
      t_clk <= '0'; 
      wait for 20 ns;     
    end process clk_gen; 
  
    pixel_cord_gen: process
    begin
      if (t_pixel_col = conv_std_logic_vector(640,10))then
        t_pixel_col <= conv_std_logic_vector(0,10);
        t_pixel_row <= t_pixel_row + '1';
      else
        t_pixel_col <= t_pixel_col + '1';
      end if;
      wait for 40 ns;
    end process pixel_cord_gen;

  end a1;
      
      