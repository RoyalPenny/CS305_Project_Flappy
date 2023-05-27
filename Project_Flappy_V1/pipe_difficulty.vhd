library IEEE;
use  IEEE.STD_LOGIC_1164.all;
use  IEEE.STD_LOGIC_ARITH.all;
use  IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY pipe_difficulty is
  	PORT (
		clk, rst, mode, level : IN std_logic;
		speed : OUT std_logic_vector(8 downto 0)
	);	
end pipe_difficulty;

ARCHITECTURE Behaviour of pipe_difficulty is
  
    signal t_speed : std_logic_vector(8 downto 0);
    signal count : std_logic_vector(3 DOWNTO 0) := conv_std_logic_vector(0, 4);
    signal level_latch : std_logic;

    
begin
  
    process(clk)
    begin
      
        if (rising_edge(clk)) then
          
          if(rst = '1') then
            t_speed <= conv_std_logic_vector(300, 9);
            level_latch <= '0';
            count <= conv_std_logic_vector(0, 4);
          end if;
          
          if(mode = '1' and level_latch = '1' and level = '1' and (t_speed > conv_std_logic_vector(50, 9))) then
            
            if(count = conv_std_logic_vector(4, 4)) then
              t_speed <= t_speed - conv_std_logic_vector(50, 9);
              count <= conv_std_logic_vector(0, 4);
              
            else
              count <= count + '1';
            end if;
            
            level_latch <= '0';
            
          elsif(level = '0') then
            level_latch <= '1';
          end if;
          
        end if;     
    end process;
    
    speed <= t_speed;
end architecture;
