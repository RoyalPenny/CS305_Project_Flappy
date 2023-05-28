LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;

entity game_over is
    port(pixel_row, pixel_col : in std_logic_vector(9 downto 0);
	       Clk, enable  : in std_logic;
         Red_out, Green_out, Blue_out : out std_logic);

end entity game_over;

architecture behaviour of game_over is

-- Signals for 2 digit counter
signal g_address : std_logic_vector(5 downto 0) := "000111";
signal a_address : std_logic_vector(5 downto 0) := "000001";
signal m_address : std_logic_vector(5 downto 0) := "001101";
signal e_address : std_logic_vector(5 downto 0) := "000101";
signal o_address : std_logic_vector(5 downto 0) := "001111";
signal v_address : std_logic_vector(5 downto 0) := "010110";
signal e1_address : std_logic_vector(5 downto 0) := "000101";
signal r_address : std_logic_vector(5 downto 0) := "010010";


-- Signals for Sprite printing
signal g_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(200, 10);
signal g_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(144, 10);

signal a_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(200, 10);
signal a_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(240, 10);

signal m_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(200, 10);
signal m_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(335, 10);

signal e_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(200, 10);
signal e_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(432, 10);

signal o_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(264, 10);
signal o_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(144, 10);

signal v_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(264, 10);
signal v_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(240, 10);

signal e1_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(264, 10);
signal e1_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(335, 10);

signal r_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(264, 10);
signal r_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(432, 10);


signal g_R_out, g_G_out, g_B_out,
       a_R_out, a_G_out, a_B_out,
       m_R_out, m_G_out, m_B_out,
       e_R_out, e_G_out, e_B_out,
       o_R_out, o_G_out, o_B_out,
       v_R_out, v_G_out, v_B_out,
       e1_R_out, e1_G_out, e1_B_out,
       r_R_out, r_G_out, r_B_out : std_logic;

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
	  g: sprite_printer port map(pixel_row, pixel_col, g_row, g_col, Font_RED, Font_GREEN, Font_BLUE, Font_Multiplier, g_address, enable, CLK, g_R_out, g_G_out, g_B_out);
	  a: sprite_printer port map(pixel_row, pixel_col, a_row, a_col, Font_RED, Font_GREEN, Font_BLUE, Font_Multiplier, a_address, enable, CLK, a_R_out, a_G_out, a_B_out);
	  m: sprite_printer port map(pixel_row, pixel_col, m_row, m_col, Font_RED, Font_GREEN, Font_BLUE, Font_Multiplier, m_address, enable, CLK, m_R_out, m_G_out, m_B_out);
	  e: sprite_printer port map(pixel_row, pixel_col, e_row, e_col, Font_RED, Font_GREEN, Font_BLUE, Font_Multiplier, e_address, enable, CLK, e_R_out, e_G_out, e_B_out);
 	  o: sprite_printer port map(pixel_row, pixel_col, o_row, o_col, Font_RED, Font_GREEN, Font_BLUE, Font_Multiplier, o_address, enable, CLK, o_R_out, o_G_out, o_B_out);
	  v: sprite_printer port map(pixel_row, pixel_col, v_row, v_col, Font_RED, Font_GREEN, Font_BLUE, Font_Multiplier, v_address, enable, CLK, v_R_out, v_G_out, v_B_out);
	  e1: sprite_printer port map(pixel_row, pixel_col, e1_row, e1_col, Font_RED, Font_GREEN, Font_BLUE, Font_Multiplier, e1_address, enable, CLK, e1_R_out, e1_G_out, e1_B_out);
	  r: sprite_printer port map(pixel_row, pixel_col, r_row, r_col, Font_RED, Font_GREEN, Font_BLUE, Font_Multiplier, r_address, enable, CLK, r_R_out, r_G_out, r_B_out);
		
		Red_out <= g_R_out and a_R_out and m_R_out and e_R_out and o_R_out and v_R_out and e1_R_out and r_R_out; 
		Green_out <= g_G_out and a_G_out and m_G_out and e_G_out and o_G_out and v_G_out and e1_G_out and r_G_out;
		Blue_out <= g_B_out and a_B_out and m_B_out and e_B_out and o_B_out and v_B_out and e1_B_out and r_B_out;
end architecture;
		


    
    
