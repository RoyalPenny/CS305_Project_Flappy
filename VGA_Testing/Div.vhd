library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity Div is
        port (CLK : in std_logic;
          clkDiv : out std_logic);
end entity Div;
 
architecture behaviour of Div is 

  signal prescaler : std_logic_vector(1 downto 0) := "00";
  signal t_clkDiv : std_logic := '0';

begin
  process(CLK)
    begin  
      if (rising_edge(CLK)) then
        if prescaler = "01" then
          prescaler <= (others => '0');
          t_clkDiv <= not t_clkDiv;
        else
          prescaler <= prescaler + "1";
        end if;
      end if;
    end process;
    
    clkDiv <= t_clkDiv;
    
end architecture behaviour; 