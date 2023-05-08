Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity counter is
  port(Mode, Enable, Reset, clk : in std_logic;
        Q : out std_logic_vector(4 downto 0));
end entity;

architecture behaviour of counter is
  signal  t_Q : std_logic_vector(4 downto 0);
  
  begin
    process(clk)
      begin
        if(rising_edge(clk)) then
          if(Reset = '1') then
            if(mode = '0') then
              t_Q <= conv_std_logic_vector(0, 5);
            elsif(mode = '1') then
              t_Q <= conv_std_logic_vector(3, 5);
            end if;
          else
            if(Mode = '0') then
              if(t_Q <= conv_std_logic_vector(20, 5)) then
                t_Q <= "00000";
              else
                t_Q <= t_Q + '1';
              end if;
            elsif(Mode = '1') then
              if(t_Q <= conv_std_logic_vector(25, 5)) then
                t_Q <= "00011";
              else
                t_Q <= t_Q + "00010";
              end if;
            end if;
            
            Q <= t_Q;
        end if;
      end if;
    end process;
end architecture;