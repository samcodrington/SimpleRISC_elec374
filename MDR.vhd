LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY MDR IS
PORT(
	busMuxOut, MDataIn			:	IN std_logic_vector(31 downto 0);
	clr,clk,mdr_in,MDRread		:	IN std_logic;
	output							:	OUT std_logic_vector(31 downto 0)
);
END MDR;


ARCHITECTURE behavioural OF MDR IS	
	BEGIN
	PROCESS(clr, clk, BusMuxOut, MDataIn, MDRRead, mdr_in)
	BEGIN
	IF clr ='1' then
		output <= x"00000000";
	ELSE
		IF rising_edge(clk) then
			IF mdr_in = '1' then
				IF (MDRRead = '0') THEN
					output <= busMuxOut;
				ELSIF (MDRRead = '1') THEN
					output <= MdataIn;
				END IF;
			END IF;
		END IF;
	END IF;
	END PROCESS;
END;