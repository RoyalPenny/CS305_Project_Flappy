library IEEE;
use  IEEE.STD_LOGIC_1164.all;
use  IEEE.STD_LOGIC_ARITH.all;
use  IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY coll_detect is
  	PORT (
		clk, bouncy_ball_on, pipe_1_on, pipe_2_on, pipe_3_on, coin1, coin2, coin3, coin_rst1, coin_rst2, coin_rst3, ground_strike, rst, disable : IN std_logic;
		input, coin_input1, coin_input2, coin_input3 : OUT std_logic
	);	
end coll_detect;

ARCHITECTURE Behaviour of coll_detect is  

 signal input_latch, coin_latch1, coin_latch2, coin_latch3 : std_logic := '0';
 
begin
  
    process(clk)
    begin
      
        if (rising_edge(clk)) then
          
          if(bouncy_ball_on = '1' and coin1 = '1' and coin_latch1 = '1') then 
            coin_input1 <= '0';
            coin_latch1 <= '0';
          elsif(coin_rst1 = '1') then
            coin_latch1 <= '1';
            coin_input1 <= '1'; 
          end if;
          
          if(bouncy_ball_on = '1' and coin2 = '1' and coin_latch2 = '1') then 
            coin_input2 <= '0';
            coin_latch2 <= '0';
          elsif(coin_rst2 = '1') then
            coin_latch2 <= '1';
            coin_input2 <= '1'; 
          end if;
          
          if(bouncy_ball_on = '1' and coin3 = '1' and coin_latch3 = '1') then 
            coin_input3 <= '0';
            coin_latch3 <= '0';
          elsif(coin_rst3 = '1') then
            coin_latch3 <= '1';
            coin_input3 <= '1'; 
          end if;
          
          if(((bouncy_ball_on = '1' and (pipe_1_on = '1' or pipe_2_on = '1' or pipe_3_on = '1')) or ground_strike = '0') and input_latch = '1') then 
            input <= '1';
            input_latch <= '0';
          elsif(disable = '0') then
              input <= '0';
              input_latch <= '1';
          end if;
        end if;     
    end process;
end architecture;

