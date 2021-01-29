--Xiaomin
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity registerfile is 
	port(
	check: in std_logic;
	checkout: out std_logic_vector(63 downto 0);
	wt: in std_logic;  
	wtin: in std_logic_vector(63 downto 0);
	rd1: in std_logic;
	rd2: in std_logic;
	rd3: in std_logic;
	rdout1:out std_logic_vector(63 downto 0);
	rdout2:out std_logic_vector(63 downto 0);
	rdout3:out std_logic_vector(63 downto 0);
	rdaddr1: in std_logic_vector (4 downto 0);
	rdaddr2: in std_logic_vector (4 downto 0);
	rdaddr3: in std_logic_vector (4 downto 0);
	wtaddr: in std_logic_vector (4 downto 0);
	clk: in std_logic;
	rset_bar:in std_logic
	);
end;

architecture behavioral of registerfile is 
type memory is array(0 to 31) of std_logic_vector(63 downto 0);
signal regfile : memory;
begin
	process( rset_bar,clk)
	variable checkcount: integer range 0 to 32;
	begin 
		if rset_bar = '0' then 
			checkcount:= 0;
			for i in regfile'range loop
				regfile(i)<=(others => '0');
			end loop;			  
		 end if;
		--elsif rising_edge(clk) then 
			if wt = '1' then  
				regfile(to_integer(unsigned(wtaddr)))<= wtin;
			end if;
			
			if rd1 = '1' then 
				rdout1 <= regfile(to_integer(unsigned(rdaddr1)));
			end if;
			
			if rd2 = '1' then
				rdout2 <= regfile(to_integer(unsigned(rdaddr2)));
			end if;
			
			if rd3 = '1' then 
				rdout3 <= regfile(to_integer(unsigned(rdaddr3)));
			end if;
		--end if;
		
		if check = '1' then 
			checkout <= regfile(checkcount);
			checkcount := checkcount + 1; 
		end if;
			
		
	end process;
	
end;