--Xiaomin
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity startarag is 
	port(
	aragstart: in std_logic;
	linestart1: out std_logic;
	linestart2: out std_logic;
	linestart3: out std_logic;
	clk: in std_logic;
	eod: in std_logic
	);
end;

architecture behavioral of startarag is

begin
	process(clk)  
	variable hold: std_logic; 
	variable clkcount: integer range 0 to 4;
	begin 
		if rising_edge(clk) then 
			if aragstart = '1' then 
				hold := '1';
				clkcount := 0;
			end if;
			
			if eod = '1' then 
				hold := '0';
				linestart1 <= '0';
				linestart2 <= '0';
				linestart3 <= '0';
			end if;
			
			if hold = '1' then 
				clkcount := clkcount + 1;
			end if;
			
			if clkcount = 1 and hold = '1'then
				linestart1 <= '1';
			elsif clkcount = 2 and hold = '1'then 
				linestart2 <= '1';
			elsif clkcount = 3 and hold = '1'then 
				linestart3 <= '1';
			elsif clkcount = 4 then 
				clkcount := 0;
			end if;
			
		end if;
	end process;
	
end;