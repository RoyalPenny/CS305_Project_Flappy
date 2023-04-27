library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity test_test_vga_sync is
end entity test_test_vga_sync;

architecture test of test_test_vga_sync is
    --signal init
    signal t_CLK, t_red_out, t_green_out, t_blue_out, t_horiz_sync_out, t_vert_sync_out : std_logic;
		signal t_pixel_row, t_pixel_column : STD_LOGIC_VECTOR(9 DOWNTO 0);

    component test_vga_sync is
          port (CLK : in std_logic;
          		  red_out, green_out, blue_out, horiz_sync_out, vert_sync_out	: OUT	STD_LOGIC;
			        pixel_row, pixel_column: OUT STD_LOGIC_VECTOR(9 DOWNTO 0));
    end component;
    
    begin   
    -- generate signals:
    my_design: test_vga_sync port map (t_CLK, t_red_out, t_green_out, t_blue_out, t_horiz_sync_out, t_vert_sync_out, t_pixel_row, t_pixel_column);    
      
    clk_gen: process
    begin
      t_CLK <='0';
      wait for 20 ns;
      t_CLK <= '1'; 
      wait for 20 ns;     
    end process clk_gen;  
    
  end architecture;