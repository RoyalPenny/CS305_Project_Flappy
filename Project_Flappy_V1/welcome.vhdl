LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_UNSIGNED.all;

entity welcome is
  port (pixel_row, pixel_col : in std_logic_vector(9 downto 0);
        Enable, CLK : in std_logic;
        Red_Out, Green_Out, Blue_Out: out std_logic);
end entity welcome;

architecture a1 of welcome is 
  signal s_font_row : std_logic_vector(2 downto 0) := "000"; --row 0 is the top row
  signal s_font_col : std_logic_vector(2 downto 0) := "000"; --col 0 is the far right col
  signal s_rom_mux_output : std_logic;
  
  component CHAR_ROM is 
    port (character_address	:	in std_logic_vector (5 downto 0);
		      font_row, font_col	:	in std_logic_vector (2 downto 0);
		      clock				: 	in std_logic ;
		      rom_mux_output		:	out std_logic);
	end component;

begin
end architecture;  
  