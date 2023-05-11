Library IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;

Entity Pipes is
	PORT
		(clk, horiz_sync	: IN std_logic;
		      pipe_h : IN std_logic_vector(9 downto 0);
          pixel_row, pixel_column	: IN std_logic_vector(9 DOWNTO 0);
		  red, green, blue 			: OUT std_logic);		
end Pipes;

Architecture behaviour of Pipes is
  
  SIGNAL dir, rst, m_rst					: std_logic := '1';
  SIGNAL width : std_logic_vector(9 DOWNTO 0);  
  SIGNAL pipe_1_on, pipe_2_on, pipe_3_on, pipeB_1_on, pipeB_2_on, pipeB_3_on, pipe_on				: std_logic;
  SIGNAL pipe_1_x_pos			                             : std_logic_vector(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(107,11);
  SIGNAL pipe_2_x_pos			                             : std_logic_vector(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(320,11);
  SIGNAL pipe_3_x_pos				                            : std_logic_vector(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(533,11);
  SIGNAL pipe_1_h, pipe_2_h, pipe_3_h                : std_logic_vector(9 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(0,10);
  SIGNAL timer : std_logic_vector(9 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(0,10);
  
  type xy_pos is record
    x_pos : std_logic_vector(10 DOWNTO 0);
    y_pos : std_logic_vector(9 DOWNTO 0);
  end record;
  
  function update_xy (x_pos : std_logic_vector(10 DOWNTO 0); 
                      y_pos : std_logic_vector(9 DOWNTO 0); 
                      pipe_h : std_logic_vector(9 DOWNTO 0)) return xy_pos is
                      
      variable xy : xy_pos;
    begin
      if(x_pos = CONV_STD_LOGIC_VECTOR(0,11)) then
	      xy.x_pos := CONV_STD_LOGIC_VECTOR(704,11);	
	      
	      if(pipe_h > CONV_STD_LOGIC_VECTOR(336,10)) then
	        xy.y_pos := CONV_STD_LOGIC_VECTOR(336,10);
	      else 
	        xy.y_pos := pipe_h;
	      end if;
	       
	    else
	      xy.x_pos := x_pos - '1';
	      xy.y_pos := y_pos;      
	    end if;
	    
	    return xy;
	end function;
	    
  
  begin
    width <= CONV_STD_LOGIC_VECTOR(64,10);
  
    pipe_1_on <= '1' when ( ('0' & pipe_1_x_pos <= '0' & pixel_column + width) and ('0' & pixel_column <= '0' & pipe_1_x_pos) 	-- x_pos - size <= pixel_column <= x_pos + size
      and ('0' & pixel_row <= pipe_1_h) )  else	-- y_pos - size <= pixel_row <= y_pos + size
		  '0';
		  
		pipe_2_on <= '1' when ( ('0' & pipe_2_x_pos <= '0' & pixel_column + width) and ('0' & pixel_column <= '0' & pipe_2_x_pos) 	-- x_pos - size <= pixel_column <= x_pos + size
		  and ('0' & pixel_row <= pipe_2_h) )  else	-- y_pos - size <= pixel_row <= y_pos + size
		  '0';
		  
		pipe_3_on <= '1' when ( ('0' & pipe_3_x_pos <= '0' & pixel_column + width) and ('0' & pixel_column <= '0' & pipe_3_x_pos) 	-- x_pos - size <= pixel_column <= x_pos + size
		  and ('0' & pixel_row <= pipe_3_h) )  else	-- y_pos - size <= pixel_row <= y_pos + size
		  '0';
		
		pipeB_1_on <= '1' when ( ('0' & pipe_1_x_pos <= '0' & pixel_column + width) and ('0' & pixel_column <= '0' & pipe_1_x_pos) 	-- x_pos - size <= pixel_column <= x_pos + size
		  and ('0' & pixel_row >= pipe_1_h + conv_std_logic_vector(96, 10)) )  else	-- y_pos - size <= pixel_row <= y_pos + size
		  '0';
		  
		pipeB_2_on <= '1' when ( ('0' & pipe_2_x_pos <= '0' & pixel_column + width) and ('0' & pixel_column <= '0' & pipe_2_x_pos) 	-- x_pos - size <= pixel_column <= x_pos + size
		  and ('0' & pixel_row >= pipe_2_h + conv_std_logic_vector(96, 10)) )  else	-- y_pos - size <= pixel_row <= y_pos + size
		  '0';
		  
		pipeB_3_on <= '1' when ( ('0' & pipe_3_x_pos <= '0' & pixel_column + width) and ('0' & pixel_column <= '0' & pipe_3_x_pos) 	-- x_pos - size <= pixel_column <= x_pos + size
		  and ('0' & pixel_row >= pipe_3_h + conv_std_logic_vector(96, 10)) ) else	-- y_pos - size <= pixel_row <= y_pos + size
		  '0';
  
    pipe_on <= pipe_1_on or pipe_2_on or pipe_3_on or pipeB_1_on or pipeB_2_on or pipeB_3_on;
  
    Red <= not pipe_on;
    Green <= '1';
    Blue <= not pipe_on;
    
    Move_Pipe: process (horiz_sync)  
    
    variable pipe_xy : xy_pos;
    	
    begin
	   -- Move ball once every vertical sync
	    if (rising_edge(horiz_sync)) then
	      if(timer = CONV_STD_LOGIC_VECTOR(320,11)) then
	      
	         pipe_xy := update_xy(pipe_1_x_pos, pipe_1_h, pipe_h);
	         pipe_1_x_pos <= pipe_xy.x_pos;
	         pipe_1_h <= pipe_xy.y_pos;
	         
	         pipe_xy := update_xy(pipe_2_x_pos, pipe_2_h, pipe_h);
	         pipe_2_x_pos <= pipe_xy.x_pos;
	         pipe_2_h <= pipe_xy.y_pos;
	         
	         pipe_xy := update_xy(pipe_3_x_pos, pipe_3_h, pipe_h);
	         pipe_3_x_pos <= pipe_xy.x_pos;
	         pipe_3_h <= pipe_xy.y_pos;
	         
	         timer <= CONV_STD_LOGIC_VECTOR(0,10);
	         
	      else 
	        timer <= timer + '1';
	      end if;
	    end if;
	  end process Move_Pipe;
	      
end architecture;
