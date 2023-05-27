LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;

entity Score_Counter is
    port(pixel_row, pixel_col : in std_logic_vector(9 downto 0);
         tenth, first : in std_logic_vector(3 downto 0);
	       Clk : in std_logic;
         Red_out, Green_out, Blue_out : out std_logic);

end entity Score_Counter;

architecture a1 of Score_Counter is

-- Signals for 2 digit counter
signal s_tenth_address, s_first_address : std_logic_vector(5 downto 0);
signal s_address : std_logic_vector(5 downto 0) := "010011";
signal c_address : std_logic_vector(5 downto 0) := "000011";
signal o_address : std_logic_vector(5 downto 0) := "001111";
signal r_address : std_logic_vector(5 downto 0) := "010010";
signal e_address : std_logic_vector(5 downto 0) := "000101";


-- Signals for Sprite printing
signal s_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(68, 10);
signal s_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(8, 10);
signal c_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(68, 10);
signal c_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(40, 10);
signal o_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(68, 10);
signal o_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(72, 10);
signal r_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(68, 10);
signal r_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(104, 10);
signal e_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(68, 10);
signal e_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(136, 10);


signal tenth_anchor_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(68, 10);
signal tenth_anchor_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(200, 10);
signal first_anchor_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(68, 10);
signal first_anchor_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(232, 10);
signal tenth_R_out, tenth_G_out, tenth_B_out, 
       first_R_out, first_G_out, first_B_out, 
       s_R_out, s_G_out, s_B_out,
       c_R_out, c_G_out, c_B_out,
       o_R_out, o_G_out, o_B_out,
       r_R_out, r_G_out, r_B_out,
       e_R_out, e_G_out, e_B_out : std_logic;
       
signal t_sprite_enable : std_logic := '1';

-- Font Specs
Signal Font_RED : std_logic := '0';
Signal Font_GREEN : std_logic := '1';
Signal Font_BLUE : std_logic := '1';

Signal Font_Multiplier : integer := 3;

component Sprite_Printer is	
  port(pixel_row, pixel_col, anchor_row, anchor_col : in std_logic_vector(9 downto 0);
       sprite_red, sprite_green, sprite_blue : in std_logic;
       multiplier : in integer range 1 to 4;
       address : in std_logic_vector (5 downto 0);
       enable, clk : in std_logic;
       red_out, green_out, blue_out : out std_logic);
end component Sprite_printer;

	begin
	  S: sprite_printer port map(pixel_row, pixel_col, s_row, s_col, Font_RED, Font_GREEN, Font_BLUE, Font_Multiplier, s_address, t_sprite_enable, CLK, s_R_out, s_G_out, s_B_out);
	  C: sprite_printer port map(pixel_row, pixel_col, c_row, c_col, Font_RED, Font_GREEN, Font_BLUE, Font_Multiplier, c_address, t_sprite_enable, CLK, c_R_out, c_G_out, c_B_out);
	  O: sprite_printer port map(pixel_row, pixel_col, o_row, o_col, Font_RED, Font_GREEN, Font_BLUE, Font_Multiplier, o_address, t_sprite_enable, CLK, o_R_out, o_G_out, o_B_out);
	  R: sprite_printer port map(pixel_row, pixel_col, r_row, r_col, Font_RED, Font_GREEN, Font_BLUE, Font_Multiplier, r_address, t_sprite_enable, CLK, r_R_out, r_G_out, r_B_out);
	  E: sprite_printer port map(pixel_row, pixel_col, e_row, e_col, Font_RED, Font_GREEN, Font_BLUE, Font_Multiplier, e_address, t_sprite_enable, CLK, e_R_out, e_G_out, e_B_out);
		Tenth_digit: sprite_printer port map(pixel_row, pixel_col, tenth_anchor_row, tenth_anchor_col, Font_RED, Font_GREEN, Font_BLUE, Font_Multiplier, s_tenth_address, t_sprite_enable, CLK, tenth_R_out, tenth_G_out, tenth_B_out);
		First_digit: sprite_printer port map(pixel_row, pixel_col, first_anchor_row, first_anchor_col, Font_RED, Font_GREEN, Font_BLUE, Font_Multiplier, s_first_address, t_sprite_enable, CLK, first_R_out, first_G_out, first_B_out);
		
		s_tenth_address <= "11" & tenth;
		s_first_address <= "11" & first;
		
		Red_out <= tenth_R_out and first_R_out and s_R_out and c_R_out and o_R_out and r_R_out and e_R_out; 
		Green_out <= tenth_G_out and first_G_out and s_G_out and c_G_out and o_G_out and r_G_out and e_G_out;
		Blue_out <= tenth_B_out and first_B_out and s_B_out and c_B_out and o_B_out and r_B_out and e_B_out;
end a1;
		


    
    