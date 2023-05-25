LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_UNSIGNED.all;


entity game_end is
  port (pixel_row, pixel_col : in std_logic_vector(9 downto 0);
        Enable, CLK : in std_logic;
        game_end_out: out std_logic);
end entity game_end;

architecture a1 of game_end is 
  signal font_row : std_logic_vector(2 downto 0) := "000"; --row 0 is the top row
  signal font_col : std_logic_vector(2 downto 0) := "000"; --col 0 is the far right col
  signal cr_out,init : std_logic;
  signal tenth_out,first_out : std_logic_vector(3 downto 0);
  signal display1,display2 :std_logic_vector(6 downto 0);
  signal character_address : std_logic_vector(5 downto 0);
  
  component CHAR_ROM is 
    port (character_address	:	in std_logic_vector (5 downto 0);
		      font_row, font_col	:	in std_logic_vector (2 downto 0);
		      clock				: 	in std_logic ;
		      rom_mux_output		:	out std_logic);
	end component;

 component Two_Digit_Counter is
      port (clk, Init, Enable : in std_logic;
          tenth_out, first_out : out std_logic_vector(3 downto 0);
          display1, display2 : out std_logic_vector(6 downto 0)
       );
end component;

begin
  SPRITE_ROM:CHAR_ROM port map (character_address => character_address, font_row => font_row, font_col => font_col,  clock => clk, rom_mux_output => cr_out);
  digit_rom: Two_Digit_Counter port map(clk=>clk,Init=>Init,Enable=>Enable,tenth_out=>tenth_out,first_out=>first_out,display1=>display1,display2=>display2);
  
  process (clk)
    begin
         if(rising_edge(clk) and Enable = '1') then
             if (pixel_row >= CONV_STD_LOGIC_VECTOR(160,10) and pixel_row < CONV_STD_LOGIC_VECTOR(192,10)
	     and pixel_col >= CONV_STD_LOGIC_VECTOR(224,10) and pixel_col < CONV_STD_LOGIC_VECTOR(256,10)) then 
             character_address <= "010111"; -- S
             cr_out <= '1';
          
          elsif( pixel_row >=  CONV_STD_LOGIC_VECTOR(192,10) and pixel_row <  CONV_STD_LOGIC_VECTOR(224,10) 
	   and pixel_col >=  CONV_STD_LOGIC_VECTOR(224,10) and pixel_col <  CONV_STD_LOGIC_VECTOR(256,10)) then
              character_address <="000011"; -- C
              cr_out <= '1';
  

          elsif( pixel_row >=  CONV_STD_LOGIC_VECTOR(224,10) and pixel_row <  CONV_STD_LOGIC_VECTOR(256,10) 
	    and pixel_col >=  CONV_STD_LOGIC_VECTOR(224,10) and pixel_col <  CONV_STD_LOGIC_VECTOR(256,10)) then
              character_address <="010001"; -- 0
              cr_out <= '1';
 
         elsif( pixel_row >=  CONV_STD_LOGIC_VECTOR(256,10) and pixel_row <  CONV_STD_LOGIC_VECTOR(288,10) 
	   and pixel_col >=  CONV_STD_LOGIC_VECTOR(224,10) and pixel_col <  CONV_STD_LOGIC_VECTOR(256,10)) then
              character_address <="010010"; -- R
              cr_out <= '1';

         elsif (pixel_row >= CONV_STD_LOGIC_VECTOR(288,10) and pixel_row < CONV_STD_LOGIC_VECTOR(320,10)
	     and pixel_col >= CONV_STD_LOGIC_VECTOR(224,10) and pixel_col < CONV_STD_LOGIC_VECTOR(256,10)) then 
             character_address <= "000101"; -- E
             cr_out <= '1';

         elsif (pixel_row >= CONV_STD_LOGIC_VECTOR(320,10) and pixel_row < CONV_STD_LOGIC_VECTOR(352,10)
	     and pixel_col >= CONV_STD_LOGIC_VECTOR(224,10) and pixel_col < CONV_STD_LOGIC_VECTOR(256,10)) then 
             character_address <= display1+"111100"; -- displays the data using the mif table 0 to 9;
             cr_out <= '1';
         elsif (pixel_row >= CONV_STD_LOGIC_VECTOR(352,10) and pixel_row < CONV_STD_LOGIC_VECTOR(388,10)
	     and pixel_col >= CONV_STD_LOGIC_VECTOR(224,10) and pixel_col < CONV_STD_LOGIC_VECTOR(256,10)) then 
             character_address <= display2+"111100"; -- e.g if display is 5 then character address is 60 + 5 = 65 or character 5
             cr_out <= '1';

--- bottom line

        elsif (pixel_row >= CONV_STD_LOGIC_VECTOR(96,10) and pixel_row < CONV_STD_LOGIC_VECTOR(128,10)
	     and pixel_col >= CONV_STD_LOGIC_VECTOR(192,10) and pixel_col < CONV_STD_LOGIC_VECTOR(224,10)) then 
             character_address <= "000011"; -- c
             cr_out <= '1';

        elsif (pixel_row >= CONV_STD_LOGIC_VECTOR(128,10) and pixel_row < CONV_STD_LOGIC_VECTOR(160,10)
	     and pixel_col >= CONV_STD_LOGIC_VECTOR(192,10) and pixel_col < CONV_STD_LOGIC_VECTOR(224,10)) then 
             character_address <= "001110"; -- l
             cr_out <= '1';

        elsif (pixel_row >= CONV_STD_LOGIC_VECTOR(160,10) and pixel_row < CONV_STD_LOGIC_VECTOR(192,10)
	     and pixel_col >= CONV_STD_LOGIC_VECTOR(192,10) and pixel_col < CONV_STD_LOGIC_VECTOR(224,10)) then 
             character_address <= "001011"; -- i
             cr_out <= '1';
