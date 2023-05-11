library IEEE;
use  IEEE.STD_LOGIC_1164.all;
use  IEEE.STD_LOGIC_ARITH.all;
use  IEEE.STD_LOGIC_UNSIGNED.all;

entity test_sprite_printer is
end entity test_sprite_printer;

architecture a1 of test_sprite_printer is 

  signal t_pixel_row, t_pixel_col : std_logic_vector(9 downto 0):= conv_std_logic_vector(0,10); -- Input
  signal t_anchor_row, t_anchor_col : std_logic_vector(9 downto 0); -- Input
  signal t_red, t_green, t_blue : std_logic;
  signal t_multiplier : integer range 1 to 4; -- Input
  signal t_address : std_logic_vector (5 downto 0); -- Input
  signal t_enable, t_clk, t_red_out, t_green_out, t_blue_out : std_logic; -- Enable&CLK input, rom_mux_output is output

  component sprite_printer is
    port(pixel_row, pixel_col, anchor_row, anchor_col : in std_logic_vector(9 downto 0);
         sprite_red, sprite_green, sprite_blue : in std_logic;
         multiplier : in integer range 1 to 4;
         address : in std_logic_vector (5 downto 0);
         enable, clk : in std_logic;
         red_out, green_out, blue_out : out std_logic);
  end component SPRITE_PRINTER;
  
  begin
      
    DUT: sprite_printer port map(t_pixel_row, t_pixel_col, t_anchor_row, t_anchor_col,t_red, t_green, t_blue, t_multiplier, t_address, t_enable, t_clk, t_red_out, t_green_out, t_blue_out);
    
    init: process
    begin
      t_enable <= '1';
      t_multiplier <= 3;
      t_red <= '0';
      t_green <= '1';
      t_blue <= '1';
      t_address <= "111010"; --Print Apple Sprite, Address 72
      t_anchor_row <= conv_std_logic_vector(8,10);
      t_anchor_col <= conv_std_logic_vector(8,10);
      wait for 40 ns;
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
      
      