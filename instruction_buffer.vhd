--Xiaomin
library IEEE;
use IEEE.STD_LOGIC_1164.all;	 
use ieee.numeric_std.all; 

entity instruction_buffer is
	port(		 
	rset_bar: in std_logic;
	clk: in std_logic; 
	eod: out std_logic;
	load: in std_logic;
	loaddone: out std_logic;
	instructionLoad: in std_logic_vector(23 downto 0);
	instructionFetched: out std_logic_vector(23 downto 0);
	insfetch: in std_logic
	);
end;

architecture behavior of instruction_buffer is 

type memory is array(0 to 31) of std_logic_vector(23 downto 0);
signal mem : memory;
begin 
	process(clk,rset_bar)	  
	variable PC : integer range 0 to 32;
	variable loadCount: integer range 0 to 32;
	begin 
		  
			if rset_bar = '0'then 
				PC := 0;	 
				loadCount :=0;
					   
				
			elsif rising_edge(clk) then    
				if load = '1'then 
					eod <= '0';
					mem(loadCount) <= instructionLoad;
					loadCount := loadCount + 1;
						if loadCount = 32 then 
						 
						 loaddone <= '1';
						else
						
							loaddone <= '0';
						end if;
					
				elsif  insfetch = '1' then
						
					instructionFetched <= mem(PC);
					PC := PC + 1; 
					
					if PC = loadCount - 2 then
						eod <= '1';
					end if;
					
					if PC = loadCount then 
						
						PC := 0;
						loadCount := 0;
					end if;
				elsif loadCount > 0 then 
					loaddone <= '1';
				end if;
			end if;
		end process;
		end;
		
				