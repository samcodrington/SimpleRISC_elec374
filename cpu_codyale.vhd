LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY work;
ENTITY cpu_codyale IS
	PORT (
	
	--	inputr00, inputr01, inputR02, inputR03,
	--	inputr04, inputr05, inputR06, inputR07,
	--	inputr08, inputr09, inputR10, inputR11,
	--	inputr00, inputr01, inputR02, inputR03,
		
		
	);
END cpu_codyale;

ARCHITECTURE arch OF cpu_codyale IS
--COMPONENTS
	COMPONENT reg32
		PORT(
			input				:	IN std_logic_vector(31 downto 0);
			clr,clk,reg_in	:	IN std_logic ;
			output			:	OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT reg32;
	
BEGIN 
	-- INSTANTIATION OF COMPONENTS
	R00 : reg32
	PORT MAP (
		input => input00,
		clr 	=> clr,
		clk	=> clk,
		reg_in=>	reg_in00,
		output=> --BUS
	);
	R01 : reg32
	PORT MAP (
		input => input01,
		clr 	=> clr,
		clk	=> clk,
		reg_in=>	reg_in01,
		output=> --BUS
	);
	R02 : reg32
	PORT MAP (
		input => input02,
		clr 	=> clr,
		clk	=> clk,
		reg_in=>	reg_in02,
		output=> --BUS
	);
	R03 : reg32
	PORT MAP (
		input => input03,
		clr 	=> clr,
		clk	=> clk,
		reg_in=>	reg_in03,
		output=> --BUS
	);
	R04 : reg32
	PORT MAP (
		input => input04,
		clr 	=> clr,
		clk	=> clk,
		reg_in=>	reg_in04,
		output=> --BUS
	);
	R05 : reg32
	PORT MAP (
		input => input05,
		clr 	=> clr,
		clk	=> clk,
		reg_in=>	reg_in05,
		output=> --BUS
	);
	R06 : reg32
	PORT MAP (
		input => input06,
		clr 	=> clr,
		clk	=> clk,
		reg_in=>	reg_in06,
		output=> --BUS
	);
	R07 : reg32
	PORT MAP (
		input => input07,
		clr 	=> clr,
		clk	=> clk,
		reg_in=>	reg_in07,
		output=> --BUS
	);
	R08 : reg32
	PORT MAP (
		input => input08,
		clr 	=> clr,
		clk	=> clk,
		reg_in=>	reg_in08,
		output=> --BUS
	);
	R09 : reg32
	PORT MAP (
		input => input09,
		clr 	=> clr,
		clk	=> clk,
		reg_in=>	reg_in09,
		output=> --BUS
	);
	R10 : reg32
	PORT MAP (
		input => input10,
		clr 	=> clr,
		clk	=> clk,
		reg_in=>	reg_in10,
		output=> --BUS
	);
	R11 : reg32
	PORT MAP (
		input => input11,
		clr 	=> clr,
		clk	=> clk,
		reg_in=>	reg_in11,
		output=> --BUS
	);
	R12 : reg32
	PORT MAP (
		input => input12,
		clr 	=> clr,
		clk	=> clk,
		reg_in=>	reg_in12,
		output=> --BUS
	);
	R13 : reg32
	PORT MAP (
		input => input13,
		clr 	=> clr,
		clk	=> clk,
		reg_in=>	reg_in13,
		output=> --BUS
	);
	R14 : reg32
	PORT MAP (
		input => input14,
		clr 	=> clr,
		clk	=> clk,
		reg_in=>	reg_in14,
		output=> --BUS
	);
	R15 : reg32
	PORT MAP (
		input => input15,
		clr 	=> clr,
		clk	=> clk,
		reg_in=>	reg_in15,
		output=> --BUS
	);
	HI : reg32
	PORT MAP (
		input => inputHI,
		clr 	=> clr,
		clk	=> clk,
		reg_in=>	reg_inHI,
		output=> --BUS
	);
	LO: reg32
	PORT MAP (
		input => inputLO,
		clr 	=> clr,
		clk	=> clk,
		reg_in=>	reg_inLO,
		output=> --BUS
	);
	ZHI : reg32
	PORT MAP (
		input => inputZHI,
		clr 	=> clr,
		clk	=> clk,
		reg_in=>	reg_inZHI,
		output=> --BUS
	);
	ZLO: reg32
	PORT MAP (
		input => inputZLO,
		clr 	=> clr,
		clk	=> clk,
		reg_in=>	reg_inZLO,
		output=> --BUS
	);
	---MDR GOES HERE
	Y: reg32
	PORT MAP (
		input => inputY,
		clr 	=> clr,
		clk	=> clk,
		reg_in=>	reg_inY,
		output=> --ALU
	);
END;