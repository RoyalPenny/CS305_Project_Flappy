library IEEE;
use  IEEE.STD_LOGIC_1164.all;
use  IEEE.STD_LOGIC_ARITH.all;
use  IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY pipe_difficulty is
  	PORT (
		rst, mode, level : IN std_logic;
		speed : OUT std_logic_vector(8 downto 0)
	);	
end pipe_difficulty;

ARCHITECTURE Behaviour of pipe_difficulty is
  
    signal t_speed : std_logic_vector(8 downto 0) := (others => '0');
    signal t_mode : std_logic_vector(8 downto 0) := (others => '0');
    signal count : std_logic_vector(3 DOWNTO 0) := (others => '0');
    
begin
  
    process(level, rst)
    begin
        
        if(rst = '1') then
          t_speed <= conv_std_logic_vector(200, 9);
        end if;
      
        if (rising_edge(level)) then
          if(mode = '1') then
            if(count = conv_std_logic_vector(8, 4)) then
              t_speed <= t_speed + conv_std_logic_vector(30, 9);
              count <= conv_std_logic_vector(0, 4);
            else
              count <= count + '1';
            end if;
          end if;
        end if;     
    end process;
    
    speed <= t_speed;
end architecture;
