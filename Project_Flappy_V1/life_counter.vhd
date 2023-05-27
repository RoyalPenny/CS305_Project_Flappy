library IEEE;
use  IEEE.STD_LOGIC_1164.all;
use  IEEE.STD_LOGIC_ARITH.all;
use  IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY life_counter is
  	PORT (
		clk, rst, dir, input : IN std_logic;
		pixel_row, pixel_col : IN std_logic_vector(9 downto 0);
		red, green, blue, over : OUT std_logic
	);	
end life_counter;

ARCHITECTURE Behaviour of life_counter is
  
		component sprite_printer is
       port(pixel_row, pixel_col, anchor_row, anchor_col : in std_logic_vector(9 downto 0);
       sprite_red, sprite_green, sprite_blue : in std_logic;
       multiplier : in integer range 1 to 4;
       address : in std_logic_vector (5 downto 0);
       enable, clk : in std_logic;
       red_out, green_out, blue_out : out std_logic);
    end component;
    
    component Four_bit_Counter is
       port (clk, Direction, Init, Enable : in std_logic;
       Q_out : out std_logic_vector(3 downto 0));
    end component Four_bit_Counter;
    
    signal count_enable : std_logic;
    
    signal t_add_in : std_logic_vector(5 downto 0);
    signal t_count_out : std_logic_vector(3 downto 0);
    signal t_sprite_enable : std_logic := '1';
    signal t_sprite_multiplier : integer range 1 to 4 := 3;   
    signal t_sprite_red : std_logic := '0';
    signal t_sprite_green : std_logic := '1';
    signal t_sprite_blue : std_logic := '1';
    signal t_sprite_anchor_row : std_logic_vector(9 downto 0) := conv_std_logic_vector(68, 10);
    signal t_sprite_anchor_col : std_logic_vector(9 downto 0) := conv_std_logic_vector(540, 10); 
    signal t_sprite_red_out, t_sprite_green_out, t_sprite_blue_out : std_logic;           
    
begin
   sprite_design: sprite_printer port map(pixel_row, pixel_col, 
                                           t_sprite_anchor_row, t_sprite_anchor_col,
                                           t_sprite_red, t_sprite_green, t_sprite_blue,
                                           t_sprite_multiplier, t_add_in,
                                           t_sprite_enable, clk,                           
                                           t_sprite_red_out, t_sprite_green_out, t_sprite_blue_out);
                                           
   counter : Four_bit_Counter port map(clk, dir, rst, input, t_count_out);
     
   red <= t_sprite_red_out;
   green <= t_sprite_green_out;
   blue <= t_sprite_blue_out;
   
   t_add_in <= "11" & t_count_out;
        
   over <= '1' when (t_count_out = "0000") else
           '0';   
                                                                                                                              
end architecture;


