--Xiaomin
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity prepare is 
	port(
	start: in std_logic;
	loaddone: in std_logic;
	load: out std_logic;
	aragstart: out std_logic;
	clk: in std_logic;
	loadFinish:in std_logic
	
	);	 
end;

architecture behavioral of prepare is
begin
	process(loaddone,start,loadFinish)
	begin
		--if rising_edge(clk) then
			if start = '1' then
				load <= '1';	
			elsif loadFinish = '1' then 
				load <= '0';
			elsif loaddone = '1' then 
				load <= '0';
				aragstart <= '1'; 
			else 
				aragstart <= '0';
			end if;
		--end if;
	end process;
end;
			
			