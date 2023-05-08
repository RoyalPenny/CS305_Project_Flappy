LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_UNSIGNED.all;

entity TEXT_PRINTER is
  
  -- pixel_row, pixel_col : current pixel row and column
  -- anchor_row, anchor_col : where to place the text, the top left is the anchor of the 8x8 text tile
  -- character: what character to display
  -- rom_mux_out : once character and position is set, it will send 1 or 0, according to current row and col pixel.
  
  port(pixel_row, pixel_col, anchor_row, anchor_col : in std_logic_vector(9 downto 0);
       multiplier : in std_logic_vector(2 downto 0);
       character : in std_logic_vector (5 downto 0);
       clk : in std_logic;
       rom_mux_output : out std_logic);
  
end TEXT_PRINTER;

architecture a of TEXT_PRINTER is
  
  signal s_font_row : std_logic_vector(2 downto 0);
  signal s_font_col : std_logic_vector(2 downto 0);
  
  component CHAR_ROM is 
    port (character_address	:	in std_logic_vector (5 downto 0);
		      font_row, font_col	:	in std_logic_vector (2 downto 0);
		      clock				: 	in std_logic ;
		      rom_mux_output		:	out std_logic);
	end component;
  
begin
  
  character_rom:CHAR_ROM port map (character_address => character, font_row => s_font_row, font_col => s_font_col,  clock => clk, rom_mux_output => rom_mux_output);
    
  

end a;
       
