library IEEE;
use  IEEE.STD_LOGIC_1164.all;
use  IEEE.STD_LOGIC_ARITH.all;
use  IEEE.STD_LOGIC_UNSIGNED.all;

entity test_sprite_printer is
end entity test_sprite_printer;

architecture a1 of test_sprite_printer is 

  signal t_pixel_row, t_pixel_col : std_logic_vector(9 downto 0):= conv_std_logic_vector(0,10); -- Input
  signal t_anchor_row, t_anchor_col : std_logic_vector(9 downto 0); -- Input
<<<<<<< HEAD
  signal t_multiplier : integer range 1 to 4; -- Input
=======
  signal t_multiplier : std_logic_vector(2 downto 0); -- Input
>>>>>>> a1b5eed5867566db24e740ce5031ba567b42023d
  signal t_address : std_logic_vector (5 downto 0); -- Input
  signal t_enable, t_clk, t_rom_mux_output : std_logic; -- Enable&CLK input, rom_mux_output is output

  component sprite_printer is
    port(pixel_row, pixel_col, anchor_row, anchor_col : in std_logic_vector(9 downto 0);
<<<<<<< HEAD
         multiplier : in integer range 1 to 4;
=======
         multiplier : in std_logic_vector(2 downto 0);
>>>>>>> a1b5eed5867566db24e740ce5031ba567b42023d
         address : in std_logic_vector (5 downto 0);
         enable, clk : in std_logic;
         rom_mux_output : out std_logic);
  end component SPRITE_PRINTER;
  
  begin
      
    DUT: sprite_printer port map(t_pixel_row, t_pixel_col, t_anchor_row, t_anchor_col, t_multiplier, t_address, t_enable, t_clk, t_rom_mux_output);
    
    init: process
    begin
      t_enable <= '1';
<<<<<<< HEAD
      t_multiplier <= 3;
      t_address <= "111010"; --Print Apple Sprite, Address 72
      t_anchor_row <= conv_std_logic_vector(8,10);
      t_anchor_col <= conv_std_logic_vector(8,10);
      wait for 40 ns;
=======
      t_multiplier <= "001";
      t_address <= "000001";
      t_anchor_row <= conv_std_logic_vector(3,10);
      t_anchor_col <= conv_std_logic_vector(3,10);
      wait for 20 ns;
>>>>>>> a1b5eed5867566db24e740ce5031ba567b42023d
    end process init;
    
    
    clk_gen: process
    begin
<<<<<<< HEAD
      t_clk <='1';
      wait for 20 ns;
      t_clk <= '0'; 
=======
      t_clk <='0';
      wait for 20 ns;
      t_clk <= '1'; 
>>>>>>> a1b5eed5867566db24e740ce5031ba567b42023d
      wait for 20 ns;     
    end process clk_gen; 
  
      
<<<<<<< HEAD
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
    
    
=======
    pixel_col_gen: process
    begin
      
      if (t_pixel_col = conv_std_logic_vector(640,10))then
        t_pixel_col <=  conv_std_logic_vector(0,10);
      else
        t_pixel_col <= t_pixel_col + '1';
      end if;
    
      wait for 20 ns;
    
    end process pixel_col_gen;
    
    
    pixel_row_gen: process
    begin
      t_pixel_row <= t_pixel_row + "0000000001";
      wait for 12800 ns;
    end process pixel_row_gen;
>>>>>>> a1b5eed5867566db24e740ce5031ba567b42023d
    

  end a1;
      
      