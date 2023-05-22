LIBRARY IEEE;
USE  IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY FlappyScore IS

   PORT( output, Clk : in std_logic;
		pixel_row, pixel_column : in std_logic_vector(9 downto 0);
		score		: out std_logic_vector(12 downto 0));
END FlappyScore;

architecture behaviour of FlappyScore is
component pipe_score 
port( x_pos: in std_logic_vector(10 downto 0);
      vert_sync :in std_logic;
      ones : OUT STD_LOGIC_VECTOR(3 downto 0);
      tens : out std_logic_vector(3 downto 0);
      hundreds : out std_logic_vector(3 downto 0));
end component;

        SIGNAL t_ones : std_logic_vector(3 downto 0) := "0000";
	SIGNAL t_tens : std_logic_vector(3 downto 0) := "0000";
	SIGNAL t_hundreds : std_logic_vector(3 downto 0) := "0000";

begin
counter: up_counter_score port map (x_pos,vert_sync,ones => t_ones, tens => t_tens, hundreds => t_hundreds);

process (Clk,output,pixel_row,pixel_column) 
begin
    if (rising_edge(Clk)) then
          if(input = '1') then

    end if;
score <= t_ones & t_tens & t_hundreds;
end process;


end architecture behaviour;