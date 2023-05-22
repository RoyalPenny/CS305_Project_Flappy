LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;


ENTITY bouncy_ball IS
	PORT
		( pb1, enable, clk, vert_sync : IN std_logic;
          pixel_row, pixel_column	: IN std_logic_vector(9 DOWNTO 0);
		  red, green, blue, ball_state 			: OUT std_logic);		
END bouncy_ball;

architecture behavior of bouncy_ball is

SIGNAL dir, rst, m_rst : std_logic := '1';
SIGNAL ball_on					: std_logic;
SIGNAL size : std_logic_vector(9 DOWNTO 0);  
SIGNAL ball_y_pos				: std_logic_vector(9 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(239,10);
SiGNAL ball_x_pos				: std_logic_vector(10 DOWNTO 0);
SIGNAL ball_y_motion			: std_logic_vector(9 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(0,10);

BEGIN           

size <= CONV_STD_LOGIC_VECTOR(8,10);
-- ball_x_pos and ball_y_pos show the (x,y) for the centre of ball
ball_x_pos <= CONV_STD_LOGIC_VECTOR(320,11);

ball_on <= '1' when ( ('0' & ball_x_pos <= '0' & pixel_column + size) and ('0' & pixel_column <= '0' & ball_x_pos + size) 	-- x_pos - size <= pixel_column <= x_pos + size
					 and ('0' & ball_y_pos <= pixel_row + size) and ('0' & pixel_row <= ball_y_pos + size) )  else	-- y_pos - size <= pixel_row <= y_pos + size
			     '0';

ball_state <= ball_on when (pixel_column > conv_std_logic_vector(311, 10) and pixel_column < conv_std_logic_vector(329, 10)) else
              '0';


-- Colours for pixel data on video signal
-- Changing the background and ball colour by pushbuttons
Red <= '1';
Green <= not ball_on;
Blue <= not ball_on;

Move_Ball: process (vert_sync)  	
begin
	-- Move ball once every vertical sync
	 
	 if (rising_edge(vert_sync) and enable = '1') then		
	   if(pb1 = '0' and rst = '1') then
	     dir <= '0';
	   else
	     dir <= '1';
	   end if;
	  
	   rst <= pb1;
		
		
		  if(dir = '0') then	  
			 ball_y_motion <= - CONV_STD_LOGIC_VECTOR(10,10); 
			
		  elsif(ball_y_motion < CONV_STD_LOGIC_VECTOR(10,10) and ball_y_pos + CONV_STD_LOGIC_VECTOR(8,10) < CONV_STD_LOGIC_VECTOR(479,10)) then
		    ball_y_motion <= ball_y_motion + CONV_STD_LOGIC_VECTOR(1,10); 
		  end if;
		
		
		  if(ball_y_pos + ball_y_motion + CONV_STD_LOGIC_VECTOR(8,10) > CONV_STD_LOGIC_VECTOR(479,10) and dir = '1') then
	       ball_y_motion <= CONV_STD_LOGIC_VECTOR(479,10) - CONV_STD_LOGIC_VECTOR(8,10) - ball_y_pos;
	       m_rst <= '0';
			   
		  elsif(ball_y_pos + ball_y_motion - CONV_STD_LOGIC_VECTOR(8,10) < CONV_STD_LOGIC_VECTOR(0,10)) then
				  ball_y_motion <= CONV_STD_LOGIC_VECTOR(8,10) - ball_y_pos;
			   m_rst <= '0';
		  end if;
		
		  ball_y_pos <= ball_y_pos + ball_y_motion;
		
		  if(m_rst = '0') then
		    ball_y_motion <= CONV_STD_LOGIC_VECTOR(0,10);
		    m_rst <= '1';
	   end if;
		end if;
end process Move_Ball;

END behavior;

