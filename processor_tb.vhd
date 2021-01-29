--Xiaomin
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;  

library std;   
use std.standard.all;
use STD.TEXTIO.ALL;

use pack.all;

entity processor_tb is
end processor_tb;	  


architecture tb of processor_tb is 
	signal simulationend: std_logic := '0';
	signal start: std_logic;
	signal loadFinish: std_logic;	-- set , when instruction < 32 finished loading
	signal rset_bar: std_logic;	
    signal clk:             std_logic := '0';
    constant clk_period:    time := 1 ns;
	constant period : time := 1ns;
	signal timecount : real := 0.0;

	
  file file_VECTORS : text;
  file file_RESULTS : text;
  signal fileopen : std_logic := '0'; 
  signal startwrite: std_logic := '0';
  
  constant c_WIDTH : natural := 24;
  signal instructionLoad: std_logic_vector(c_WIDTH-1 downto 0) := (others => '0');
  signal eodo : std_logic := '0'; 
  signal check: std_logic :='0';
  signal checkout: std_logic_vector (63 downto 0); 
  
    type memory is array(0 to 31) of std_logic_vector(63 downto 0);
	signal regfile : memory;

 
	
function chr(sl: std_logic) return character is
variable c: character;
begin
case sl is
when 'U' => c:= 'U';
when 'X' => c:= 'X';
when '0' => c:= '0';
when '1' => c:= '1';
when 'Z' => c:= 'Z';
when 'W' => c:= 'W';
when 'L' => c:= 'L';
when 'H' => c:= 'H';
when '-' => c:= '-';
end case;
return c;
end chr;


