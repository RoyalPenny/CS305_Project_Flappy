library IEEE;
use  IEEE.STD_LOGIC_1164.all;
use  IEEE.STD_LOGIC_ARITH.all;
use  IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY coll_detect is
  	PORT (
		clk, bouncy_ball_on, pipe_1_on, pipe_2_on, pipe_3_on, ground_strike, rst, disable : IN std_logic;
		input : OUT std_logic
	);	
end coll_detect;

ARCHITECTURE Behaviour of coll_detect is  

 signal input_latch : std_logic := '0';
 
begin
  
    process(clk)
    begin
      
        if (rising_edge(clk)) then
          
          if(((bouncy_ball_on = '1' and (pipe_1_on = '1' or pipe_2_on = '1' or pipe_3_on = '1')) or ground_strike = '0') and input_latch = '1') then 
            input <= '1';
            input_latch <= '0';
          else
            if(disable = '0') then
              input <= '0';
              input_latch <= '1';
            end if;
          end if;
        end if;     
    end process;
end architecture;

