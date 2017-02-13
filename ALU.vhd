LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY ALU IS
PORT(
	Ain, Bin				:	IN std_logic_vector(31 downto 0);
	clk					:  IN std_logic;
	op						:	IN std_logic_vector (4 downto 0);
	Zout					:	OUT std_logic_vector(63 downto 0)
);
END ALU;

ARCHITECTURE behavioural OF ALU IS
signal w_and_out : std_logic_vector;
BEGIN
	case op IS
		when "00000" => 
			Zout <= w_and_out;
	
END;