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
begin
  
  