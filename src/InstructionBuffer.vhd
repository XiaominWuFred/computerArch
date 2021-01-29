--Xiaomin
library ieee;
use ieee.std_logic_1164.all;
use pack.all;
entity InstructionBuffer is 
	port(
	 	rset_bar: in std_logic;
		clk: in std_logic; 
		eod: out std_logic;
		load: in std_logic;
		loaddone: out std_logic;
		instructionLoad: in std_logic_vector(23 downto 0);
		insfetch: in std_logic;		
		ID: in std_logic;
		sg235: out std_logic_vector(18 downto  0); 
		rdaddr3: out std_logic_vector(4 downto 0);
		rdaddr2: out std_logic_vector(4 downto 0);
		rdaddr1: out std_logic_vector(4 downto 0);
		wtaddr: out std_logic_vector(4 downto 0)
	);													  
end;

architecture structural of InstructionBuffer is 
signal instruction: std_logic_vector(23 downto 0);  

begin  

	instruction_buffer: entity instruction_buffer
		port map(
		   	rset_bar=>rset_bar,
			clk=>clk, 
			eod=>eod,
			load=>load,
			loaddone=>loaddone,
			instructionLoad=>	instructionLoad,
			instructionFetched=>instruction,
			insfetch=>insfetch
		);	   	
		
	decode: entity decode
		port map(
			instructionFetched=>instruction,
			ID=>ID,
			clk=>clk,
			sg235=>sg235,
			rdaddr3=>rdaddr3,
			rdaddr2=>rdaddr2,
			rdaddr1=>rdaddr1,
			wtaddr=>wtaddr
		); 
	  
		--probes
		instructionp <= instruction;
end architecture;