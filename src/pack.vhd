--Xiaomin
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;  
package pack is
	signal status1: std_logic_vector(1 downto 0);
	signal wt1p: std_logic;
	signal status2: std_logic_vector(1 downto 0); 
	signal wt2p:std_logic;
	signal status3: std_logic_vector(1 downto 0);
	signal wt3p: std_logic;	
	signal wtp:std_logic;
	signal opcode: std_logic_vector(3 downto 0);  
	signal r1addrp: std_logic_vector(4 downto 0);
	signal r2addrp: std_logic_vector(4 downto 0);
	signal r3addrp: std_logic_vector(4 downto 0);
	signal r1value: std_logic_vector(63 downto 0);
	signal r2value: std_logic_vector(63 downto 0);
	signal r3value: std_logic_vector(63 downto 0);
	signal writeaddr: std_logic_vector(4 downto 0);
	signal writevalue: std_logic_vector(63 downto 0);
	signal instructionp: std_logic_vector(23 downto 0);
end pack;