elsif (pixel_row >= CONV_STD_LOGIC_VECTOR(192,10) and pixel_row < CONV_STD_LOGIC_VECTOR(224,10)
	     and pixel_col >= CONV_STD_LOGIC_VECTOR(192,10) and pixel_col < CONV_STD_LOGIC_VECTOR(224,10)) then 
             character_address <= "000011"; -- c
             cr_out <= '1';


       elsif (pixel_row >= CONV_STD_LOGIC_VECTOR(224,10) and pixel_row < CONV_STD_LOGIC_VECTOR(256,10)
	     and pixel_col >= CONV_STD_LOGIC_VECTOR(192,10) and pixel_col < CONV_STD_LOGIC_VECTOR(224,10)) then 
             character_address <= "001101"; -- k
             cr_out <= '1';

      elsif (pixel_row >= CONV_STD_LOGIC_VECTOR(256,10) and pixel_row < CONV_STD_LOGIC_VECTOR(288,10)
	     and pixel_col >= CONV_STD_LOGIC_VECTOR(192,10) and pixel_col < CONV_STD_LOGIC_VECTOR(224,10)) then 
             character_address <= "101000"; -- " "
             cr_out <= '1';

       elsif (pixel_row >= CONV_STD_LOGIC_VECTOR(288,10) and pixel_row < CONV_STD_LOGIC_VECTOR(320,10)
	     and pixel_col >= CONV_STD_LOGIC_VECTOR(192,10) and pixel_col < CONV_STD_LOGIC_VECTOR(224,10)) then 
             character_address <= "011000"; -- t
             cr_out <= '1';

      elsif (pixel_row >= CONV_STD_LOGIC_VECTOR(320,10) and pixel_row < CONV_STD_LOGIC_VECTOR(352,10)
	     and pixel_col >= CONV_STD_LOGIC_VECTOR(192,10) and pixel_col < CONV_STD_LOGIC_VECTOR(224,10)) then 
             character_address <= "010001"; -- o
             cr_out <= '1';

      elsif (pixel_row >= CONV_STD_LOGIC_VECTOR(96,10) and pixel_row < CONV_STD_LOGIC_VECTOR(128,10)
	     and pixel_col >= CONV_STD_LOGIC_VECTOR(160,10) and pixel_col < CONV_STD_LOGIC_VECTOR(192,10)) then 
             character_address <= "010010"; -- r
             cr_out <= '1';

       elsif (pixel_row >= CONV_STD_LOGIC_VECTOR(128,10) and pixel_row < CONV_STD_LOGIC_VECTOR(160,10)
	     and pixel_col >= CONV_STD_LOGIC_VECTOR(160,10) and pixel_col < CONV_STD_LOGIC_VECTOR(192,10)) then 
             character_address <= "000101"; -- e
             cr_out <= '1';

       elsif (pixel_row >= CONV_STD_LOGIC_VECTOR(160,10) and pixel_row < CONV_STD_LOGIC_VECTOR(192,10)
	     and pixel_col >= CONV_STD_LOGIC_VECTOR(160,10) and pixel_col < CONV_STD_LOGIC_VECTOR(192,10)) then 
             character_address <= "010011"; -- s
             cr_out <= '1';

       elsif (pixel_row >= CONV_STD_LOGIC_VECTOR(192,10) and pixel_row < CONV_STD_LOGIC_VECTOR(224,10)
	     and pixel_col >= CONV_STD_LOGIC_VECTOR(160,10) and pixel_col < CONV_STD_LOGIC_VECTOR(192,10)) then 
             character_address <= "010100"; -- t
             cr_out <= '1';

      elsif (pixel_row >= CONV_STD_LOGIC_VECTOR(224,10) and pixel_row < CONV_STD_LOGIC_VECTOR(256,10)
	     and pixel_col >= CONV_STD_LOGIC_VECTOR(160,10) and pixel_col < CONV_STD_LOGIC_VECTOR(192,10)) then 
             character_address <= "000001"; -- a
             cr_out <= '1';

       elsif (pixel_row >= CONV_STD_LOGIC_VECTOR(256,10) and pixel_row < CONV_STD_LOGIC_VECTOR(288,10)
	     and pixel_col >= CONV_STD_LOGIC_VECTOR(160,10) and pixel_col < CONV_STD_LOGIC_VECTOR(192,10)) then 
             character_address <= "010010"; -- r
             cr_out <= '1';

       elsif (pixel_row >= CONV_STD_LOGIC_VECTOR(288,10) and pixel_row < CONV_STD_LOGIC_VECTOR(320,10)
	     and pixel_col >= CONV_STD_LOGIC_VECTOR(160,10) and pixel_col < CONV_STD_LOGIC_VECTOR(192,10)) then 
             character_address <= "010100"; -- t
             cr_out <= '1';

          else 
            cr_out <= '0';
          end if; 
         end if;
      
  end process;
        font_row<=pixel_row(4 downto 2);
	font_col<=pixel_col(4 downto 2); 
        game_end_out<=cr_out;
end architecture; 