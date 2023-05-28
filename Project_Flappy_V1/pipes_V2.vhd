Library IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;

Entity Pipes_V2 is
	PORT
		(clk, horiz_sync, enable, coin_enable, reset: IN std_logic;
		      pipe_h : IN std_logic_vector(9 downto 0);
          pixel_row, pixel_column	: IN std_logic_vector(9 DOWNTO 0);

          initial : IN std_logic_vector(10 DOWNTO 0); -- Starting position for each 3 pipes
          speed : IN std_logic_vector(8 downto 0);
		  red, green, blue, pipe_state, coin_state, count, initialized, coin_rst	: OUT std_logic);		
end Pipes_V2;

Architecture behaviour of Pipes_V2 is

  SIGNAL width : std_logic_vector(9 DOWNTO 0);  
  SIGNAL pipe_1_on, pipeB_1_on, pipe_on, powerup_enable				: std_logic;
  SIGNAL pipe_1_x_pos			                             : std_logic_vector(10 DOWNTO 0);
  SIGNAL pipe_1_h              : std_logic_vector(9 DOWNTO 0);
  SIGNAL timer : std_logic_vector(9 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(0,10);
  SIGNAL t_powerup_rand : std_logic_vector(8 DOWNTO 0);

  Signal Font_RED : std_logic := '0'; 
  Signal Font_GREEN : std_logic := '0';
  Signal Font_BLUE : std_logic := '1';
  Signal Font_Multiplier : integer := 3;
  signal coin_address : std_logic_vector(5 downto 0) := "001111";
  signal coin_row, coin_column : std_logic_vector(9 downto 0);
  signal coin_R_out, coin_G_out, coin_B_out : std_logic;
  
  component Sprite_Printer is	
    port(pixel_row, pixel_col, anchor_row, anchor_col : in std_logic_vector(9 downto 0);
       sprite_red, sprite_green, sprite_blue : in std_logic;
       multiplier : in integer range 1 to 4;
       address : in std_logic_vector (5 downto 0);
       enable, clk : in std_logic;
       red_out, green_out, blue_out : out std_logic);
  end component Sprite_printer;
  
  component Psudo_Gen is
   	  PORT(clk, rst : IN std_logic;
		    psudo_rand : OUT std_logic_vector(8 downto 0));	
  end component;
  
  type xy_pos is record
    x_pos : std_logic_vector(10 DOWNTO 0);
    y_pos : std_logic_vector(9 DOWNTO 0);
  end record;
  
  function update_xy (x_pos : std_logic_vector(10 DOWNTO 0); 
                      y_pos : std_logic_vector(9 DOWNTO 0); 
                      pipe_h : std_logic_vector(9 DOWNTO 0)) return xy_pos is
                
    variable xy : xy_pos;
    begin
      if(x_pos = CONV_STD_LOGIC_VECTOR(0,11)) then  -- When it reach the left bound, goes back to right bound
	      xy.x_pos := CONV_STD_LOGIC_VECTOR(760,11);	
	      
	      if(pipe_h > CONV_STD_LOGIC_VECTOR(336,10)) then -- When it generated an impossible to pass wall (0-->480), then make it at center.
	        xy.y_pos := CONV_STD_LOGIC_VECTOR(336,10);
	      else 
	        xy.y_pos := pipe_h;
	      end if;
	       
	    else
	      xy.x_pos := x_pos - '1'; --Propagate to left 1 px
	      xy.y_pos := y_pos;      
	    end if;
	    
	    return xy;
	end function;
	    
  
  begin
    width <= CONV_STD_LOGIC_VECTOR(80,10);
    count <= '1' when pipe_1_x_pos = conv_std_logic_vector(311, 10) and pipe_1_h < CONV_STD_LOGIC_VECTOR(700,10) else -- When pipe passes the ball (or bird) will be used as trigger for score_counter
    '0';
  
    pipe_1_on <= '1' when ( ('0' & pipe_1_x_pos <= '0' & pixel_column + width) and ('0' & pixel_column <= '0' & pipe_1_x_pos) 	-- x_pos - size <= pixel_column <= x_pos + size
      and ('0' & pixel_row <= pipe_1_h) and (pipe_1_h < CONV_STD_LOGIC_VECTOR(700,10)))  else	-- y_pos - size <= pixel_row <= y_pos + size
		  '0';
		
		pipeB_1_on <= '1' when ( ('0' & pipe_1_x_pos <= '0' & pixel_column + width) and ('0' & pixel_column <= '0' & pipe_1_x_pos) 	-- x_pos - size <= pixel_column <= x_pos + size
		  and ('0' & pixel_row >= pipe_1_h + conv_std_logic_vector(224, 10)) and (pipe_1_h < CONV_STD_LOGIC_VECTOR(700,10)))  else	-- y_pos - size <= pixel_row <= y_pos + size
		  '0';
		  
    pipe_on <= pipe_1_on or --or pipe_3_on or 
               pipeB_1_on; -- or pipeB_3_on;
    
 	  pipe_state <= pipe_on when (pixel_column > conv_std_logic_vector(311, 10) and pixel_column < conv_std_logic_vector(329, 10)) else
                  '0';
 	  
    Red <= not pipe_on and coin_R_out;
    Green <= '1' and coin_G_out;
    Blue <= not pipe_on and coin_B_out;
    
    coin_column <= pipe_1_x_pos(9 downto 0) - conv_std_logic_vector(52, 9);
    coin_row <= pipe_1_h + conv_std_logic_vector(80, 9);
    
    coin_state <= coin_R_out when (pixel_column > conv_std_logic_vector(311, 10) and pixel_column < conv_std_logic_vector(329, 10)) else
                  '0';
    
    powerip_gen: Psudo_Gen port map(clk, reset, t_powerup_rand);
      
    coin: sprite_printer port map(pixel_row, pixel_column, coin_row, coin_column, Font_RED, Font_GREEN, Font_BLUE, Font_Multiplier, coin_address, powerup_enable, CLK, coin_R_out, coin_G_out, coin_B_out);
    
    Move_Pipe: process (horiz_sync, reset)  
    
    variable pipe_xy : xy_pos;
    	
    begin 
	     if (rising_edge(horiz_sync)) then
	       
	       if(reset = '1') then
	         pipe_1_x_pos <= initial;
	         pipe_1_h <= CONV_STD_LOGIC_VECTOR(700,10);
	         initialized <= '1';
	         powerup_enable <= '0';

	       elsif (enable = '1') then
	         initialized <= '0';
	         --coin_rst <= '1';
	         if(pipe_1_x_pos = CONV_STD_LOGIC_VECTOR(0,11)) then
	           --  coin_rst <= '1'
	           
	           --if(t_powerup_rand(0 DOWNTO 0) = "1") then
	             --coin_rst <= '0';
	             powerup_enable <= '1';
	           --else
	           --  powerup_enable <= '0';
	           --else
	             --powerup_enable <= '0';
	           --end if;
	         end if;   
	         
	         --powerup_enable <= powerup_enable; --and coin_enable;
	         
	         if(timer = speed) then
	      
	           pipe_xy := update_xy(pipe_1_x_pos, pipe_1_h, pipe_h);
	           pipe_1_x_pos <= pipe_xy.x_pos;
	           pipe_1_h <= pipe_xy.y_pos;
	         
	           timer <= CONV_STD_LOGIC_VECTOR(0,10);
	           
	          else 
	           timer <= timer + '1';
	           
	         end if;
	       end if;
	     end if;
	  end process Move_Pipe;
	      
end architecture;

