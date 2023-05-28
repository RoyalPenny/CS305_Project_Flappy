LIBRARY IEEE;
USE  IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;

entity Project_Flappy_V1 is
          port (CLK, pb1, pb2, pb3, pb4, mode_switch : in std_logic;
          		  red_out, green_out, blue_out, horiz_sync_out, vert_sync_out, collision	: OUT	STD_LOGIC;
          		  display1, display2 : out std_logic_vector(6 downto 0);
          		  mouse_data, mouse_clk : inout std_logic);
end entity Project_Flappy_V1;

architecture game of Project_Flappy_V1 is
    --signal init
    --resolution 640x480
    signal t_ball_red, t_ball_green, t_ball_blue,
           t_pipe_1_red, t_pipe_1_green, t_pipe_1_blue,
           t_pipe_2_red, t_pipe_2_green, t_pipe_2_blue,
           t_pipe_3_red, t_pipe_3_green, t_pipe_3_blue,
           t_initialized_1, t_initialized_2, t_initialized_3,
           t_mouse_red, t_mouse_green, t_mouse_blue,
           t_lives_red, t_lives_green, t_lives_blue, t_lives_dir, t_input,
           t_score_red, t_score_green, t_score_blue,
           t_red, t_green, t_blue, t_reset, t_reset_latch, t_pipe_ball_reset,
           t_clkDiv, t_vert_sync_out, t_horiz_sync_out, t_ground_strike,
           t_mouse_data, t_mouse_clk, t_left_button, t_right_button,
           t_finish_r, t_finish_g, t_finish_b,
           t_start_r, t_start_g, t_start_b,
           t_welcome_out,
           t_end : STD_LOGIC;
    signal t_pipe_1_on, t_pipe_2_on, t_pipe_3_on, t_bouncy_ball_on,
           t_count, t_count_1, t_count_2, t_count_3  : STD_LOGIC := '0';
    signal t_tenth_out, t_first_out : std_logic_vector(3 downto 0);
    signal t_speed : std_logic_vector(8 downto 0);
    signal t_enable : STD_LOGIC := '1';
    signal t_pixel_row, t_mouse_row : STD_LOGIC_VECTOR(9 DOWNTO 0);
    signal t_pixel_column, t_mouse_column: STD_LOGIC_VECTOR(9 DOWNTO 0);
    signal t_psudo_rand: std_logic_vector(8 downto 0);
    signal t_pipe_h: std_logic_vector(9 downto 0);
    signal t_pipe_initial_1: std_logic_vector(10 downto 0) :=  conv_std_logic_vector(226, 11);
    signal t_pipe_initial_2: std_logic_vector(10 downto 0) :=  conv_std_logic_vector(452, 11);
    signal t_pipe_initial_3: std_logic_vector(10 downto 0) :=  conv_std_logic_vector(678, 11);

    component VGA_SYNC is
	   PORT(	clock_25Mhz, red, green, blue		: IN	STD_LOGIC;
		  red_out, green_out, blue_out, horiz_sync_out, vert_sync_out	: OUT	STD_LOGIC;
		  pixel_row, pixel_column: OUT STD_LOGIC_VECTOR(9 DOWNTO 0));
    end component;
    
    component mouse is 
      PORT( clock_25Mhz, reset 		: IN std_logic;
         mouse_data					: INOUT std_logic;
         mouse_clk 					: INOUT std_logic;
         left_button, right_button	: OUT std_logic;
		     mouse_cursor_row 			: OUT std_logic_vector(9 DOWNTO 0); 
		     mouse_cursor_column 		: OUT std_logic_vector(9 DOWNTO 0)); 
		end component;
		
		component move_mouse is
		  PORT(clk : IN std_logic;
      pixel_row, pixel_column, mouse_row, mouse_column	: IN std_logic_vector(9 DOWNTO 0);
		  red, green, blue 			: OUT std_logic);	
		end component;
    
    component bouncy_ball is
		 PORT(pb1, enable, clk, vert_sync, reset : IN std_logic;
          pixel_row, pixel_column	: IN std_logic_vector(9 DOWNTO 0);
		      red, green, blue, ball_state, ground_strike 			: OUT std_logic);		
    end component;
    
    component Div is
      PORT(CLK : in std_logic;
              clkDiv : out std_logic);
    end component;
    
    component Psudo_Gen is
   	  PORT(clk, rst : IN std_logic;
		   	      psudo_rand : OUT std_logic_vector(8 downto 0));	
		end component;
		   
		component Pipes_V2 is
		  	PORT (clk, horiz_sync, enable, reset	: IN std_logic;
		        pipe_h : IN std_logic_vector(9 downto 0);
            pixel_row, pixel_column	: IN std_logic_vector(9 DOWNTO 0);
            initial : IN std_logic_vector(10 DOWNTO 0);
		        speed : IN std_logic_vector(8 downto 0);	
		        red, green, blue, pipe_state, count, initialized 			: OUT std_logic);		
		   end component;
		   
		component pipe_difficulty is
  	   PORT (
		      clk, rst, mode, level : IN std_logic;
		      speed : OUT std_logic_vector(8 downto 0)
	         );	
    end component; 
    
    component Two_Digit_Counter is
      port (clk, Init, Enable : in std_logic;
          tenth_out, first_out : out std_logic_vector(3 downto 0);
          display1, display2 : out std_logic_vector(6 downto 0));
    end component;

    component start_page is
      port(pixel_row, pixel_col : in std_logic_vector(9 downto 0);
	       Clk, enable  : in std_logic;
         Red_out, Green_out, Blue_out : out std_logic);
    end component;
    
    component game_over is
      port(pixel_row, pixel_col : in std_logic_vector(9 downto 0);
	       Clk, enable  : in std_logic;
         Red_out, Green_out, Blue_out : out std_logic);

    end component;
    
    component life_counter is
  	   PORT (
		      clk, rst, dir, input : IN std_logic;
		      pixel_row, pixel_col : IN std_logic_vector(9 downto 0);
		      red, green, blue, over : OUT std_logic
	    );	
    end component;
    
    component Score_Counter is
      port(pixel_row, pixel_col : in std_logic_vector(9 downto 0);
         tenth, first : in std_logic_vector(3 downto 0);
	       Clk : in std_logic;
         Red_out, Green_out, Blue_out : out std_logic);
    end component;
    
    component coll_detect is
  	   PORT (
		  clk, bouncy_ball_on, pipe_1_on, pipe_2_on, pipe_3_on, ground_strike, rst, disable : IN std_logic;
		  input : OUT std_logic
	   );	
    end component;
    
    begin   
    -- generate signals:
    vert_sync_out <= t_vert_sync_out;
    horiz_sync_out <= t_horiz_sync_out;
    
    t_red <= (t_ball_red or t_end) and t_pipe_1_red and t_pipe_2_red and t_pipe_3_red and (t_mouse_red or t_enable) and t_lives_red and t_score_red and t_finish_r and t_start_r; -- and t_sprite_red_out;
    t_green <= (t_ball_green or t_end) and t_pipe_1_green and t_pipe_2_green and t_pipe_3_green and (t_mouse_green or t_enable) and t_lives_green and t_score_green and t_finish_g and t_start_g; -- and t_sprite_green_out;
    t_blue <= (t_ball_blue or t_end) and t_pipe_1_blue and t_pipe_2_blue and t_pipe_3_blue and (t_mouse_blue or t_enable) and t_lives_blue and t_score_blue and t_finish_b and t_start_b; -- and t_sprite_blue_out;
    
    t_count <= t_count_1 or t_count_2 or t_count_3;
    
    t_lives_dir <= '0'; -- when ((t_bouncy_ball_on = '1' and (t_pipe_1_on = '1' or t_pipe_2_on = '1' or t_pipe_3_on = '1'))
                      --or t_ground_strike = '0') else
                   --'1' when (t_enable = '1');
                   
    --t_input <= '1' when ((t_bouncy_ball_on = '1' and (t_pipe_1_on = '1' or t_pipe_2_on = '1' or t_pipe_3_on = '1'))
                      --or t_ground_strike = '0') else
               --'0';

    
    t_pipe_ball_reset <= '1' when (t_reset = '1' or (t_input = '1' and t_left_button = '1')) else
                         '0' when (t_initialized_1 = '1' and t_initialized_2 = '1' and t_initialized_3 = '1');
                
    t_enable <= '0' when (t_input = '1' or pb1 = '0' or t_end = '1' or t_reset_latch = '1') else 
                '1' when (t_left_button = '1' and t_reset_latch = '0');
               
    t_reset_latch <= '0' when (t_left_button = '1') else
                     '1' when (t_reset = '1');
    
    t_reset <= '1' when (pb3 = '0') else
               '0';

               
    collision <= t_score_red;
                

    
    t_pipe_h <= '0' & t_psudo_rand;
    
    mouse_design: mouse port map (t_clkDiv, t_reset, mouse_data, mouse_clk, t_left_button, t_right_button, t_mouse_row, t_mouse_column);
      
    move_mouse_design: move_mouse port map (t_clkDiv, t_pixel_row, t_pixel_column, t_mouse_row, t_mouse_column, t_mouse_red, t_mouse_green, t_mouse_blue);
    
    vga_design: VGA_SYNC port map (t_clkDiv, t_red, t_green, t_blue,
		                              red_out, green_out, blue_out, t_horiz_sync_out, t_vert_sync_out,
			                            t_pixel_row, t_pixel_column);
			                            
	  ball_design: bouncy_ball port map (t_left_button, t_enable, t_clkDiv, t_vert_sync_out, t_pipe_ball_reset, t_pixel_row, t_pixel_column, t_ball_red, t_ball_green, t_ball_blue, t_bouncy_ball_on, t_ground_strike);   
	  
	  div_design: Div port map (CLK, t_clkDiv);
	    
	  psudo_rand_design: Psudo_Gen port map(t_clkDiv, pb3, t_psudo_rand);

	  pipe1: Pipes_V2 port map(t_clkDiv, t_horiz_sync_out, t_enable, t_pipe_ball_reset, t_pipe_h, t_pixel_row, t_pixel_column, t_pipe_initial_1, t_speed, t_pipe_1_red, t_pipe_1_green, t_pipe_1_blue, t_pipe_1_on, t_count_1, t_initialized_1);
	  pipe2: Pipes_V2 port map(t_clkDiv, t_horiz_sync_out, t_enable, t_pipe_ball_reset, t_pipe_h, t_pixel_row, t_pixel_column, t_pipe_initial_2, t_speed, t_pipe_2_red, t_pipe_2_green, t_pipe_2_blue, t_pipe_2_on, t_count_2, t_initialized_2);
	  pipe3: Pipes_V2 port map(t_clkDiv, t_horiz_sync_out, t_enable, t_pipe_ball_reset, t_pipe_h, t_pixel_row, t_pixel_column, t_pipe_initial_3, t_speed, t_pipe_3_red, t_pipe_3_green, t_pipe_3_blue, t_pipe_3_on, t_count_3, t_initialized_3);
	  
	  lives: life_counter port map(t_clkDiv, t_reset, t_lives_dir, t_pipe_ball_reset, t_pixel_row, t_pixel_column, t_lives_red, t_lives_green, t_lives_blue, t_end);
	  
	  collision_detect: coll_detect port map(t_clkDiv, t_bouncy_ball_on, t_pipe_1_on, t_pipe_2_on, t_pipe_3_on, t_ground_strike, t_enable, t_pipe_ball_reset, t_input);
	  
	  difficulty: pipe_difficulty port map(t_clkDiv, t_reset, mode_switch, t_count, t_speed);
	   
	  seg: Two_Digit_Counter port map(t_clkDiv, t_reset, t_count, t_tenth_out, t_first_out, display1, display2);   
	  
	  score: Score_Counter port map(t_pixel_row, t_pixel_column, t_tenth_out, t_first_out, t_clkDiv, t_score_red, t_score_green, t_score_blue);
	  
	  start: start_page port map(t_pixel_row, t_pixel_column, t_clkDiv, t_reset_latch, t_start_r, t_start_g, t_start_b);
	    
	  finish: game_over port map(t_pixel_row, t_pixel_column, t_clkDiv, t_end, t_finish_r, t_finish_g, t_finish_b);
	  
  end architecture;