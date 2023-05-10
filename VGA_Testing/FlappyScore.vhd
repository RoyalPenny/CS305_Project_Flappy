LIBRARY IEEE;
USE  IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY FlappyScore IS
generic(COUNTER_BITS: natural := 15);  
   PORT( Clk, reset, score, highet : IN std_logic;
            data_in: in std_logic_vector(15 downto 0);
                blank: in std_logic_vector(3 downto 0);
            Anode_signal : out STD_LOGIC_VECTOR (3 downto 0));	
END FlappyScore;

architecture behaviour of FlappyScore is
signal counter_value: std_logic_vector(COUNTER_BITS-1 downto 0) := (others=>'0'); 
signal anode_select: std_logic_vector(1 downto 0);
signal decode: std_logic_vector(3 downto 0);
signal BCD_digit : STD_LOGIC_VECTOR (3 downto 0);
signal SevenSeg_out: STD_logic_vector (6 downto 0);

COMPONENT BCD_to_SevenSeg is
	PORT( BCD_digit : in STD_LOGIC_VECTOR (3 downto 0);
            SevenSeg_out: out STD_logic_vector (6 downto 0));
end COMPONENT;
begin
dut: BCD_to_SevenSeg PORT MAP(BCD_digit, SevenSeg_out);

process (Clk) 
begin
    if (rising_edge(Clk)) then
          counter_value <= std_logic_vector(unsigned(counter_value) + 1);
    end if;
end process;
anode_select <= counter_value(COUNTER_BITS-1 downto COUNTER_BITS-2);
	
	with anode_select select
		an <=
			"111" & blank(0) when "00",  --Determines when the display should be blank (1 is blank)
			"11" & blank(1) & '1' when "01",
			'1' & blank(2) & "11" when "10",
			blank(3) & "111" when others;
	
	with anode_select select  --Determines which data set to send to the seven segment decoder
		decode <=
			data_in(3 downto 0) when "00",
			data_in(7 downto 4) when "01",
			data_in(11 downto 8) when "10",
			data_in(15 downto 12) when others;
end architecture behaviour;