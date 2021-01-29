--Xiaomin 
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity or3to1 is
	 port(
		 a : in STD_LOGIC;
		 b : in STD_LOGIC;
		 c : in std_logic;
		 output : out STD_LOGIC
	     );
end;

--}} End of automatically maintained section

architecture dataflow of or3to1 is
begin
	output <= a or b or c;
end dataflow;
