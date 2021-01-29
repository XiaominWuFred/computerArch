--Xiaomin
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use global_signal.all;

entity pipelineunit is
	port(		
		status: out std_logic_vector(1 downto 0);
		clk:in std_logic;
		rset_bar:in std_logic;
		eod: in std_logic;
		linestart: in std_logic;
		InstructionF: out std_logic;
		ID: out std_logic;
		rd1: out std_logic;
		rd2: out std_logic;
		rd3: out std_logic;
		wt: out std_logic
	);	  
end;

architecture behaviroal of pipelineunit is
	--type state is (Idle,InsF,InsD,Exe);
    signal present_state, next_state : std_logic_vector (1 downto 0);
	-- Idle 00, InsF 01, InsD 10, Exe 11
begin 
	state_reg: process (clk)
	begin
		if	rising_edge(clk) then 
			
			if rset_bar = '0' then 
				present_state <= "00";
			else 
				present_state <= next_state;
			end if;	  
			
			status <= present_state;
			
		end if;
	end process;
	
	outputs: process(present_state)
	begin 
		case present_state is 
			when "01" =>
			InstructionF<='1';
			ID <= '0';
			rd1<='0';
			rd2<='0';
			rd3<='0';
			wt<='0';
			when "10" => 
			InstructionF<='0';
			ID <= '1';
			rd1<='0';
			rd2<='0';
			rd3<='0';
			wt<='0';
			when "11"=> 
			InstructionF<='0';
			ID <= '0';
			rd1<='1';
			rd2<='1';
			rd3<='1';
			wt<='1';
			when others =>
			InstructionF<='0';
			ID <= '0';
			rd1<='0';
			rd2<='0';
			rd3<='0';
			wt<='0';
		end case;
	end process;
	
	nxt_state: process (present_state, eod, linestart)
	begin 
		case present_state is 
			when "00" =>
			if linestart = '1'then 
				next_state <= "01";
			else 
				next_state <= "00";
			end if;	   
			
			when "01" =>
			next_state <= "10";
			
			when "10" =>
			next_state <= "11";
			
			when "11" =>
			if eod = '1' then 
				next_state <= "00";
			else 
				next_state <= "01";
			end if;
			
			when others =>
			next_state <= "00";
			
			end case;
		end process;
	end;