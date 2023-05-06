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
  SIGNAL pipe_1_on, pipe_2_on, pipe_3_on, pipe_on					: std_logic;
  SIGNAL width : std_logic_vector(9 DOWNTO 0);  
  SIGNAL pipe_1_y_pos, pipe_2_y_pos, pipe_3_y_pos				: std_logic_vector(9 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(0,10);
  SIGNAL pipe_1_x_pos, pipe_2_x_pos, pipe_3_x_pos				: std_logic_vector(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(640,11);
  SIGNAL timer : std_logic_vector(9 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(0,10);
  
  begin
    width <= CONV_STD_LOGIC_VECTOR(32,10);
  
    pipe_1_on <= '1' when ( ('0' & pipe_1_x_pos <= '0' & pixel_column + width) and ('0' & pixel_column <= '0' & pipe_1_x_pos + width) 	-- x_pos - size <= pixel_column <= x_pos + size
		  and ('0' & pipe_1_y_pos <= pixel_row + pipe_h) and ('0' & pixel_row <= pipe_1_y_pos + pipe_h) )  else	-- y_pos - size <= pixel_row <= y_pos + size
		  '0';
		  
		pipe_2_on <= '1' when ( ('0' & pipe_2_x_pos <= '0' & pixel_column + width) and ('0' & pixel_column <= '0' & pipe_2_x_pos + width) 	-- x_pos - size <= pixel_column <= x_pos + size
		  and ('0' & pipe_2_y_pos <= pixel_row + pipe_h) and ('0' & pixel_row <= pipe_2_y_pos + pipe_h) )  else	-- y_pos - size <= pixel_row <= y_pos + size
		  '0';
		  
		pipe_3_on <= '1' when ( ('0' & pipe_3_x_pos <= '0' & pixel_column + width) and ('0' & pixel_column <= '0' & pipe_3_x_pos + width) 	-- x_pos - size <= pixel_column <= x_pos + size
		  and ('0' & pipe_3_y_pos <= pixe_3_row + pipe_h) and ('0' & pixel_row <= pipe_3_y_pos + pipe_h) )  else	-- y_pos - size <= pixel_row <= y_pos + size
		  '0';
  
    Red <= not pipe_on;
    Green <= '1';
    Blue <= not pipe_on;
    
    Move_Pipe: process (horiz_sync)  	
    begin
	   -- Move ball once every vertical sync
	    if (rising_edge(horiz_sync)) then
	      if(timer = CONV_STD_LOGIC_VECTOR(320,11)) then
	         if(pipe_x_pos = CONV_STD_LOGIC_VECTOR(0,11)) then
	           pipe_x_pos	<= CONV_STD_LOGIC_VECTOR(640,11);
	         else
	           pipe_x_pos <= pipe_x_pos - '1';
	         end if;
	         
	         timer <= CONV_STD_LOGIC_VECTOR(0,10);
	         
	      else 
	        timer <= timer + '1';
	      end if;
	    end if;
	  end process Move_Pipe;
	      
end architecture;