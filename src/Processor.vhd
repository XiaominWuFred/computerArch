--Xiaomin
library ieee;
use ieee.std_logic_1164.all;

use pack.all;

entity Processor is 
	port( 
	check: in std_logic;
	checkout: out std_logic_vector(63 downto 0);
	instructionLoad: in std_logic_vector(23 downto 0);
	start: in std_logic;
	loadFinish: in std_logic;	-- set , when instruction < 32 finished loading
	clk: in std_logic;
	rset_bar: in std_logic; 
	eodo: out std_logic
	--registerRead: in std_logic;
	--registerData: out std_logic_vector(63 downto 0)
	);													  
end;

architecture structural of Processor is 
signal eod : std_logic;  
signal load : std_logic;
signal loaddone : std_logic;  
signal insfetch : std_logic;
signal ID : std_logic;	 
signal sg235: std_logic_vector(18 downto  0);
signal rdaddr3: std_logic_vector(4 downto 0);
signal rdaddr2: std_logic_vector(4 downto 0);
signal rdaddr1: std_logic_vector(4 downto 0);
signal	wtaddr: std_logic_vector(4 downto 0);   

signal	wt: std_logic;  
signal	wtin: std_logic_vector(63 downto 0);
signal	rd1: std_logic;
signal	rd2: std_logic;
signal	rd3: std_logic;
signal	rdout1: std_logic_vector(63 downto 0);
signal	rdout2: std_logic_vector(63 downto 0);
signal	rdout3: std_logic_vector(63 downto 0);


begin  

	
	InstructionBuffer: entity InstructionBuffer
		port map(
			rset_bar=>rset_bar,
			clk=>clk, 
			eod=>eod,
			load=>load,
			loaddone=>loaddone,
			instructionLoad=>instructionLoad,
			insfetch=>insfetch,	
			ID=>ID,
			sg235=>sg235, 
			rdaddr3=>rdaddr3,
			rdaddr2=>rdaddr2,
			rdaddr1=>rdaddr1,
			wtaddr=>wtaddr
		);	   	
		
	registerfile: entity registerfile
		port map(
			check=>check,
			checkout=>checkout,
			wt=>wt,  
			wtin=>wtin,
			rd1=>rd1,
			rd2=>rd2,
			rd3=>rd3,
			rdout1=>rdout1,
			rdout2=>rdout2,
			rdout3=>rdout3,
			rdaddr1=>rdaddr1,
			rdaddr2=>rdaddr2,
			rdaddr3=>rdaddr3,
			wtaddr=>wtaddr,
			clk=>clk,
			rset_bar=>rset_bar
		); 	
		
	alu: entity alu
		port map(
			clk=>clk,
			rs3=>rdout3,
			rs2=>rdout2,
			rs1=>rdout1,
			sg235=>sg235,
			rd=>wtin
		); 
		
	PipelineCore: entity pipelineCore
		port map(
			rset_bar=>rset_bar,
			clk=>clk,
			eod=>eod,
			loaddone=>loaddone,
			start => start,
			loadFinish => loadFinish,	-- set , when instruction < 32 finished loading
			load=>load,
			insfetch=>insfetch,
			ID=>ID,
			rd1=>rd1,
			rd2=>rd2,
			rd3=>rd3,
			wt=>wt
		); 	
--probes		
		eodo <= eod;
		opcode <= sg235(13 downto 10); 
		r1addrp <= rdaddr1;
		r2addrp <= rdaddr2;
		r3addrp <= rdaddr3;
		r1value <=rdout1;
		r2value <=rdout2;
		r3value <=rdout3;  
		writeaddr <= wtaddr;
		writevalue <= wtin;
		wtp <= wt;
end architecture;