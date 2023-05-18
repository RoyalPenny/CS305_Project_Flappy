LIBRARY IEEE;
USE  IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;

entity Project_Flappy_V1 is
          port (CLK, pb1, pb2, pb3 : in std_logic;
          		  red_out, green_out, blue_out, horiz_sync_out, vert_sync_out, collision	: OUT	STD_LOGIC);
end entity Project_Flappy_V1;

architecture TEST of Project_Flappy_V1 is
    --signal init
    --resolution 640x480
    signal t_ball_red, t_ball_green, t_ball_blue,
           t_pipe_red, t_pipe_green, t_pipe_blue,
           t_red, t_green, t_blue,
           t_clkDiv, t_vert_sync_out, t_horiz_sync_out : STD_LOGIC;
    signal t_pipe_on, t_bouncy_ball_on : STD_LOGIC := '0';
    signal t_enable : STD_LOGIC := '1';
    signal t_pixel_row: STD_LOGIC_VECTOR(9 DOWNTO 0);
    signal t_pixel_column: STD_LOGIC_VECTOR(9 DOWNTO 0);
    signal t_psudo_rand: std_logic_vector(8 downto 0);
    signal t_pipe_h: std_logic_vector(9 downto 0);
    
    -- Below for Sprite printer out   
    signal t_sprite_anchor_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(300, 10);
    signal t_sprite_anchor_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(500, 10); 
    signal t_sprite_red : std_logic := '0';
    signal t_sprite_green : std_logic := '1';
    signal t_sprite_blue : std_logic := '1';     
    signal t_sprite_multiplier : integer range 1 to 4 := 3;               
    signal t_sprite_address : std_logic_vector (5 downto 0) := "111010";  
    signal t_sprite_enable: std_logic := '1';                               
    signal t_sprite_red_out, t_sprite_green_out, t_sprite_blue_out : std_logic;   

    component VGA_SYNC is
	   PORT(	clock_25Mhz, red, green, blue		: IN	STD_LOGIC;
		  red_out, green_out, blue_out, horiz_sync_out, vert_sync_out	: OUT	STD_LOGIC;
		  pixel_row, pixel_column: OUT STD_LOGIC_VECTOR(9 DOWNTO 0));
    end component;
    
    component bouncy_ball is
		 PORT(pb1, enable, clk, vert_sync	: IN std_logic;
          pixel_row, pixel_column	: IN std_logic_vector(9 DOWNTO 0);
		      red, green, blue, ball_state 			: OUT std_logic);		
    end component;
    
    component Div is
      PORT(CLK : in std_logic;
              clkDiv : out std_logic);
    end component;
    
    component Psudo_Gen is
   	  PORT(clk, rst : IN std_logic;
		   	      psudo_rand : OUT std_logic_vector(8 downto 0));	
		end component;
		
		component Pipes is
		  	PORT(clk, horiz_sync, enable	: IN std_logic;
		        pipe_h : IN std_logic_vector(9 downto 0);
            pixel_row, pixel_column	: IN std_logic_vector(9 DOWNTO 0);
		        red, green, blue, pipe_state : OUT std_logic);		
		   end component;
		   
		component sprite_printer is
       port(pixel_row, pixel_col, anchor_row, anchor_col : in std_logic_vector(9 downto 0);
       sprite_red, sprite_green, sprite_blue : in std_logic;
       multiplier : in integer range 1 to 4;
       address : in std_logic_vector (5 downto 0);
       enable, clk : in std_logic;
       red_out, green_out, blue_out : out std_logic);
    end component;
    
    begin   
    -- generate signals:
    vert_sync_out <= t_vert_sync_out;
    horiz_sync_out <= t_horiz_sync_out;
    
    t_red <= t_ball_red and t_pipe_red and t_sprite_red_out;
    t_green <= t_ball_green and t_pipe_green and t_sprite_green_out;
    t_blue <= t_ball_blue and t_pipe_blue and t_sprite_blue_out;
  
    
    t_enable <= '0' when (t_bouncy_ball_on = '1' and t_pipe_on = '1') else
                '1' when (pb3 = '0');
          
    collision <= '1' when (t_bouncy_ball_on = '1' and t_pipe_on = '1') else
                 '0';
    
    t_pipe_h <= '0' & t_psudo_rand;
    
    vga_design: VGA_SYNC port map (t_clkDiv, t_red, t_green, t_blue,
		                              red_out, green_out, blue_out, t_horiz_sync_out, t_vert_sync_out,
			                            t_pixel_row, t_pixel_column);
			                            
	  ball_design: bouncy_ball port map (pb1, t_enable, t_clkDiv, t_vert_sync_out, t_pixel_row, t_pixel_column, t_ball_red, t_ball_green, t_ball_blue, t_bouncy_ball_on);   
	  
	  div_design: Div port map (CLK, t_clkDiv);
	    
	  psudo_rand_design: Psudo_Gen port map(t_clkDiv, pb2, t_psudo_rand);
	    
	  pipes_design: Pipes port map(t_clkDiv, t_horiz_sync_out, t_enable, t_pipe_h, t_pixel_row, t_pixel_column, t_pipe_red, t_pipe_green, t_pipe_blue, t_pipe_on);
	    
	  sprite_design: sprite_printer port map(t_pixel_row, t_pixel_column, 
                                           t_sprite_anchor_row, t_sprite_anchor_col,
                                           t_sprite_red, t_sprite_green, t_sprite_blue,
                                           t_sprite_multiplier, t_sprite_address,
                                           t_sprite_enable, t_clkDiv,                           
                                           t_sprite_red_out, t_sprite_green_out, t_sprite_blue_out);   
	     
  end architecture;