LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;

entity start_page is
    port(pixel_row, pixel_col : in std_logic_vector(9 downto 0);
	       Clk, enable, mode_sel  : in std_logic;  -- if mode sel is '1', its game mode/ '0' is tutorial mode
         Red_out, Green_out, Blue_out : out std_logic);

end entity start_page;

architecture behaviour of start_page is

-- Signals for 2 digit counter
signal title_f_address : std_logic_vector(5 downto 0) := "000110";
signal title_l_address : std_logic_vector(5 downto 0) := "001100";
signal title_a_address : std_logic_vector(5 downto 0) := "000001";
signal title_p_address : std_logic_vector(5 downto 0) := "010000";
signal title_p1_address : std_logic_vector(5 downto 0) := "010000";
signal title_y_address : std_logic_vector(5 downto 0) := "011001";
signal title_b_address : std_logic_vector(5 downto 0) := "000010";
signal title_i_address : std_logic_vector(5 downto 0) := "001001";
signal title_r_address : std_logic_vector(5 downto 0) := "010010";
signal title_d_address : std_logic_vector(5 downto 0) := "000100";

signal play_p_address : std_logic_vector(5 downto 0) := "010000";
signal play_l_address : std_logic_vector(5 downto 0) := "001100";
signal play_a_address : std_logic_vector(5 downto 0) := "000001";
signal play_y_address : std_logic_vector(5 downto 0) := "011001";

signal tut_t_address : std_logic_vector(5 downto 0) := "010100";
signal tut_u_address : std_logic_vector(5 downto 0) := "010101";
signal tut_t1_address : std_logic_vector(5 downto 0) := "010100";
signal tut_o_address : std_logic_vector(5 downto 0) := "001111";
signal tut_r_address : std_logic_vector(5 downto 0) := "010010";
signal tut_i_address : std_logic_vector(5 downto 0) := "001001";
signal tut_a_address : std_logic_vector(5 downto 0) := "000001";
signal tut_l_address : std_logic_vector(5 downto 0) := "001100";

-- Signals for Sprite printing 
-- F L A P P Y B I R D
signal title_f_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(120, 10);
signal title_f_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(48, 10);
signal title_l_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(120, 10);
signal title_l_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(144, 10);
signal title_a_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(120, 10);
signal title_a_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(240, 10);
signal title_p_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(120, 10);
signal title_p_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(335, 10);
signal title_p1_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(120, 10);
signal title_p1_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(432, 10);
signal title_y_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(120, 10);
signal title_y_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(528, 10);
signal title_b_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(200, 10);
signal title_b_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(144, 10);
signal title_i_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(200, 10);
signal title_i_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(240, 10);
signal title_r_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(200, 10);
signal title_r_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(335, 10);
signal title_d_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(200, 10);
signal title_d_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(432, 10);

-- P L A Y
signal play_p_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(320, 10);
signal play_p_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(240, 10);
signal play_l_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(320, 10);
signal play_l_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(280,10);
signal play_a_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(320, 10);
signal play_a_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(320, 10);
signal play_y_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(320, 10);
signal play_y_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(360, 10);


-- T U T O R I A L
signal tut_t_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(400, 10);
signal tut_t_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(160, 10);
signal tut_u_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(400, 10);
signal tut_u_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(200,10);
signal tut_t1_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(400, 10);
signal tut_t1_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(240, 10);
signal tut_o_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(400, 10);
signal tut_o_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(280, 10);
signal tut_r_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(400, 10);
signal tut_r_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(320, 10);
signal tut_i_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(400, 10);
signal tut_i_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(360, 10);
signal tut_a_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(400, 10);
signal tut_a_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(400,10);
signal tut_l_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(400, 10);
signal tut_l_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(440, 10);


-- Flappy BIRD RGB
signal title_f_R_out, title_f_G_out, title_f_B_out,
       title_l_R_out, title_l_G_out, title_l_B_out,
       title_a_R_out, title_a_G_out, title_a_B_out,
       title_p_R_out, title_p_G_out, title_p_B_out,
       title_p1_R_out, title_p1_G_out, title_p1_B_out,
       title_y_R_out, title_y_G_out, title_y_B_out,
       title_b_R_out, title_b_G_out, title_b_B_out,
       title_i_R_out, title_i_G_out, title_i_B_out,
       title_r_R_out, title_r_G_out, title_r_B_out,
       title_d_R_out, title_d_G_out, title_d_B_out : std_logic;
       
-- Play RGB
signal play_P_R_out, play_p_G_out, play_p_B_out,
       play_L_R_out, play_l_G_out, play_l_B_out,
       play_A_R_out, play_a_G_out, play_a_B_out,
       play_Y_R_out, play_y_G_out, play_y_B_out: std_logic;
       
