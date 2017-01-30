LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY reg32 IS
PORT(
	input				:	IN std_logic_vector(31 downto 0);
	clr,clk,reg_in	:	IN std_logic;
	output			:	OUT std_logic_vector(31 downto 0)
);
END reg32;


ARCHITECTURE behavioural OF reg32 IS
BEGIN
	Reg32: PROCESS(clk)
	BEGIN
		IF (clr = '1') THEN
				output <= b"0000_0000_0000_0000_0000_0000_0000_0000";
		ELSIF rising_edge(clk) THEN
			IF (reg_in = '1') THEN
				output <= input;
			END IF;
		END IF;
	END PROCESS;
END behavioural;