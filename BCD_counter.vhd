library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity BCD_counter is 
  port (CLK, start_score, Enable, Init : in std_logic;
        Q : out std_logic_vector(3 downto 0));
end entity BCD_counter;
 
architecture behaviour of BCD_counter is     

begin
  process(CLK)
      variable v_Q: std_logic_vector(3 downto 0);
    begin
      
      if (rising_edge(CLK) and Init = '1') then
        case start_score is 
          when '0' => v_Q := "1001";
          when '1' => v_Q := "0000";
          when others => NULL; 
        end case;
        Q <= v_Q;
        
      elsif (rising_edge(CLK) and Enable = '1') then        
        case start_score is
          when '0' => 
            if (v_Q /= "0000") then
              v_Q := "0000";
            end if;
            
          when '1' =>
            if (v_Q = "1001") then
              v_Q := "0000";
            else
              v_Q := v_Q + "0001";
            end if;
                         
          when others => NULL;            
        end case;  
        Q <= v_Q;
      end if;      
    end process;     
end architecture behaviour; 



