library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity test_text_printer is
end entity;

architecture test of test_text_printer is 

 -- Test Signals
signal pixel_row, pixel_col, anchor_row, anchor_col :std_logic_vector(9 downto 0);
signal multiplier : std_logic_vector(2 downto 0);
signal character : std_logic_vector (5 downto 0);
signal clk : std_logic;
signal rom_mux_output : std_logic);

 -- testing component
component text_printer is
  port(pixel_row, pixel_col, anchor_row, anchor_col : in std_logic_vector(9 downto 0);
       multiplier : in std_logic_vector(2 downto 0);
       character : in std_logic_vector (5 downto 0);
       clk : in std_logic;
       rom_mux_output : out std_logic);
end component;

  begin
    DUT: text_printer port(pixel_row => pixel_row, pixel_col => pixel_col, anchor_row => anchor_row, anchor_col => anchor_col, 
                           multiplier => multiplier, character => character, clk => clk, rom_mux_output => rom_mux_output);
           init: process 
       begin  
          -- enable signal 
          t_Mode <= "00", "01" after 20 ns, "10" after 40 ns, "11" after 60 ns;
          t_Reset <= '1', '0' after 2 ns, '1' after 32 ns, '0' after 33 ns;
          t_Enable <= '1', '0' after 5 ns, '1' after 7 ns;
          wait for 80 ns;
       end process init; 
      
       
       -- Clock Generation, 100Mhz
       clk_gen:process
       begin 
         clk <= '1';
         wait for 500 ps;
         clk <= '0';
         wait for 500 ps;
       end process clk_gen;
      

end architecture test; 