LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_UNSIGNED.all;

entity SPRITE_PRINTER is
  
  -- pixel_row, pixel_col : current pixel row and column
  -- anchor_row, anchor_col : where to place the text, the top left is the anchor of the 8x8 text tile
  -- address: what character to display, please provide its address from the .mif file
  -- rom_mux_out : once character and position is set, it will send 1 or 0, according to current row and col pixel.
  
  port(pixel_row, pixel_col, anchor_row, anchor_col : in std_logic_vector(9 downto 0);
       sprite_red, sprite_green, sprite_blue : in std_logic;
       multiplier : in integer range 1 to 4;
       address : in std_logic_vector (5 downto 0);
       enable, clk : in std_logic;
       red_out, green_out, blue_out : out std_logic);
  
end SPRITE_PRINTER;

architecture a of SPRITE_PRINTER is
  
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

  SPRITE_ROM:CHAR_ROM port map (character_address => address, font_row => s_font_row, font_col => s_font_col,  clock => clk, rom_mux_output => s_rom_mux_output);
  
  process (pixel_row, anchor_row, pixel_col, anchor_col, s_rom_mux_output)
    variable P : integer range 0 to 8 := 1;
    begin
      
      s_font_row <= "XXX";
      s_font_col <= "XXX";
      
      case multiplier is
        when 1 => P := 1;
        when 2 => P := 2;
        when 3 => P := 4;
        when 4 => P := 8;
        when others => P:= 0;
      end case; 
      
      if((anchor_row <= pixel_row) and (pixel_row < (anchor_row + 8*P))) then
        if((anchor_col <= pixel_col) and (pixel_col < (anchor_col + 8*P))) then
          s_font_row <= (pixel_row(multiplier+1 downto multiplier-1) - anchor_row(multiplier+1 downto multiplier-1));
          s_font_col <= (pixel_col(multiplier+1 downto multiplier-1) - anchor_col(multiplier+1 downto multiplier-1));
        end if;
      end if;
      
      red_out <= '0';
      green_out <= s_rom_mux_output;
      blue_out <= s_rom_mux_output; 
      
  end process;   
end a;
       
