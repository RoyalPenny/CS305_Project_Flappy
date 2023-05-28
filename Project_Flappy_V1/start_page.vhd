LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;

entity start_page is
    port(pixel_row, pixel_col : in std_logic_vector(9 downto 0);
	       Clk, enable  : in std_logic;
         Red_out, Green_out, Blue_out : out std_logic);

end entity start_page;

architecture behaviour of start_page is

-- Signals for 2 digit counter
signal f_address : std_logic_vector(5 downto 0) := "000110";
signal l_address : std_logic_vector(5 downto 0) := "001100";
signal a_address : std_logic_vector(5 downto 0) := "000001";
signal p_address : std_logic_vector(5 downto 0) := "010000";
signal p1_address : std_logic_vector(5 downto 0) := "010000";
signal y_address : std_logic_vector(5 downto 0) := "011001";
signal b_address : std_logic_vector(5 downto 0) := "000010";
signal i_address : std_logic_vector(5 downto 0) := "001001";
signal r_address : std_logic_vector(5 downto 0) := "010010";
signal d_address : std_logic_vector(5 downto 0) := "000100";


-- Signals for Sprite printing
signal f_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(200, 10);
signal f_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(48, 10);

signal l_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(200, 10);
signal l_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(144, 10);

signal a_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(200, 10);
signal a_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(240, 10);

signal p_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(200, 10);
signal p_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(335, 10);

signal p1_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(200, 10);
signal p1_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(432, 10);

signal y_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(200, 10);
signal y_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(528, 10);

signal b_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(264, 10);
signal b_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(144, 10);

signal i_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(264, 10);
signal i_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(240, 10);

signal r_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(264, 10);
signal r_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(335, 10);

signal d_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(264, 10);
signal d_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(432, 10);


signal f_R_out, f_G_out, f_B_out,
       l_R_out, l_G_out, l_B_out,
       a_R_out, a_G_out, a_B_out,
       p_R_out, p_G_out, p_B_out,
       p1_R_out, p1_G_out, p1_B_out,
       y_R_out, y_G_out, y_B_out,
       b_R_out, b_G_out, b_B_out,
       i_R_out, i_G_out, i_B_out,
       r_R_out, r_G_out, r_B_out,
       d_R_out, d_G_out, d_B_out : std_logic;

-- Font Specs
Signal Font_RED : std_logic := '1';
Signal Font_GREEN : std_logic := '1';
Signal Font_BLUE : std_logic := '1';

Signal Font_Multiplier : integer := 4;

component Sprite_Printer is	
  port(pixel_row, pixel_col, anchor_row, anchor_col : in std_logic_vector(9 downto 0);
       sprite_red, sprite_green, sprite_blue : in std_logic;
       multiplier : in integer range 1 to 4;
       address : in std_logic_vector (5 downto 0);
       enable, clk : in std_logic;
       red_out, green_out, blue_out : out std_logic);
end component Sprite_printer;

	begin
	  f: sprite_printer port map(pixel_row, pixel_col, f_row, f_col, Font_RED, Font_GREEN, Font_BLUE, Font_Multiplier, f_address, enable, CLK, f_R_out, f_G_out, f_B_out);
	  l: sprite_printer port map(pixel_row, pixel_col, l_row, l_col, Font_RED, Font_GREEN, Font_BLUE, Font_Multiplier, l_address, enable, CLK, l_R_out, l_G_out, l_B_out);
	  a: sprite_printer port map(pixel_row, pixel_col, a_row, a_col, Font_RED, Font_GREEN, Font_BLUE, Font_Multiplier, a_address, enable, CLK, a_R_out, a_G_out, a_B_out);
	  p: sprite_printer port map(pixel_row, pixel_col, p_row, p_col, Font_RED, Font_GREEN, Font_BLUE, Font_Multiplier, p_address, enable, CLK, p_R_out, p_G_out, p_B_out);
 	  p1: sprite_printer port map(pixel_row, pixel_col, p1_row, p1_col, Font_RED, Font_GREEN, Font_BLUE, Font_Multiplier, p1_address, enable, CLK, p1_R_out, p1_G_out, p1_B_out);
	  y: sprite_printer port map(pixel_row, pixel_col, y_row, y_col, Font_RED, Font_GREEN, Font_BLUE, Font_Multiplier, y_address, enable, CLK, y_R_out, y_G_out, y_B_out);
	  b: sprite_printer port map(pixel_row, pixel_col, b_row, b_col, Font_RED, Font_GREEN, Font_BLUE, Font_Multiplier, b_address, enable, CLK, b_R_out, b_G_out, b_B_out);
	  i: sprite_printer port map(pixel_row, pixel_col, i_row, i_col, Font_RED, Font_GREEN, Font_BLUE, Font_Multiplier, i_address, enable, CLK, i_R_out, i_G_out, i_B_out);
	  r: sprite_printer port map(pixel_row, pixel_col, r_row, r_col, Font_RED, Font_GREEN, Font_BLUE, Font_Multiplier, r_address, enable, CLK, r_R_out, r_G_out, r_B_out);
	  d: sprite_printer port map(pixel_row, pixel_col, d_row, d_col, Font_RED, Font_GREEN, Font_BLUE, Font_Multiplier, d_address, enable, CLK, d_R_out, d_G_out, d_B_out);
	  		
		Red_out <= f_R_out and l_R_out and a_R_out and p_R_out and p1_R_out and y_R_out and b_R_out and i_R_out and r_R_out and d_R_out; 
		Green_out <= f_G_out and l_G_out and a_G_out and p_G_out and p1_G_out and y_G_out and b_G_out and i_G_out and r_G_out and d_G_out; 
		Blue_out <= f_B_out and l_B_out and a_B_out and p_B_out and p1_B_out and y_B_out and b_B_out and i_B_out and r_B_out and d_B_out; 
end architecture;
		


    
    

