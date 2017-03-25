LIBRARY IEEE;
use ieee.std_logic_1164.all;

ENTITY r0_reg32 is
	PORT(
		input						:	IN std_logic_vector(31 downto 0);
		clr,clk,reg_in, BAout	:	IN std_logic;
		output						:	OUT std_logic_vector(31 downto 0)	
	);
END ENTITY;

ARCHITECTURE structural OF r0_reg32 IS
	COMPONENT reg32 
	PORT ( 
		input				:	IN std_logic_vector(31 downto 0);
		clr,clk,reg_in									:	IN std_logic;
		output											:	OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	SIGNAL internal_out : std_logic_vector(31 downto 0);
BEGIN	
	inst : reg32 PORT MAP (input, clr, clk, reg_in, internal_out);
	output(0) <= internal_out(0) and not BAout;
	output(1) <= internal_out(1) and not BAout;
	output(2) <= internal_out(2) and not BAout;
	output(3) <= internal_out(3) and not BAout;
	output(4) <= internal_out(4) and not BAout;
	output(5) <= internal_out(5) and not BAout;
	output(6) <= internal_out(6) and not BAout;
	output(7) <= internal_out(7) and not BAout;
	output(8) <= internal_out(8) and not BAout;
	output(9) <= internal_out(9) and not BAout;
	output(10) <= internal_out(10) and not BAout;
	output(11) <= internal_out(11) and not BAout;
	output(12) <= internal_out(12) and not BAout;
	output(13) <= internal_out(13) and not BAout;
	output(14) <= internal_out(14) and not BAout;
	output(15) <= internal_out(15) and not BAout;
	output(16) <= internal_out(16) and not BAout;
	output(17) <= internal_out(17) and not BAout;
	output(18) <= internal_out(18) and not BAout;
	output(19) <= internal_out(19) and not BAout;
	output(20) <= internal_out(20) and not BAout;
	output(21) <= internal_out(21) and not BAout;
	output(22) <= internal_out(22) and not BAout;
	output(23) <= internal_out(23) and not BAout;
	output(24) <= internal_out(24) and not BAout;
	output(25) <= internal_out(25) and not BAout;
	output(26) <= internal_out(26) and not BAout;
	output(27) <= internal_out(27) and not BAout;
	output(28) <= internal_out(28) and not BAout;
	output(29) <= internal_out(29) and not BAout;
	output(30) <= internal_out(30) and not BAout;
	output(31) <= internal_out(31) and not BAout;	
END;