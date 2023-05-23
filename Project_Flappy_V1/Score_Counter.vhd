LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;

entity Score_Counter is
    port(pixel_row, pixel_col : in std_logic_vector(9 downto 0);
	 Enable, Clk, Count, Reset : in std_logic;
         Red_out, Green_out, Blue_out : out std_logic;
	 score_out : out std_logic_vector(3 downto 0));
end entity Score_Counter;

architecture a1 of Score_Counter is

-- Signals for 2 digit counter
signal s_tenth_out : std_logic_vector(3 downto 0);
signal s_first_out : std_logic_vector(3 downto 0);
signal s_tenth_address : std_logic_vector(5 downto 0);
signal s_first_address : std_logic_vector(5 downto 0);

-- Signals for Sprite printing
signal tenth_anchor_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(8, 10);
signal tenth_anchor_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(560, 10);
signal first_anchor_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(8, 10);
signal first_anchor_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(600, 10);
signal tenth_R_out, tenth_G_out, tenth_B_out, first_R_out, first_G_out ,first_B_out : std_logic;

-- Font Specs
Signal Font_RED : std_logic := '1';
Signal Font_GREEN : std_logic := '1';
Signal Font_BLUE : std_logic := '0';

Signal Font_Multiplier : integer := 3;



Component Two_Digit_Counter is	
    port (Clk, Init, Enable : in std_logic;
          tenth_out, first_out : out std_logic_vector(3 downto 0));
end Component;

component Sprite_Printer is	
  port(pixel_row, pixel_col, anchor_row, anchor_col : in std_logic_vector(9 downto 0);
       sprite_red, sprite_green, sprite_blue : in std_logic;
       multiplier : in integer range 1 to 4;
       address : in std_logic_vector (5 downto 0);
       enable, clk : in std_logic;
       red_out, green_out, blue_out : out std_logic);
end component Sprite_printer;

	begin
		counter: Two_Digit_Counter port map(CLK, Reset, Count, s_tenth_out, s_first_out); -- This is the tenth digit counter, that counts from 0 to 99.
		Tenth_digit: sprite_printer port map(pixel_row, pixel_col, tenth_anchor_row, tenth_anchor_col, Font_RED, Font_GREEN, Font_BLUE, Font_Multiplier, s_tenth_address, Enable, CLK, tenth_R_out, tenth_G_out, tenth_B_out);
		First_digit: sprite_printer port map(pixel_row, pixel_col, first_anchor_row, first_anchor_col, Font_RED, Font_GREEN, Font_BLUE, Font_Multiplier, s_first_address, Enable, CLK, first_R_out, first_G_out ,first_B_out);
		
		s_tenth_address <= "11" & s_tenth_out;
		s_first_address <= "11" & s_first_out;
		
		Red_out <= tenth_R_out or first_R_out; 
		Green_out <= tenth_G_out or first_G_out;
		Blue_out <= tenth_B_out or first_B_out;

		score_out <= s_tenth_out;
end a1;
		


    
    