-- PLAY RGB
signal tut_T_R_out, tut_T_G_out, tut_T_B_out,
       tut_U_R_out, tut_U_G_out, tut_U_B_out,
       tut_T1_R_out, tut_T1_G_out, tut_T1_B_out,
       tut_O_R_out, tut_O_G_out, tut_O_B_out,
       tut_R_R_out, tut_R_G_out, tut_R_B_out,
       tut_I_R_out, tut_I_G_out, tut_I_B_out,
       tut_A_R_out, tut_A_G_out, tut_A_B_out,
       tut_L_R_out, tut_L_G_out, tut_L_B_out : std_logic;

       

-- Font Specs
Signal Font_RED : std_logic := '1';
Signal Font_GREEN : std_logic := '1';
Signal Font_BLUE : std_logic := '1';

Signal play_RED : std_logic := '1';
Signal tut_RED : std_logic := '1';

Signal Font_Multiplier : integer := 4;
signal select_multiplier : integer := 3;

component Sprite_Printer is	
  port(pixel_row, pixel_col, anchor_row, anchor_col : in std_logic_vector(9 downto 0);
       sprite_red, sprite_green, sprite_blue : in std_logic;
       multiplier : in integer range 1 to 4;
       address : in std_logic_vector (5 downto 0);
       enable, clk : in std_logic;
       red_out, green_out, blue_out : out std_logic);
