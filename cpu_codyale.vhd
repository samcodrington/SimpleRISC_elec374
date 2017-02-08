LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY work;
ENTITY cpu_codyale IS
	PORT (
		R00In,	R01In,	R02In,	R03In,	R04In,	R05In,	R06In,	R07In,	
		R08In,	R09In,	R10In,	R11In,	R12In,	R13In,	R14In,	R15In,
		HIIn,		LOIn, 	ZIn,		PCIn,		IRin,		Zin,		Yin,		
		MARin,	MDRin, 	MDRRead : IN STD_LOGIC;
		MDATAin				: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		
		R00Out,	R01Out,	R02Out,	R03Out,	R04Out,	R05Out,	R06Out,	R07Out,
		R08Out,	R09Out,	R10Out,	R11Out,	R12Out,	R13Out,	R14Out,	R15Out,
		HIOut,	LOOut,	PCOut,	ZHIOut,	ZLOOut,	MDROut : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
		
		
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
	
	COMPONENT MDR
	PORT(
		busMuxOut, MDataIn			:	IN std_logic_vector(31 downto 0);
		clr,clk,mdr_in,MDRread		:	IN std_logic;
		output							:	OUT std_logic_vector(31 downto 0)
	);
	END COMPONENT MDR;
	
BEGIN 
	-- INSTANTIATION OF COMPONENTS
	--Registers
	R00 : reg32	PORT MAP (input => BusMuxOut,	clr=>clr,	clk=>clk,	reg_in=>R00in,	output=> BusMuxInR00);
	R01 : reg32	PORT MAP (input => BusMuxOut,	clr=>clr,	clk=>clk,	reg_in=>R01in,	output=> BusMuxInR01);
	R02 : reg32	PORT MAP (input => BusMuxOut,	clr=>clr,	clk=>clk,	reg_in=>R02in,	output=> BusMuxInR02);
	R03 : reg32	PORT MAP (input => BusMuxOut,	clr=>clr,	clk=>clk,	reg_in=>R03in,	output=> BusMuxInR03);
	R04 : reg32	PORT MAP (input => BusMuxOut,	clr=>clr,	clk=>clk,	reg_in=>R04in,	output=> BusMuxInR04);
	R05 : reg32	PORT MAP (input => BusMuxOut,	clr=>clr,	clk=>clk,	reg_in=>R05in,	output=> BusMuxInR05);
	R06 : reg32	PORT MAP (input => BusMuxOut,	clr=>clr,	clk=>clk,	reg_in=>R06in,	output=> BusMuxInR06);
	R07 : reg32	PORT MAP (input => BusMuxOut,	clr=>clr,	clk=>clk,	reg_in=>R07in,	output=> BusMuxInR07);
	R08 : reg32	PORT MAP (input => BusMuxOut,	clr=>clr,	clk=>clk,	reg_in=>R08in,	output=> BusMuxInR08);
	R09 : reg32	PORT MAP (input => BusMuxOut,	clr=>clr,	clk=>clk,	reg_in=>R09in,	output=> BusMuxInR09);
	R10 : reg32	PORT MAP (input => BusMuxOut,	clr=>clr,	clk=>clk,	reg_in=>R10in,	output=> BusMuxInR10);
	R11 : reg32	PORT MAP (input => BusMuxOut,	clr=>clr,	clk=>clk,	reg_in=>R11in,	output=> BusMuxInR11);
	R12 : reg32	PORT MAP (input => BusMuxOut,	clr=>clr,	clk=>clk,	reg_in=>R12in,	output=> BusMuxInR12);
	R13 : reg32	PORT MAP (input => BusMuxOut,	clr=>clr,	clk=>clk,	reg_in=>R13in,	output=> BusMuxInR13);
	R14 : reg32	PORT MAP (input => BusMuxOut,	clr=>clr,	clk=>clk,	reg_in=>R14in,	output=> BusMuxInR14);
	R15 : reg32	PORT MAP (input => BusMuxOut,	clr=>clr,	clk=>clk,	reg_in=>R15in,	output=> BusMuxInR15);

	HI : reg32  PORT MAP (input => BusMuxOut,	clr=>clr,	clk=>clk,	reg_in=>HIin,	output=> BusMuxInHI);	-- to/from BUS
	LO : reg32	PORT MAP (input => BusMuxOut,	clr=>clr,	clk=>clk,	reg_in=>LOin,	output=> BusMuxInLO); -- to/from BUS
	ZHI : reg32	PORT MAP (input => inputZHI,	clr=>clr,	clk=>clk,	reg_in=>	ZHIin,	output=> BusMuxInZHI); -- FROM ALU to BUS
 	ZLO : reg32	PORT MAP (input => inputZLO,	clr=>clr,	clk=>clk,	reg_in=>	ZLOin,	output=> BusMuxInZLO); -- FROM ALU to BUS	
	--Y  : reg32  PORT MAP (input => ,	clr=>clr,	clk=>clk,	reg_in=> Yin, 	output=> ALU_A); -- FROM BUS TO ALU
	PC : reg32	PORT MAP (input => BusMuxOut, clr=>clr,	clk=>clk,	reg_in=>	PCin,	output=> BusMuxInPC); --to/from BUS
	--IR : reg32  PORT MAP (input => , clr=>clr,	clk=>clk,	reg_in=>	IRin,	output=> IROut); --from BUS to OUT
	MDR : MDR
	PORT MAP(
		busMuxOut =>busMuxOut,
		MDataIn	=> MDataIn,
		clr => clr, clk=>clk,mdr_in=>MDRin, MDRread => MDRread,
		output => BusMuxInMDR					
	);
	
	cpu_bus : cpu_bus
	PORT MAP(
	

	
		
END;