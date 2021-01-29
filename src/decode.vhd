--Xiaomin
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decode is 
	port(
	instructionFetched: in std_logic_vector(23 downto 0);
	ID: in std_logic;
	clk: in std_logic;
	sg235: out std_logic_vector(18 downto  0); 
	rdaddr3: out std_logic_vector(4 downto 0);
	rdaddr2: out std_logic_vector(4 downto 0);
	rdaddr1: out std_logic_vector(4 downto 0);
	wtaddr: out std_logic_vector(4 downto 0)
	
	);	 
end;

architecture behavioral of decode is 
begin
	process(clk)   
	variable inskeep : std_logic_vector(23 downto 0);
	begin
		if rising_edge(clk) then 
			
			if ID = '1' then 
				inskeep := instructionFetched;
			end if;
			
			sg235 <= inskeep(23 downto 5);
			rdaddr3 <= inskeep(19 downto 15);
			rdaddr2 <= inskeep(14 downto 10);
			rdaddr1 <= inskeep(9 downto 5);
			wtaddr <= inskeep(4 downto 0); 
		end if;
	end process;
end;
			
			
			
			
		