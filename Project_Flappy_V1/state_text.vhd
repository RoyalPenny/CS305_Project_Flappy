use ieee.numeric_std.all;

entity state_text is 
    port (
		clk: in std_logic;
		mouse_row,mouse_column: in unsigned (9 downto 0) ;
		pixel_row,pixel_column: in std_logic_vector(9 downto 0);
		state: in std_logic_vector(1 downto 0);
		out_text: out std_logic
    );
end entity state_text;

architecture behaviour of menus is
	
	begin

	process
	begin
		wait until rising_Edge(clk);
		case state is 
			when "00"=>-- welcome state
	
			when "11"=>--endgame state

			when others=>
		end case;
		
	end process;
end architecture;