end component Sprite_printer;

	begin
    title_f: sprite_printer port map(pixel_row, pixel_col, title_f_row, title_f_col, Font_RED, Font_GREEN, Font_BLUE, Font_Multiplier, title_f_address, enable, CLK, title_f_R_out, title_f_G_out, title_f_B_out);
	  title_l: sprite_printer port map(pixel_row, pixel_col, title_l_row, title_l_col, Font_RED, Font_GREEN, Font_BLUE, Font_Multiplier, title_l_address, enable, CLK, title_l_R_out, title_l_G_out, title_l_B_out);
	  title_a: sprite_printer port map(pixel_row, pixel_col, title_a_row, title_a_col, Font_RED, Font_GREEN, Font_BLUE, Font_Multiplier, title_a_address, enable, CLK, title_a_R_out, title_a_G_out, title_a_B_out);
	  title_p: sprite_printer port map(pixel_row, pixel_col, title_p_row, title_p_col, Font_RED, Font_GREEN, Font_BLUE, Font_Multiplier, title_p_address, enable, CLK, title_p_R_out, title_p_G_out, title_p_B_out);
 	  title_p1: sprite_printer port map(pixel_row, pixel_col, title_p1_row, title_p1_col, Font_RED, Font_GREEN, Font_BLUE, Font_Multiplier, title_p1_address, enable, CLK, title_p1_R_out, title_p1_G_out, title_p1_B_out);
	  title_y: sprite_printer port map(pixel_row, pixel_col, title_y_row, title_y_col, Font_RED, Font_GREEN, Font_BLUE, Font_Multiplier, title_y_address, enable, CLK, title_y_R_out, title_y_G_out, title_y_B_out);
	  title_b: sprite_printer port map(pixel_row, pixel_col, title_b_row, title_b_col, Font_RED, Font_GREEN, Font_BLUE, Font_Multiplier, title_b_address, enable, CLK, title_b_R_out, title_b_G_out, title_b_B_out);
	  title_i: sprite_printer port map(pixel_row, pixel_col, title_i_row, title_i_col, Font_RED, Font_GREEN, Font_BLUE, Font_Multiplier, title_i_address, enable, CLK, title_i_R_out, title_i_G_out, title_i_B_out);
	  title_r: sprite_printer port map(pixel_row, pixel_col, title_r_row, title_r_col, Font_RED, Font_GREEN, Font_BLUE, Font_Multiplier, title_r_address, enable, CLK, title_r_R_out, title_r_G_out, title_r_B_out);
	  title_d: sprite_printer port map(pixel_row, pixel_col, title_d_row, title_d_col, Font_RED, Font_GREEN, Font_BLUE, Font_Multiplier, title_d_address, enable, CLK, title_d_R_out, title_d_G_out, title_d_B_out);
	 
		play_p: sprite_printer port map(pixel_row, pixel_col, play_p_row, play_p_col, play_RED, Font_GREEN, Font_BLUE, select_Multiplier, play_p_address, enable, CLK, play_p_R_out, play_p_G_out, play_p_B_out);
		play_l: sprite_printer port map(pixel_row, pixel_col, play_l_row, play_l_col, play_RED, Font_GREEN, Font_BLUE, select_Multiplier, play_l_address, enable, CLK, play_l_R_out, play_l_G_out, play_l_B_out);
		play_a: sprite_printer port map(pixel_row, pixel_col, play_a_row, play_a_col, play_RED, Font_GREEN, Font_BLUE, select_Multiplier, play_a_address, enable, CLK, play_a_R_out, play_a_G_out, play_a_B_out);
		play_y: sprite_printer port map(pixel_row, pixel_col, play_y_row, play_y_col, play_RED, Font_GREEN, Font_BLUE, select_Multiplier, play_y_address, enable, CLK, play_y_R_out, play_y_G_out, play_y_B_out);

		tut_t: sprite_printer port map(pixel_row, pixel_col, tut_t_row, tut_t_col, tut_RED, Font_GREEN, Font_BLUE, select_Multiplier, tut_t_address, enable, CLK, tut_t_R_out, tut_t_G_out, tut_t_B_out);
		tut_u: sprite_printer port map(pixel_row, pixel_col, tut_u_row, tut_u_col, tut_RED, Font_GREEN, Font_BLUE, select_Multiplier, tut_u_address, enable, CLK, tut_u_R_out, tut_u_G_out, tut_u_B_out);
		tut_t1: sprite_printer port map(pixel_row, pixel_col, tut_t1_row, tut_t1_col, tut_RED, Font_GREEN, Font_BLUE, select_Multiplier, tut_t1_address, enable, CLK, tut_t1_R_out, tut_t1_G_out, tut_t1_B_out);
		tut_o: sprite_printer port map(pixel_row, pixel_col, tut_o_row, tut_o_col, tut_RED, Font_GREEN, Font_BLUE, select_Multiplier, tut_o_address, enable, CLK, tut_o_R_out, tut_o_G_out, tut_o_B_out);
		tut_r: sprite_printer port map(pixel_row, pixel_col, tut_r_row, tut_r_col, tut_RED, Font_GREEN, Font_BLUE, select_Multiplier, tut_r_address, enable, CLK, tut_r_R_out, tut_r_G_out, tut_r_B_out);
		tut_i: sprite_printer port map(pixel_row, pixel_col, tut_i_row, tut_i_col, tut_RED, Font_GREEN, Font_BLUE, select_Multiplier, tut_i_address, enable, CLK, tut_i_R_out, tut_i_G_out, tut_i_B_out);
		tut_a: sprite_printer port map(pixel_row, pixel_col, tut_a_row, tut_a_col, tut_RED, Font_GREEN, Font_BLUE, select_Multiplier, tut_a_address, enable, CLK, tut_a_R_out, tut_a_G_out, tut_a_B_out);
		tut_l: sprite_printer port map(pixel_row, pixel_col, tut_l_row, tut_l_col, tut_RED, Font_GREEN, Font_BLUE, select_Multiplier, tut_l_address, enable, CLK, tut_l_R_out, tut_l_G_out, tut_l_B_out);
	
    play_RED <= not(mode_sel);
    tut_RED <= mode_sel;
	  
		Red_out <= title_f_R_out and title_l_R_out and title_a_R_out and title_p_R_out and title_p1_R_out and title_y_R_out and title_b_R_out and title_i_R_out and title_r_R_out and title_d_R_out and play_p_R_out and play_l_R_out and play_a_R_out and play_y_R_out and tut_t_R_out and tut_u_R_out and tut_t1_R_out and tut_o_R_out and tut_r_R_out and tut_i_R_out and tut_a_R_out and tut_l_R_out; 
	  Green_out <= title_f_G_out and title_l_G_out and title_a_G_out and title_p_G_out and title_p1_G_out and title_y_G_out and title_b_G_out and title_i_G_out and title_r_G_out and title_d_G_out and play_p_G_out and play_l_G_out and play_a_G_out and play_y_G_out and tut_t_G_out and tut_u_G_out and tut_t1_G_out and tut_o_G_out and tut_r_G_out and tut_i_G_out and tut_a_G_out and tut_l_G_out; 
    Blue_out <= title_f_B_out and title_l_B_out and title_a_B_out and title_p_B_out and title_p1_B_out and title_y_B_out and title_b_B_out and title_i_B_out and title_r_B_out and title_d_B_out and play_p_B_out and play_l_B_out and play_a_B_out and play_y_B_out and tut_t_B_out and tut_u_B_out and tut_t1_B_out and tut_o_B_out and tut_r_B_out and tut_i_B_out and tut_a_B_out and tut_l_B_out; 
end architecture;
		


    
    

