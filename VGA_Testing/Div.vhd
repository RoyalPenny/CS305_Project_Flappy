library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity Div is
        port (CLK : in std_logic;
          clkDiv : out std_logic);
end entity Div;
 
architecture behaviour of Div is 
  signal t_clkDiv : std_logic := '0';
  
begin
  
  t_clkDiv <= not t_clkDiv when rising_edge(CLK);

  clkDiv <= t_clkDiv;
    
end architecture behaviour; 