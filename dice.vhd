--Electronic dice with binary output and number showing random dice number on 7 seg display
--by Ninad Waingankar


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;


entity edice is
generic ( width : integer := 3 );
port (
		push : in std_logic;	--push button to draw random no on dice
		clk:in std_logic;		--12Mhz clock 
		random_num : out std_logic_vector (width-1 downto 0); --output binary led
		display:out std_logic_vector(6 downto 0)--output random no on 7 seg display
		);
end edice;

architecture Behavioral of edice is
	signal divider:std_logic_vector(23 downto 0);	--clock divider signal
	signal nin:std_logic_vector(2 downto 0);			--temporary signal for assignment
begin
	process(clk) 
	begin
		if(rising_edge(clk)) then
			divider<=divider+'1';
		end if;
	end process;

	process(divider(23),push)
		variable rand_temp : std_logic_vector(width-1 downto 0):=(width-1 => '1',others => '0');
		variable temp : std_logic := '0';
	begin
	if(push='1') then
		if(rising_edge(divider(21))) then
		--for random no generation
			temp := rand_temp(width-1) xor rand_temp(width-2);
			rand_temp(width-1 downto 1) := rand_temp(width-2 downto 0);
			rand_temp(0) := temp;
		end if;
	end if;
	nin<=rand_temp;
--developed by Ninad Waingankar	

--for display on common anode 7 seg display		
		case nin is 
			when "001"=>display<="1001111";--shows 1
			when "010"=>display<="0010010";--shows 2
			when "011"=>display<="0000110";--shows 3
			when "100"=>display<="1001100";--shows 4
			when "101"=>display<="0100100";--shows 5
			when "110"=>display<="0100000";--shows 6
			when others=>null;
		end case;
		random_num <= rand_temp;
	end process;
end Behavioral;

--I have added this comment to check it on github


