LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;

entity Score_Counter is
    port(Enable, Clk, Count : in std_logic;
         Red_out, Green_out, Blue_out : out std_logic);
end entity Score_Counter;

architecture a1 of Score_Counter is
  begin
    
    