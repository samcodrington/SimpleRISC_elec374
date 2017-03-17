LIBRARY IEEE;
use ieee.std_logic_1164.all;

ENTITY sel_encode_tb IS
END ENTITY;

ARCHITECTURE behavioural OF sel_encode_tb IS
	COMPONENT sel_encode 
		PORT MAP(
			ir_in 							: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			GRAin, GRBin, GRCin, 
			Rin, Rout, BAout 				: IN STD_LOGIC;
			
			C_sign_extended 				: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			RIN_output, Rout_output 	: OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
		);
	END COMPONENT;

	BEGIN

