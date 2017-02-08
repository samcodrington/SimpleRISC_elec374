LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY ALU IS
PORT(
	Ain, Bin				:	IN std_logic_vector(31 downto 0);
	clr,clk,reg_in	:	IN std_logic;
	Zout			:	OUT std_logic_vector(31 downto 0)
);
END ALU;

ARCHITECTURE behavioural OF ALU IS
BEGIN
	--DO STUFF
END;