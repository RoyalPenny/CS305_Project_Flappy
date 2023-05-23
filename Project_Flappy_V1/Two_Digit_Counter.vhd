library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Two_Digit_Counter is
    port (Clk, Init, Enable : in std_logic;
          tenth_out, first_out : out std_logic_vector(3 downto 0)
    );
end entity;

architecture behaviour of Two_Digit_Counter is

signal f_direction : std_logic := '1';
signal tenth_enable : std_logic := '0';
signal s_tenth_out : std_logic_vector(3 downto 0) := "0000";
signal s_first_out : std_logic_vector(3 downto 0) := "0000";


component Four_bit_Counter is
    port (Clk, Direction, Init, Enable : in std_logic;
          Q_out : out std_logic_vector(3 downto 0));
end component Four_bit_Counter;

begin
	tenth_counter : Four_bit_Counter port map(Clk, f_direction, Init, tenth_enable, s_tenth_out);
	first_counter : Four_bit_Counter port map(Clk, f_direction, Init, Enable, s_first_out);

	tenth_enable <= '1' when s_first_out = "1001" else
			'0';

	tenth_out <= s_tenth_out;
	first_out <= s_first_out;

end architecture;