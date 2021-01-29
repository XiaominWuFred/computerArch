--Xiaomin 
library ieee;
use ieee.std_logic_1164.all;

entity edge_det is 
	port(

	rset_bar : in std_logic;
	sig: in std_logic;
	clk: in std_logic;
	sig_edge: out std_logic
	);						
end;

architecture behavior of edge_det is 
begin 
	process(clk,rset_bar)
	variable memory: std_logic := '0';
	begin
		if rset_bar = '0' then
			sig_edge <= '0';   
			memory := '0';
		elsif rising_edge(clk) then 

				
				if memory = '0' and sig = '1' then 
				sig_edge <= '1';
				elsif memory = '1' and  sig = '1' then 
				sig_edge <= '0';
				end if;
			
				memory := sig;
			

		end if;
	end process;
end;