library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity score is
        port (CLK, Start : in std_logic;
          Data_In : in std_logic_vector(9 downto 0);
          reset_score : out std_logic);
end entity score;
 
architecture behaviour of score is  
  signal t_Init1, t_Init2, t_Init3, t_tens, t_ones1, t_Enable, t_ones2, t_start, clkDiv, tt_Enable : std_logic;
  signal display1, display2, display3 : std_logic_vector(6 downto 0);
  signal prev_data : std_logic_vector(6 downto 0);
  signal Q1, Q2, Q3, tens, ones1, ones2 : std_logic_vector (3 downto 0);
  
  component BCD_counter is
    port (CLK, start_score, Enable, Init : in std_logic;
      Q : out std_logic_vector(3 downto 0));
  end component;
  
  component BCD_to_SevenSeg is
    port (BCD_digit : in std_logic_vector(3 downto 0);
      SevenSeg_out : out std_logic_vector(6 downto 0));
  end component BCD_to_SevenSeg;

  component Div is
    port (CLK, Reset : in std_logic;
      clkDiv : out std_logic);
  end component Div;
  
begin
  clk_Hz: Div port map (CLK => CLK, Reset => Start, clkDiv => clkDiv);  
  
  c_tens: BCD_counter port map (CLK => clkDiv, start_score => t_start, Enable => t_tens, Init => t_Init1, Q => Q1);
  c_ones1: BCD_counter port map (CLK => clkDiv, start_score => t_start, Enable => t_ones1, Init => t_Init2, Q => Q2);
  c_ones2: BCD_counter port map (CLK => clkDiv, start_score => t_start, Enable => t_ones2, Init => t_Init3, Q => Q3);
  
  d_tens: BCD_to_SevenSeg port map (BCD_digit => Q1, SevenSeg_out => display1);
  d_ones1: BCD_to_SevenSeg port map (BCD_digit => Q2, SevenSeg_out => display2);
  d_ones2: BCD_to_SevenSeg port map (BCD_digit => Q3, SevenSeg_out => display3);
  
  t_ones2 <= t_Enable;
  t_start <= '1';
  
  main: process(clkDiv, t_Enable, Q1, Q2, Q3, Start, tens, ones1, ones2)
    
    begin         
      if (Start = '1') then
        tt_Enable <= '1';
        t_Init1 <= '1';
        t_Init2 <= '1';
        t_Init3 <= '1';
        reset_score <= '0';   
        
      elsif (rising_edge(clkDiv) and t_Enable = '1') then
        t_Init1 <= '0'; 
        t_Init2 <= '0';
        t_Init3 <= '0'; 
        
        if(Q1 = tens and Q2 = ones1 and Q3 = ones2) then   
          tt_Enable <= '0'; 
          t_ones1 <= '0';
          t_tens <= '0';
          reset_score <= '1';
        end if;
                   
        if (Q3 = "1000") then
          t_ones1 <= '1';
        else 
          t_ones1 <= '0';
        end if;
        
        if (Q2 = "0101" and Q3 = "1001") then
          t_tens <= '1';
          t_Init2 <= '1';
        else
          t_tens <= '0';
          t_Init2 <= '0';
        end if;
      end if;          
  end process main; 
  
  t_Enable <= tt_Enable;
  
  dataIn: process(start, Data_In)
  begin
    tens <= "00" & Data_In(9 downto 8);
    ones1 <= Data_In(7 downto 4);
    ones2 <= Data_In(3 downto 0);
    prev_data <= Data_in;
    
    if(Data_In(9 downto 8) > "11" and start = '1') then
      tens <= "0011";
    end if;
    
    if(Data_In(7 downto 4) > "0101" and start = '1') then
      ones1 <= "0101";
    end if;
    
    if(Data_In(3 downto 0) > "1001" and start = '1') then
      ones2 <= "1001";
    end if;
 

if(prev_data = "0000000000") then

end if


  end process dataIn;
end architecture behaviour; 





