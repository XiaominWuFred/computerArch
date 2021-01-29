--Xiaomin 
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is 
	port(
	
	clk: in std_logic;	--not used
	rs3: in std_logic_vector(63 downto 0);
	rs2: in std_logic_vector(63 downto 0);
	rs1: in std_logic_vector(63 downto 0);
	sg235: in std_logic_vector(18 downto  0); 
	rd: out std_logic_vector(63 downto 0)
	);
end alu;

architecture behavioral of alu is  

begin 			 
	process(rs1,rs2,rs3,sg235) 

	
		variable rs3s: signed(63 downto 0);
		variable rs2s: signed(63 downto 0);
		variable rs1s: signed(63 downto 0);	
		variable rs3us: unsigned(63 downto 0);	
		variable rs2us: unsigned(63 downto 0);	
		variable rs1us: unsigned(63 downto 0);
		variable rs3std: std_logic_vector(63 downto 0);
		variable rs2std: std_logic_vector(63 downto 0);
		variable rs1std: std_logic_vector(63 downto 0);
		
		variable tmp16_3s: signed(15 downto 0);
		variable tmp16_2s: signed(15 downto 0);	
		variable tmp16_1s: signed(15 downto 0);
		
		variable tmp16_1std: std_logic_vector(15 downto 0);
		variable tmp32_1std: std_logic_vector(31 downto 0);
		
		variable tmp16_2us: unsigned(15 downto 0);
		variable tmp16_1us: unsigned(15 downto 0);
		
		variable products: signed(31 downto 0);
		variable productus: unsigned(31 downto 0);
		
		variable tempouts: signed(63 downto 0); 
		variable tempoutus: unsigned(63 downto 0);
		variable addsub: signed(31 downto 0); 
		variable count: integer; 
		variable rightout: std_logic;
		variable shiftcount: integer;  
		
		constant add32_0: signed(addsub'range):= (others => '0');
		constant compareleft32: signed(addsub'range):= add32_0 + (-2)**31; 
		constant compareright32: signed(addsub'range):= add32_0 + (2**31)-1;
		constant add16_0: signed(15 downto 0):= (others => '0');
		
		constant top : unsigned (7 downto 0) := "11111111";
		constant off : unsigned (7 downto 0) := "00000001";
	begin						 				  
	
 
		if sg235(18) = '1' then 	
			if sg235(17 downto 16) = "00" then
			rd(15 downto 0) <= sg235(15 downto 0); --li	 
			elsif sg235(17 downto 16) = "01" then 
			rd(31 downto 16) <= sg235(15 downto 0);	  
			elsif sg235(17 downto 16) = "10" then 
			rd(47 downto 32) <= sg235(15 downto 0);	
			elsif sg235(17 downto 16) = "11" then 
			rd(63 downto 48) <= sg235(15 downto 0);	
			end if;
		elsif sg235(17) = '1' then 
			if sg235(16 downto 15) = "00" then							  --MA
				rs3s := signed(rs3);
				rs2s := signed(rs2); 
				rs1s := signed(rs1);
				tmp16_3s := rs3s(15 downto 0);
				tmp16_2s := rs2s(15 downto 0);
				products := tmp16_3s * tmp16_2s; 
				addsub  := rs1s(31 downto 0) + products;
				if products > 0 and rs1s(31 downto 0) >0 and addsub <0  then 
					tempouts(31 downto 0) := compareright32;
				elsif products < 0 and rs1s(31 downto 0) <0 and addsub >0 then 
					tempouts(31 downto 0) := compareleft32;
				else 
					tempouts(31 downto 0) := addsub;
				end if;
				
				tmp16_3s := rs3s(47 downto 32);
				tmp16_2s := rs2s(47 downto 32);
				products := tmp16_3s * tmp16_2s; 
				addsub  := rs1s(63 downto 32) + products;
				if products > 0 and rs1s(63 downto 32) >0 and addsub <0  then 
					tempouts(63 downto 32) := compareright32;
				elsif products < 0 and rs1s(63 downto 32) <0 and addsub >0 then 
					tempouts(63 downto 32) := compareleft32;
				else 
					tempouts(63 downto 32) := addsub;
				end if;
				
				rd <= std_logic_vector(tempouts);	 
				
			elsif sg235(16 downto 15) = "01" then						  --MS
				rs3s := signed(rs3);
				rs2s := signed(rs2); 
				rs1s := signed(rs1);
				tmp16_3s := rs3s(31 downto 16);
				tmp16_2s := rs2s(31 downto 16);
				products := tmp16_3s * tmp16_2s; 
				addsub  := rs1s(31 downto 0) + products;
				if products > 0 and rs1s(31 downto 0) >0 and addsub <0  then 
					tempouts(31 downto 0) := compareright32;
				elsif products < 0 and rs1s(31 downto 0) <0 and addsub >0 then 
					tempouts(31 downto 0) := compareleft32;
				else 
					tempouts(31 downto 0) := addsub;
				end if; 
				 
				
				tmp16_3s := rs3s(63 downto 48);
				tmp16_2s := rs2s(63 downto 48);
				products := tmp16_3s * tmp16_2s; 
				addsub  := rs1s(63 downto 32) + products;
				if products > 0 and rs1s(63 downto 32) >0 and addsub <0  then 
					tempouts(63 downto 32) := compareright32;
				elsif products < 0 and rs1s(63 downto 32) <0 and addsub >0 then 
					tempouts(63 downto 32) := compareleft32;
				else 
					tempouts(63 downto 32) := addsub;
				end if;
				
				
				rd <= std_logic_vector(tempouts);
			elsif sg235(16 downto 15) = "10" then						  --I
				rs3s := signed(rs3);
				rs2s := signed(rs2); 
				rs1s := signed(rs1);
				tmp16_3s := rs3s(15 downto 0);
				tmp16_2s := rs2s(15 downto 0);
				products := tmp16_3s * tmp16_2s; 
				addsub  := rs1s(31 downto 0) - products;
				if products < 0 and rs1s(31 downto 0) >0 and addsub <0  then 
					tempouts(31 downto 0) := compareright32;
				elsif products > 0 and rs1s(31 downto 0) <0 and addsub >0 then 
					tempouts(31 downto 0) := compareleft32;
				else 
					tempouts(31 downto 0) := addsub;
				end if; 
				 
				
				tmp16_3s := rs3s(47 downto 32);
				tmp16_2s := rs2s(47 downto 32);
				products := tmp16_3s * tmp16_2s; 
				addsub  := rs1s(63 downto 32) - products;
				if products < 0 and rs1s(63 downto 32) >0 and addsub <0  then 
					tempouts(63 downto 32) := compareright32;
				elsif products > 0 and rs1s(63 downto 32) <0 and addsub >0 then 
					tempouts(63 downto 32) := compareleft32;
				else 
					tempouts(63 downto 32) := addsub;
				end if;
				
				rd <= std_logic_vector(tempouts);
			elsif sg235(16 downto 15) = "11" then							--h
				rs3s := signed(rs3);
				rs2s := signed(rs2); 
				rs1s := signed(rs1);
				tmp16_3s := rs3s(31 downto 16);
				tmp16_2s := rs2s(31 downto 16);
				products := tmp16_3s * tmp16_2s; 
				addsub  := rs1s(31 downto 0) - products;
				if products < 0 and rs1s(31 downto 0) >0 and addsub <0  then 
					tempouts(31 downto 0) := compareright32;
				elsif products > 0 and rs1s(31 downto 0) <0 and addsub >0 then 
					tempouts(31 downto 0) := compareleft32;
				else 
					tempouts(31 downto 0) := addsub;
				end if;   
				
				tmp16_3s := rs3s(63 downto 48);
				tmp16_2s := rs2s(63 downto 48);
				products := tmp16_3s * tmp16_2s; 
				addsub  := rs1s(63 downto 32) - products;
				if products < 0 and rs1s(63 downto 32) >0 and addsub <0  then 
					tempouts(63 downto 32) := compareright32;
				elsif products > 0 and rs1s(63 downto 32) <0 and addsub >0 then 
					tempouts(63 downto 32) := compareleft32;
				else 
					tempouts(63 downto 32) := addsub;
				end if;
				
				
				rd <= std_logic_vector(tempouts);	
			end if;
		elsif sg235(13 downto 10) = "0001" then  	  --bcw
				rs1s := signed(rs1);
				tempouts(31 downto 0) := rs1s(31 downto 0);
				tempouts(63 downto 32) := rs1s(31 downto 0);
				rd <= std_logic_vector(tempouts);	
		elsif sg235(13 downto 10) = "0010" then		  --and
			rs1std := rs1;
			rs2std := rs2;
			rs1std := rs1std and rs2std;
			rd <= rs1std;	  
		elsif sg235(13 downto 10) = "0011" then 	--or
			rs1std := rs1;
			rs2std := rs2;
			rs1std := rs1std or rs2std;
			rd <= rs1std;	 
		elsif sg235(13 downto 10) = "0100" then 	--popcnth
			rs1std := rs1;
			--15-0
			tmp16_1std := rs1std(15 downto 0);
			count := 0;
			for i in tmp16_1std' range loop
				if tmp16_1std(i) = '1' then 
					count := count + 1;
				end if;
			end loop;
			tempouts(15 downto 0) := to_signed(count, 16);
			--31-16
			tmp16_1std := rs1std(31 downto 16);
			count := 0;
			for i in tmp16_1std' range loop
				if tmp16_1std(i) = '1' then 
					count := count + 1;
				end if;
			end loop;
			tempouts(31 downto 16) := to_signed(count, 16);
			--47-32
			tmp16_1std := rs1std(47 downto 32);
			count := 0;
			for i in tmp16_1std' range loop
				if tmp16_1std(i) = '1' then 
					count := count + 1;
				end if;
			end loop;
			tempouts(47 downto 32) := to_signed(count, 16);
			--63-48
			tmp16_1std := rs1std(63 downto 48);
			count := 0;
			for i in tmp16_1std' range loop
				if tmp16_1std(i) = '1' then 
					count := count + 1;
				end if;
			end loop;
			tempouts(63 downto 48) := to_signed(count, 16);	 
			
			rd <= std_logic_vector(tempouts);
			
		elsif sg235(13 downto 10) = "0101" then 	--clz
			rs1std := rs1;
			--31-0
			tmp32_1std := rs1std(31 downto 0);
			count := 0;
			for i in tmp32_1std' range loop 
				if tmp32_1std(i) = '1' then 
					exit;
				else
				count := count + 1;
				end if;
			end loop;
			tempouts(31 downto 0) := to_signed(count, 32);
			--63-32
			tmp32_1std := rs1std(63 downto 32);
			count := 0;
			for i in tmp32_1std' range loop 
				if tmp32_1std(i) = '1' then 
					exit;
				else
				count := count + 1;
				end if;
			end loop;
			tempouts(63 downto 32) := to_signed(count, 32);
			
			rd <= std_logic_vector(tempouts);
			
		elsif sg235(13 downto 10) = "0110" then 	--rot	
			rs1std := rs1;
			rs2std := rs2;			 
			shiftcount := to_integer(unsigned(rs2std(5 downto 0)));
			
			for i in 0 to shiftcount - 1 loop
				rightout := rs1std(0);
				for j in 0 to 62 loop
					rs1std(j) := rs1std(j+1);
				end loop;
				rs1std(63) := rightout;
			end loop;
			
			rd <= rs1std;			

		elsif sg235(13 downto 10) = "0111" then 	--shlhi
			rs1std := rs1;
			shiftcount := to_integer(unsigned(sg235(9 downto 5)));  
			for i in 0 to shiftcount - 1 loop
				tmp16_1std := rs1std(63 downto 48);
				rs1std(63 downto 48) := rs1std(47 downto 32);
				rs1std(47 downto 32) := rs1std(31 downto 16);
				rs1std(31 downto 16) := rs1std(15 downto 0);
				rs1std(15 downto 0) := tmp16_1std;
			end loop;	
			rd <= rs1std;

		elsif sg235(13 downto 10) = "1000" then 	--a
			rs1us := unsigned(rs1);
			rs2us := unsigned(rs2);
			tempoutus(63 downto 32) := rs1us(63 downto 32) + rs2us(63 downto 32);
			tempoutus(31 downto 0) := rs1us(31 downto 0) + rs2us(31 downto 0);
			rd <= std_logic_vector(tempoutus);
			
		elsif sg235(13 downto 10) = "1001" then 	--sfw
			rs1us := unsigned(rs1);
			rs2us := unsigned(rs2);
			tempoutus(63 downto 32) := rs1us(63 downto 32) - rs2us(63 downto 32);
			tempoutus(31 downto 0) := rs1us(31 downto 0) - rs2us(31 downto 0);
			rd <= std_logic_vector(tempoutus);
			
		elsif sg235(13 downto 10) = "1010" then 	--ah
			rs1us := unsigned(rs1);
			rs2us := unsigned(rs2);
			tempoutus(63 downto 48) := rs1us(63 downto 48) + rs2us(63 downto 48);
			tempoutus(47 downto 32) := rs1us(47 downto 32) + rs2us(47 downto 32);
			tempoutus(31 downto 16) := rs1us(31 downto 16) + rs2us(31 downto 16);
			tempoutus(15 downto 0) := rs1us(15 downto 0) + rs2us(15 downto 0);
			rd <= std_logic_vector(tempoutus);

		elsif sg235(13 downto 10) = "1011" then 	--sfh
			rs1us := unsigned(rs1);
			rs2us := unsigned(rs2);
			tempoutus(63 downto 48) := rs1us(63 downto 48) - rs2us(63 downto 48);
			tempoutus(47 downto 32) := rs1us(47 downto 32) - rs2us(47 downto 32);
			tempoutus(31 downto 16) := rs1us(31 downto 16) - rs2us(31 downto 16);
			tempoutus(15 downto 0) := rs1us(15 downto 0) - rs2us(15 downto 0);
			rd <= std_logic_vector(tempoutus);
			
		elsif sg235(13 downto 10) = "1100" then 	--ahs
			rs1s :=	signed(rs1);
			rs2s := signed(rs2);
			tempouts(63 downto 48) := rs1s(63 downto 48) + rs2s(63 downto 48);
			if rs1s(63 downto 48)>0 and rs2s(63 downto 48)>0 and tempouts(63 downto 48)<0 then 
				tempouts(63 downto 48) := add16_0 + (32767);
			elsif rs1s(63 downto 48)<0 and rs2s(63 downto 48)<0 and tempouts(63 downto 48)>0 then
				tempouts(63 downto 48) := add16_0 + (-32768);	 
			end if;
			tempouts(47 downto 32) := rs1s(47 downto 32) + rs2s(47 downto 32);
			if rs1s(47 downto 32)>0 and rs2s(47 downto 32)>0 and tempouts(47 downto 32)<0 then 
				tempouts(47 downto 32) := add16_0 + (32767);
			elsif rs1s(47 downto 32)<0 and rs2s(47 downto 32)<0 and tempouts(47 downto 32)>0 then
				tempouts(47 downto 32) := add16_0 + (-32768);	 
			end if;
			tempouts(31 downto 16) := rs1s(31 downto 16) + rs2s(31 downto 16);
			if rs1s(31 downto 16)>0 and rs2s(31 downto 16)>0 and tempouts(31 downto 16)<0 then 
				tempouts(31 downto 16) := add16_0 + (32767);
			elsif rs1s(31 downto 16)<0 and rs2s(31 downto 16)<0 and tempouts(31 downto 16)>0 then
				tempouts(31 downto 16) := add16_0 + (-32768);	 
			end if;
			tempouts(15 downto 0) := rs1s(15 downto 0) + rs2s(15 downto 0);
			if rs1s(15 downto 0)>0 and rs2s(15 downto 0)>0 and tempouts(15 downto 0)<0 then 
				tempouts(15 downto 0) := add16_0 + (32767);
			elsif rs1s(15 downto 0)<0 and rs2s(15 downto 0)<0 and tempouts(15 downto 0)>0 then
				tempouts(15 downto 0) := add16_0 + (-32768);	 
			end if;
			rd <= std_logic_vector(tempouts);
			
		elsif sg235(13 downto 10) = "1101" then 	--sfhs
			rs1s :=	signed(rs1);
			rs2s := signed(rs2);
			tempouts(63 downto 48) := rs1s(63 downto 48) - rs2s(63 downto 48);
			if rs1s(63 downto 48)>0 and rs2s(63 downto 48)<0 and tempouts(63 downto 48)<0 then 
				tempouts(63 downto 48) := add16_0 + (32767);
			elsif rs1s(63 downto 48)<0 and rs2s(63 downto 48)>0 and tempouts(63 downto 48)>0 then
				tempouts(63 downto 48) := add16_0 + (-32768);	 
			end if;
			tempouts(47 downto 32) := rs1s(47 downto 32) - rs2s(47 downto 32);
			if rs1s(47 downto 32)>0 and rs2s(47 downto 32)<0 and tempouts(47 downto 32)<0 then 
				tempouts(47 downto 32) := add16_0 + (32767);
			elsif rs1s(47 downto 32)<0 and rs2s(47 downto 32)>0 and tempouts(47 downto 32)>0 then
				tempouts(47 downto 32) := add16_0 + (-32768);	 
			end if;
			tempouts(31 downto 16) := rs1s(31 downto 16) - rs2s(31 downto 16);
			if rs1s(31 downto 16)>0 and rs2s(31 downto 16)<0 and tempouts(31 downto 16)<0 then 
				tempouts(31 downto 16) := add16_0 + (32767);
			elsif rs1s(31 downto 16)<0 and rs2s(31 downto 16)>0 and tempouts(31 downto 16)>0 then
				tempouts(31 downto 16) := add16_0 + (-32768);	 
			end if;
			tempouts(15 downto 0) := rs1s(15 downto 0) - rs2s(15 downto 0);
			if rs1s(15 downto 0)>0 and rs2s(15 downto 0)<0 and tempouts(15 downto 0)<0 then 
				tempouts(15 downto 0) := add16_0 + (32767);
			elsif rs1s(15 downto 0)<0 and rs2s(15 downto 0)>0 and tempouts(15 downto 0)>0 then
				tempouts(15 downto 0) := add16_0 + (-32768);	 
			end if;
			rd <= std_logic_vector(tempouts);
			
		elsif sg235(13 downto 10) = "1110" then 	--mpyu
			rs1us := unsigned(rs1);
			rs2us := unsigned(rs2);
			tmp16_1us := rs1us(47 downto 32);
			tmp16_2us := rs2us(47 downto 32);
			productus := tmp16_1us * tmp16_2us;
			tempoutus(63 downto 32) := productus;
			
			tmp16_1us := rs1us(15 downto 0);
			tmp16_2us := rs2us(15 downto 0);
			productus := tmp16_1us * tmp16_2us;
			tempoutus(31 downto 0) := productus;
			
			rd <= std_logic_vector(tempoutus);
			
		elsif sg235(13 downto 10) = "1111" then 	--absdb
			rs1us := unsigned(rs1);
			rs2us := unsigned(rs2);
			 
			tempoutus(63 downto 56) := rs1us(63 downto 56) - rs2us(63 downto 56);	
			if rs1us(63 downto 56) < rs2us(63 downto 56) then 
			tempoutus(63 downto 56) := top - tempoutus(63 downto 56) + off;
			end if;
			tempoutus(55 downto 48) := rs1us(55 downto 48) - rs2us(55 downto 48);
			if rs1us(55 downto 48) < rs2us(55 downto 48) then
			tempoutus(55 downto 48) := top - tempoutus(55 downto 48) + off;	
			end if;
			tempoutus(47 downto 40) := rs1us(47 downto 40) - rs2us(47 downto 40); 
			if rs1us(47 downto 40) < rs2us(47 downto 40) then
			tempoutus(47 downto 40) := top - tempoutus(47 downto 40) + off;	
			end if;
			tempoutus(39 downto 32) := rs1us(39 downto 32) - rs2us(39 downto 32);	
			if rs1us(39 downto 32) < rs2us(39 downto 32) then
			tempoutus(39 downto 32) := top - tempoutus(39 downto 32) + off;	
			end if;
			tempoutus(31 downto 24) := rs1us(31 downto 24) - rs2us(31 downto 24);
			if rs1us(31 downto 24) < rs2us(31 downto 24) then
			tempoutus(31 downto 24) := top - tempoutus(31 downto 24) + off;	
			end if;
			tempoutus(23 downto 16) := rs1us(23 downto 16) - rs2us(23 downto 16);	   
			if rs1us(23 downto 16) < rs2us(23 downto 16) then
			tempoutus(23 downto 16) := top - tempoutus(23 downto 16) + off;	
			end if;
			tempoutus(15 downto 8) := rs1us(15 downto 8) - rs2us(15 downto 8);
			if rs1us(15 downto 8) < rs2us(15 downto 8) then
			tempoutus(15 downto 8) := top - tempoutus(15 downto 8) + off;	
			end if;
			tempoutus(7 downto 0) := rs1us(7 downto 0) - rs2us(7 downto 0);
			if rs1us(7 downto 0) < rs2us(7 downto 0) then
			tempoutus(7 downto 0) := top - tempoutus(7 downto 0) + off;	
			end if;
			rd <= std_logic_vector(tempoutus);
--		else
--			rd <= (others => '0');
		end if;													   
	
	end process;
end;
				

				
				
				
		
		
	