function str(slv: std_logic_vector) return string is
variable result : string (1 to slv'length);
variable r : integer;
begin
r := 1;
for i in slv'range loop
result(r) := chr(slv(i));
r := r + 1;
end loop;
return result;
end str;
	
  begin		 
	
	target: entity Processor
		port map(  
		eodo=>eodo,
		check=>check,
		checkout=>checkout,
		instructionLoad=>instructionLoad,
		start=>start,
		loadFinish=>loadFinish,	-- set , when instruction < 32 finished loading
		clk=>clk,
		rset_bar=>rset_bar
		);					
		

--**********************************************************read file 		
 
go:process 
  
	variable v_ILINE     : line;
    variable v_OLINE     : line;	
	variable v_oppoInstruction : std_logic_vector(c_WIDTH-1 downto 0);
	variable v_Instruction : std_logic_vector(c_WIDTH-1 downto 0);
	
     
  	begin
 	wait until rset_bar = '1';
    file_open(file_VECTORS, "instruction.txt",  read_mode);
    file_open(file_RESULTS, "output_results_Wu_Xu.txt", write_mode); 
	fileopen<='1';

	start <= '0';
	wait for period;
	
	start <= '1';
	wait for period;

    while not endfile(file_VECTORS) loop
      readline(file_VECTORS, v_ILINE);
  
	  for i in v_ILINE'range loop
        v_oppoInstruction(i-1 downto i-1) := std_logic_vector(to_unsigned(character'pos(v_ILINE(i)),1));
	  end loop;
	  
	  for i in v_oppoInstruction'range loop 
		  v_Instruction(23-i) := v_oppoInstruction(i);
	  end loop;
 
      -- Pass the variable to a signal to allow the ripple-carry to use it
      instructionLoad <= v_Instruction;
      -- r_ADD_TERM2 <= v_ADD_TERM2;
	  if start = '1' then
	     start <= '0';
	  end if;
	 
      wait for period;
 

	  
    end loop; 
	
	loadFinish<= '1';
	wait for period;
	loadFinish<= '0';
 
    file_close(file_VECTORS);
    
    
	wait until  eodo = '1';	
	wait for 5*period;	
	
	check <= '1';
	
	for i in 0 to 31 loop
		wait for period/2;
		regfile(i) <= checkout;
		
	end loop;  
	check<='0';	
	wait for period;
	for i in 0 to 31 loop
		report "Register "&integer'image(i)&" value: "&str(regfile(i));
	end loop; 
		write(v_OLINE,"Program execution result in Register file:");
		writeline(file_RESULTS, v_OLINE); 	
	for i in 0 to 31 loop
		write(v_OLINE,"Register "&integer'image(i)&" value: "&str(regfile(i)));
		writeline(file_RESULTS, v_OLINE);    
	end loop;
	
	file_close(file_RESULTS);
	fileopen<='0';
	
    wait;
  end process;
	
--***********************************************************************************	
writestart: process(status1, status2, status3)
begin 
	if status1 = status2 and status1 = status3 and status2 = status3 then 
		startwrite <= '0';
	else
		startwrite <= '1';
	end if;
	
end process;



track: process	 
variable v_OLINE     : line;
begin
	wait until startwrite = '1';	
	loop
  	wait for period/2;
	if fileopen = '1' then
	--	if ((status1 = "11" and wt1p = '0')) or ((status2 = "11" and wt2p = '0')) or ((status3 = "11" and wt3p = '0')) then
	
		write(v_OLINE,"PERIOD: "&real'image(timecount)&" ns ");
		writeline(file_RESULTS, v_OLINE);
		
		if status1 = "00"  then
			write(v_OLINE,"Pipeline stage 1 status: Idle");	
			writeline(file_RESULTS, v_OLINE);
			write(v_OLINE,"waiting to start");
			writeline(file_RESULTS, v_OLINE);
		elsif status1 ="01"	then
			write(v_OLINE,"Pipeline stage 1 status: InsF");
			writeline(file_RESULTS, v_OLINE);			   
			write(v_OLINE,"Exe result: ");
			writeline(file_RESULTS, v_OLINE);
			write(v_OLINE,"next instruction fetched, will be decoded in next cycle");
			writeline(file_RESULTS, v_OLINE);
		elsif status1 = "10" then
			write(v_OLINE,"Pipeline stage 1 status: InsD");
			writeline(file_RESULTS, v_OLINE);
			write(v_OLINE,"Exe result: ");
			writeline(file_RESULTS, v_OLINE);
			write(v_OLINE,"current instruction "&str(instructionp)&" decoded, generate opcode and oprands for next cycle");
			writeline(file_RESULTS, v_OLINE);			
		elsif status1 = "11" then
			write(v_OLINE,"Pipeline stage 1 status: Exe");
			writeline(file_RESULTS, v_OLINE);  
			
			write(v_OLINE,"Exe result: ");
			writeline(file_RESULTS, v_OLINE);
			
			write(v_OLINE,"value: "&str(writevalue)&" wrote in address "&str(writeaddr));
			writeline(file_RESULTS, v_OLINE);
		end if;

		
		  
			
		
		if status2 = "00"  then
			write(v_OLINE,"Pipeline stage 2 status: Idle");	
			writeline(file_RESULTS, v_OLINE);
			write(v_OLINE,"waiting to start");
			writeline(file_RESULTS, v_OLINE);
		elsif status2 ="01"	then
			write(v_OLINE,"Pipeline stage 2 status: InsF");
			writeline(file_RESULTS, v_OLINE);			   
			write(v_OLINE,"Exe result: ");
			writeline(file_RESULTS, v_OLINE);
			write(v_OLINE,"next instruction fetched, will be decoded in next cycle");
			writeline(file_RESULTS, v_OLINE);
		elsif status2 = "10" then
			write(v_OLINE,"Pipeline stage 2 status: InsD");
			writeline(file_RESULTS, v_OLINE);
			write(v_OLINE,"Exe result: ");
			writeline(file_RESULTS, v_OLINE);
			write(v_OLINE,"current instruction "&str(instructionp)&" decoded, generate opcode and oprands for next cycle");
			writeline(file_RESULTS, v_OLINE);			
		elsif status2 = "11" then
			write(v_OLINE,"Pipeline stage 2 status: Exe");
			writeline(file_RESULTS, v_OLINE);  
			
			write(v_OLINE,"Exe result: ");
			writeline(file_RESULTS, v_OLINE);
			
			write(v_OLINE,"value: "&str(writevalue)&" wrote in address "&str(writeaddr));
			writeline(file_RESULTS, v_OLINE);
		end if;

		
		
		if status3 = "00"  then
			write(v_OLINE,"Pipeline stage 3 status: Idle");	
			writeline(file_RESULTS, v_OLINE);
			write(v_OLINE,"waiting to start");
			writeline(file_RESULTS, v_OLINE);
		elsif status3 ="01"	then
			write(v_OLINE,"Pipeline stage 3 status: InsF");
			writeline(file_RESULTS, v_OLINE);			   
			write(v_OLINE,"Exe result: ");
			writeline(file_RESULTS, v_OLINE);
			write(v_OLINE,"next instruction fetched, will be decoded in next cycle");
			writeline(file_RESULTS, v_OLINE);
		elsif status3 = "10" then
			write(v_OLINE,"Pipeline stage 3 status: InsD");
			writeline(file_RESULTS, v_OLINE);
			write(v_OLINE,"Exe result: ");
			writeline(file_RESULTS, v_OLINE);
			write(v_OLINE,"current instruction "&str(instructionp)&" decoded, generate opcode and oprands for next cycle");
			writeline(file_RESULTS, v_OLINE);			
		elsif status3 = "11" then
			write(v_OLINE,"Pipeline stage 3 status: Exe");
			writeline(file_RESULTS, v_OLINE);  
			
			write(v_OLINE,"Exe result: ");
			writeline(file_RESULTS, v_OLINE);
			
			write(v_OLINE,"value: "&str(writevalue)&" wrote in address "&str(writeaddr));
			writeline(file_RESULTS, v_OLINE);
		end if;	

		
			write(v_OLINE,"This cycle writing register? "&chr(wtp));	
			writeline(file_RESULTS, v_OLINE);
			
		--instruction
		write(v_OLINE,"current cycle instruction: "&str(instructionp));
		writeline(file_RESULTS, v_OLINE);
		
		--opcode
		write(v_OLINE,"current cycle opcode: "&str(opcode));
		writeline(file_RESULTS, v_OLINE);
		
		--r1
		write(v_OLINE,"current cycle Register Read 1 address: "&str(r1addrp));
		writeline(file_RESULTS, v_OLINE);
	 	write(v_OLINE,"current cycle Register Read 1 value: "&str(r1value));
		writeline(file_RESULTS, v_OLINE);
		
		--r2
		write(v_OLINE,"current cycle Register Read 2 address: "&str(r2addrp));
		writeline(file_RESULTS, v_OLINE);
	 	write(v_OLINE,"current cycle Register Read 2 value: "&str(r2value));
		writeline(file_RESULTS, v_OLINE); 
		
		--r3
		write(v_OLINE,"current cycle Register Read 3 address: "&str(r3addrp));
		writeline(file_RESULTS, v_OLINE);
	 	write(v_OLINE,"current cycle Register Read 3 value: "&str(r3value));
		writeline(file_RESULTS, v_OLINE);
		
		
		--line brker
		write(v_OLINE,"***********************************************");
		writeline(file_RESULTS, v_OLINE);
	--end if;	
	end if;	
	exit when startwrite = '0';
	end loop;
	
	wait;
end process;


rset: process
		begin
			rset_bar <='0';
			wait until rising_edge(clk);
			wait until rising_edge(clk);
			rset_bar<='1';
			wait;
end process;
		
clock: process
		begin 
			clk <= '0';
			loop
				wait for period/2;
				clk <= not clk;	  
				timecount <= timecount + 0.5;
				exit when simulationend = '1';
			end loop;
			wait;
end process;
			
	end architecture;	 
	
	
	


