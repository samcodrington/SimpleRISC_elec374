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
	--INTERMEDIARY SIGNALS
	SIGNAL MDMuxOut 		:	std_logic_vector(31 downto 0);
	
	COMPONENT reg32
		PORT(
			input				:	IN std_logic_vector(31 downto 0);
			clr,clk,reg_in	:	IN std_logic ;
			output			:	OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT reg32;
	BEGIN
	
	MDRReg : reg32
	PORT MAP (
		input 	=> MDMuxOut,
		clr 		=> clr,
		clk 		=> clk,
		reg_in 	=> mdr_in,
		output 	=> output
	);
	
	PROCESS(clk, BusMuxOut, MDataIn, MDRRead)
	BEGIN
		IF (MDRRead = '0') THEN
			MDMuxOut <= busMuxOut;
		ELSIF (MDRRead = '1') THEN
			MDMuxOut <= MdataIn;
		END IF;
	END PROCESS;
END;