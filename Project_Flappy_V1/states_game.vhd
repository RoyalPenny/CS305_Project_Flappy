library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity states_game is
    port (
		clk: in std_logic;
		pixel_column, pixel_row : in std_logic_vector(9 downto 0);
		mouse_y_pos, mouse_x_pos : in std_logic_vector(9 downto 0);
		left_click : in std_logic;		
		state_out: out std_logic_vector (1 downto 0);
		enable, reset : out std_logic;
		collision: in std_logic
    );
end entity states_game;

architecture FSM of states_game is 
	type state_type is (s_welcome, s_game, s_training, s_endgame);
	signal state, next_state 
        variable state_type := s_game;

begin
	process
	begin 
		wait until rising_edge(clk);
		state_game<=next_state;
		
		case state is 
			when s_welcome =>
				if left_button ='1' then 

						next_state<=s_training;
				else
					next_state<=s_welcome;
				end if;
			when s_game=>
				if collision ='1' then
					next_state<=s_endgame;
				else 
					next_state<=s_game;
				end if;
			when s_training=>
				if collision ='1' then
					next_state<=s_endgame;
				else 
					next_state<=s_training;
				end if;
			when s_endgame=>
				if left_button = '1' then 
						next_state<=s_welcome;
				else 
					next_state<=s_endgame;
				end if ;
		end case;
	end process;
	
	 process
	begin 
		wait until rising_edge(clk);
			case state is 
				when s_welcome =>
					enable<='0';
					reset <='1';
					state_out<="00";
				when s_game=>
					enable<='1';
					reset <='0';
					state_out<="01";
				when s_training=>
					enable<='1';
					reset <='0';
					state_out<="10";
				when s_endgame=>
					enable<='0';
					reset <='0';
					state_out<="11";
			end case;
	end process;
	

end architecture FSM;