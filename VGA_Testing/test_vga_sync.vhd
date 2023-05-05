library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity TEST_VGA_SYNC is
          port (CLK, pb1, pb2 : in std_logic;
          		  red_out, green_out, blue_out, horiz_sync_out, vert_sync_out	: OUT	STD_LOGIC);
end entity TEST_VGA_SYNC;

architecture TEST of TEST_VGA_SYNC is
    --signal init
    --resolution 640x480
    signal t_red, t_green, t_blue, t_clkDiv, t_vert_sync_out, t_horiz_sync_out: STD_LOGIC;
    signal t_pixel_row: STD_LOGIC_VECTOR(9 DOWNTO 0);
    signal t_pixel_column: STD_LOGIC_VECTOR(9 DOWNTO 0);
    signal t_psudo_rand: std_logic_vector(8 downto 0);

    component VGA_SYNC is
	   PORT(	clock_25Mhz, red, green, blue		: IN	STD_LOGIC;
		  red_out, green_out, blue_out, horiz_sync_out, vert_sync_out	: OUT	STD_LOGIC;
		  pixel_row, pixel_column: OUT STD_LOGIC_VECTOR(9 DOWNTO 0));
    end component;
    
    component bouncy_ball is
		 PORT(pb1, pb2, clk, vert_sync	: IN std_logic;
          pixel_row, pixel_column	: IN std_logic_vector(9 DOWNTO 0);
		      red, green, blue 			: OUT std_logic);		
    end component;
    
    component Div is
      PORT(CLK : in std_logic;
              clkDiv : out std_logic);
    end component;
    
    component Psudo_Gen is
   	  PORT(clk, rst : IN std_logic;
		   	      psudo_rand : OUT std_logic_vector(8 downto 0));	
		end component;
    
    begin   
    -- generate signals:
    vert_sync_out <= t_vert_sync_out;
    horiz_sync_out <= t_horiz_sync_out;
    
    vga_design: VGA_SYNC port map (t_clkDiv, t_red, t_green, t_blue,
		                              red_out, green_out, blue_out, t_horiz_sync_out, t_vert_sync_out,
			                            t_pixel_row, t_pixel_column);
			                            
	  ball_design: bouncy_ball port map (pb1, pb2, t_clkDiv, t_vert_sync_out, t_pixel_row, t_pixel_column, t_red, t_green, t_blue);   
	  
	  div_design: Div port map (CLK, t_clkDiv);
	    
	  psudo_rand_design: Psudo_Gen port map(t_clkDiv, pb2, t_psudo_rand);
	    
  end architecture;