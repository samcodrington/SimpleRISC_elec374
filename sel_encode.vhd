LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY sel_encode IS
PORT	(
			ir_in 							: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			GRAin, GRBin, GRCin, 
			Rin, Rout, BAout 				: IN STD_LOGIC;
			
			
			C_sign_extended 				: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			RIN_output, Rout_output 	: OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
		);

END ENTITY;
ARCHITECTURE behavioural OF sel_encode IS 
	signal interim : std_logic_vector(3 downto 0);
	signal reg_sel : std_logic_vector(3 downto 0);
	begin
	c_sign_process : process(ir_in)
		begin
		for i in 31 downto 18 loop
			c_sign_extended(i) <= ir_in(18);
		end loop;
		c_sign_extended(17 downto 0) <= ir_in(17 downto 0);
	end process;
	
	init : process(ir_in, GRAin, GRBin, GRCin)
	begin
		if (GRAin ='1') then
			interim <= ir_in(26 downto 23);
		elsif (GRBin = '1') then 
			interim <= ir_in(22 downto 19);
		elsif GRCin = '1' then
			interim <= ir_in(18 downto 15);
		else 
			--shouldn't get here!
		end if;
	end process init;
	
	result : process(interim, Rin, Rout, BAout)
		begin
		if Rin = '1' then
			case interim is
				when "0000" => Rin_output <= b"0000_0000_0000_0001";
				when "0001" => Rin_output <= b"0000_0000_0000_0010";
				when "0010" => Rin_output <= b"0000_0000_0000_0100";
				when "0011" => Rin_output <= b"0000_0000_0000_1000";
				when "0100" => Rin_output <= b"0000_0000_0001_0000";
				when "0101" => Rin_output <= b"0000_0000_0010_0000";
				when "0110" => Rin_output <= b"0000_0000_0100_0000";
				when "0111" => Rin_output <= b"0000_0000_1000_0000";
				when "1000" => Rin_output <= b"0000_0001_0000_0000";
				when "1001" => Rin_output <= b"0000_0010_0000_0000";
				when "1010" => Rin_output <= b"0000_0100_0000_0000";
				when "1011" => Rin_output <= b"0000_1000_0000_0000";
				when "1100" => Rin_output <= b"0001_0000_0000_0000";
				when "1101" => Rin_output <= b"0010_0000_0000_0000";
				when "1110" => Rin_output <= b"0100_0000_0000_0000";
				when "1111" => Rin_output <= b"1000_0000_0000_0000";
				when others => Rin_output <= b"0000_0000_0000_0000";	
			end case;
		else
			Rin_output <= b"0000_0000_0000_0000";	
		end if;
		
		if Rout = '1' then
			case interim is
				when "0000" => 
					if BAout = '1' then
						Rout_output <= b"0000_0000_0000_0001";
					else
						Rout_output <= b"0000_0000_0000_0000";
					end if;
				when "0001" => Rout_output <= b"0000_0000_0000_0010";
				when "0010" => Rout_output <= b"0000_0000_0000_0100";
				when "0011" => Rout_output <= b"0000_0000_0000_1000";
				when "0100" => Rout_output <= b"0000_0000_0001_0000";
				when "0101" => Rout_output <= b"0000_0000_0010_0000";
				when "0110" => Rout_output <= b"0000_0000_0100_0000";
				when "0111" => Rout_output <= b"0000_0000_1000_0000";
				when "1000" => Rout_output <= b"0000_0001_0000_0000";
				when "1001" => Rout_output <= b"0000_0010_0000_0000";
				when "1010" => Rout_output <= b"0000_0100_0000_0000";
				when "1011" => Rout_output <= b"0000_1000_0000_0000";
				when "1100" => Rout_output <= b"0001_0000_0000_0000";
				when "1101" => Rout_output <= b"0010_0000_0000_0000";
				when "1110" => Rout_output <= b"0100_0000_0000_0000";
				when "1111" => Rout_output <= b"1000_0000_0000_0000";
				when others => Rout_output <= b"0000_0000_0000_0000";
			end case;
		else
			Rout_output <= b"0000_0000_0000_0000";
		end if;	
	end process result;
				
END;