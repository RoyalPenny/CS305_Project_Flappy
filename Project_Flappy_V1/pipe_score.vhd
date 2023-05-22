
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_SIGNED.all;
use ieee.numeric_std.all;

entity pipe_score is
port(pixel_column : in std_logic_vector(9 downto 0);
      x_pos: in std_logic_vector(10 downto 0);
     vert_sync :in std_logic;
     output :out std_logic);
end entity pipe_score;

architecture logic of pipe_score is
begin
process(vert_sync)
begin
if(rising_Edge(vert_sync)) then
           if(x_pos + pixel_column = 119) then
               output <= '1';
              else 
                output <= '0';
            end if;

end if;
end process;
end architecture;