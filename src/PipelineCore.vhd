--Xiaomin
library ieee;
use ieee.std_logic_1164.all;

use pack.all;

entity pipelineCore is 
	port(
	rset_bar : in std_logic;
	clk: in std_logic;
	eod: in std_logic;
	loaddone: in std_logic;
	start: in std_logic;
	loadFinish: in std_logic;	-- set , when instruction < 32 finished loading
	load: out std_logic;
	insfetch: out std_logic;
	ID: out std_logic;
	rd1: out std_logic;
	rd2: out std_logic;
	rd3: out std_logic;
	wt: out std_logic
	);													  
end;

architecture structural of pipelineCore is 
signal aragstart: std_logic;   
signal aragstartO: std_logic; 
signal linestart1: std_logic;
signal linestart2: std_logic;
signal linestart3: std_logic;
signal linestart11: std_logic;
signal linestart22: std_logic;
signal linestart33: std_logic;
signal insfetch1: std_logic;
signal ID1 : std_logic;
signal rd11	: std_logic;
signal rd21	: std_logic;
signal rd31 : std_logic;
signal wt1	: std_logic;
signal insfetch2: std_logic;
signal ID2 : std_logic;
signal rd12	: std_logic;
signal rd22	: std_logic;
signal rd32 : std_logic;
signal wt2	: std_logic;
signal insfetch3: std_logic;
signal ID3 : std_logic;
signal rd13	: std_logic;
signal rd23	: std_logic;
signal rd33 : std_logic;
signal wt3	: std_logic;
begin  

	prepare: entity prepare
		port map(
			start => start,
			loaddone=> loaddone,
			load=>load,
			aragstart=>aragstart,
			clk=>clk,
			loadFinish=> loadFinish
		);	   	
		
	startarag: entity startarag
		port map(
			aragstart=>aragstartO,	  
			linestart1=>linestart1,
			linestart2=>linestart2,
			linestart3=>linestart3,
			clk=>clk,
			eod=>eod
		); 
		
	pipelineunit1: entity pipelineunit
		port map(
			status=> status1,
			clk=>clk,
			rset_bar=>rset_bar,
			eod=>eod,
			linestart=>linestart1,
			InstructionF=>insfetch1,
			ID=>ID1,
			rd1=>rd11,
			rd2=>rd21,
			rd3=>rd31,
			wt=>wt1
		);
		
	pipelineunit2: entity pipelineunit
		port map(  
			status=>status2,
			clk=>clk,
			rset_bar=>rset_bar,
			eod=>eod,
			linestart=>linestart2,
			InstructionF=>insfetch2,
			ID=>ID2,
			rd1=>rd12,
			rd2=>rd22,
			rd3=>rd32,
			wt=>wt2
		);
	pipelineunit3: entity pipelineunit
		port map(	 
			status=>status3,
			clk=>clk,
			rset_bar=>rset_bar,
			eod=>eod,
			linestart=>linestart3,
			InstructionF=>insfetch3,
			ID=>ID3,
			rd1=>rd13,
			rd2=>rd23,
			rd3=>rd33,
			wt=>wt3
		);
	edgeD1: entity edge_det
		port map(

			rset_bar=>rset_bar,
			sig=>aragstart,
			clk=>clk,
			sig_edge=>aragstartO
		);	
		
	edgeD2: entity edge_det
		port map(
			rset_bar=>rset_bar,
			sig=>linestart1,
			clk=>clk,
			sig_edge=>linestart11
		);
	edgeD3: entity edge_det
		port map(
			rset_bar=>rset_bar,
			sig=>linestart2,
			clk=>clk,
			sig_edge=>linestart22
		);
	edgeD4: entity edge_det
		port map(
			rset_bar=>rset_bar,
			sig=>linestart3,
			clk=>clk,
			sig_edge=>linestart33
		); 
	or3to11: entity or3to1
		port map(
			 a => ID1,
			 b => ID2,
			 c => ID3,
			 output => ID
		);
	or3to12: entity or3to1
		port map(
			 a =>insfetch1, 
			 b =>insfetch2,
			 c =>insfetch3,
			 output =>insfetch 
		);
	or3to13: entity or3to1
		port map(
			 a =>wt1,
			 b =>wt2,
			 c =>wt3,
			 output =>wt
		);
	or3to14: entity or3to1
		port map(
			 a =>rd11,
			 b =>rd12,
			 c =>rd13,
			 output =>rd1
		);
	or3to15: entity or3to1
		port map(
			 a => rd21,
			 b => rd22,
			 c => rd23,
			 output => rd2
		);
	or3to16: entity or3to1
		port map(
			 a => rd31,
			 b => rd32,
			 c => rd33,
			 output => rd3
		);
	--probes	
		wt1p<=wt1;
		wt2p<=wt2;
		wt3p<=wt3;
		
end architecture;