
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_SIGNED.all;
use ieee.numeric_std.all;

entity pipe_score is
port(
      x_pos: in std_logic_vector(10 downto 0);
      vert_sync :in std_logic;
      ones : OUT STD_LOGIC_VECTOR(3 downto 0);
      tens : out std_logic_vector(3 downto 0);
      hundreds : out std_logic_vector(3 downto 0);
end entity pipe_score;

architecture logic of pipe_score is
        SIGNAL t_ones : std_logic_vector(3 downto 0) := "0000";
	SIGNAL t_tens : std_logic_vector(3 downto 0) := "0000";
	SIGNAL t_hundreds : std_logic_vector(3 downto 0) := "0000";
	
begin
process(vert_sync)
begin
if(rising_Edge(vert_sync)) then
           if(x_pos >= CONV_STD_LOGIC_VECTOR(320,11)) then
               t_ones <= t_ones + 1;
               output <= '1';
                if(t_ones = "1010") then
                    t_ones <= "0000";
                    t_tens <= t_tens + 1;
                end if;


                if(t_tens = "1010") then
                    t_tens <= "0000";
                    t_hundreds <= t_hundreds + 1;
                end if;
            else
               output <= '0';
            end if;

end if;
                ones <= std_logic_vector(t_ones);
		tens <= std_logic_vector(t_tens);
		hundreds <= std_logic_vector(t_hundreds);
end process;
end architecture;