LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;


ENTITY move_mouse IS
	PORT
		(clk : IN std_logic;
      pixel_row, pixel_column, mouse_row, mouse_column	: IN std_logic_vector(9 DOWNTO 0);
		  red, green, blue 			: OUT std_logic);		
END move_mouse;

architecture behavior of move_mouse is

SIGNAL mouse_on : std_logic;
SIGNAL size : std_logic_vector(9 DOWNTO 0);  
SIGNAL mouse_y_pos				: std_logic_vector(9 DOWNTO 0);
SIGNAL mouse_x_pos				: std_logic_vector(9 DOWNTO 0);

BEGIN           

mouse_y_pos <= mouse_row;
mouse_x_pos <= mouse_column;

size <= CONV_STD_LOGIC_VECTOR(4,10);
-- ball_x_pos and ball_y_pos show the (x,y) for the centre of ball

mouse_on <= '1' when ( ('0' & mouse_x_pos <= '0' & pixel_column + size) and ('0' & pixel_column <= '0' & mouse_x_pos + size) 	-- x_pos - size <= pixel_column <= x_pos + size
					 and ('0' & mouse_y_pos <= pixel_row + size) and ('0' & pixel_row <= mouse_y_pos + size) )  else	-- y_pos - size <= pixel_row <= y_pos + size
			     '0';


-- Colours for pixel data on video signal
-- Changing the background and ball colour by pushbuttons
Red <= not mouse_on;
Green <= not mouse_on;
Blue <= '1';

END behavior;


