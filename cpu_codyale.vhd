--GND, GND32 signal being used as a dummy wire for all unitialized control signals, ie. C sign extend, port

LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY work;
ENTITY cpu_codyale IS
	PORT (
		clk, 		clr,
		--CONTROL PORTS
		R00In,	R01In,	R02In,	R03In,	R04In,	R05In,	R06In,	R07In,	
		R08In,	R09In,	R10In,	R11In,	R12In,	R13In,	R14In,	R15In,
		HIIn,		LOIn, 	PCIn,		IRin,		ZIn,		Yin,		
		MARin,	MDRin, 	MDRRead,
		R00Out,	R01Out,	R02Out,	R03Out,	R04Out,	R05Out,	R06Out,	R07Out,	
		R08Out,	R09Out,	R10Out,	R11Out,	R12Out,	R13Out,	R14Out,	R15Out,
		HIOut,	LOOut, 	PCOut,	ZHIOut,	ZLOOut,	
		YOut,		MDROut	: IN STD_LOGIC;
		Op						: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		MDATAin				: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		--END CTL PORTS
		
		--DEMONSTRATION PORTS
		d_R00Out,	d_R01Out,	d_R02Out,	d_R03Out,	d_R04Out,	d_R05Out,	d_R06Out,	d_R07Out,
		d_R08Out,	d_R09Out,	d_R10Out,	d_R11Out,	d_R12Out,	d_R13Out,	d_R14Out,	d_R15Out,
		d_HIOut,		d_LOOut,		d_PCOut,		d_MDROut,	d_BusMuxOut 	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		d_ZOut																			: OUT STD_LOGIC_VECTOR(63 DOWNTO 0)	
		--END DEMO PORTS
	);
END cpu_codyale;

ARCHITECTURE arch OF cpu_codyale IS
--SIGNALS
	SIGNAL 
	w_BusMuxOut,
	BusMuxInR00,	BusMuxInR01,	BusMuxInR02,	BusMuxInR03,
	BusMuxInR04,	BusMuxInR05,	BusMuxInR06,	BusMuxInR07,
	BusMuxInR08,	BusMuxInR09,	BusMuxInR10,	BusMuxInR11,
	BusMuxInR12,	BusMuxInR13,	BusMuxInR14,	BusMuxInR15,
	BusMuxInHI,		BusMuxInLO,		BusMuxInZHI,	BusMuxInZLO,
	BusMuxInPC,		BusMuxInMDR,	BusMuxInPort,	BusMuxInC : std_logic_vector(31 downto 0);
	
	--temporary signals
	SIGNAL gnd		: std_logic :='0';
	SIGNAL gnd32	: std_logic_vector(31 downto 0) := x"0000_0000"; 
	
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
	
	COMPONENT cpu_bus
	PORT(
		R00out, R01out, R02out, R03out,
		R04out, R05out, R06out, R07out,
		R08out, R09out, R10out, R11out,
		R12out, R13out, R14out, R15out,
		hiout, loout, zhiout, zloout,
		pcout, mdrout, portout, cOut: IN std_logic;
		r00in, r01in, r02in, r03in,
		r04in, r05in, r06in, r07in, 
		r08in, r09in, r10in, r11in, 
		r12in, r13in, r14in, r15in, 
		HIin, LOin, ZHiIn, ZLoIn,
		PCin, MDRin, portIn, cIn	:	IN std_logic_vector(31 downto 0);
		BusMuxOut	:	OUT std_logic_vector(31 downto 0)
	);
	END COMPONENT cpu_bus;
	
	COMPONENT ALU
	PORT(
		Ain, Bin				:	IN std_logic_vector(31 downto 0);
		clk					:  IN std_logic;
		op						:	IN std_logic_vector (4 downto 0);
		Zout					:	OUT std_logic_vector(31 downto 0)
	);
	END COMPONENT ALU;
		
	
BEGIN 
	-- INSTANTIATION OF COMPONENTS
	
	--Registers
	R00 : reg32	PORT MAP (input => w_BusMuxOut,	clr=>clr,	clk=>clk,	reg_in=>R00in,	output=> BusMuxInR00);
	R01 : reg32	PORT MAP (input => w_BusMuxOut,	clr=>clr,	clk=>clk,	reg_in=>R01in,	output=> BusMuxInR01);
	R02 : reg32	PORT MAP (input => w_BusMuxOut,	clr=>clr,	clk=>clk,	reg_in=>R02in,	output=> BusMuxInR02);
	R03 : reg32	PORT MAP (input => w_BusMuxOut,	clr=>clr,	clk=>clk,	reg_in=>R03in,	output=> BusMuxInR03);
	R04 : reg32	PORT MAP (input => w_BusMuxOut,	clr=>clr,	clk=>clk,	reg_in=>R04in,	output=> BusMuxInR04);
	R05 : reg32	PORT MAP (input => w_BusMuxOut,	clr=>clr,	clk=>clk,	reg_in=>R05in,	output=> BusMuxInR05);
	R06 : reg32	PORT MAP (input => w_BusMuxOut,	clr=>clr,	clk=>clk,	reg_in=>R06in,	output=> BusMuxInR06);
	R07 : reg32	PORT MAP (input => w_BusMuxOut,	clr=>clr,	clk=>clk,	reg_in=>R07in,	output=> BusMuxInR07);
	R08 : reg32	PORT MAP (input => w_BusMuxOut,	clr=>clr,	clk=>clk,	reg_in=>R08in,	output=> BusMuxInR08);
	R09 : reg32	PORT MAP (input => w_BusMuxOut,	clr=>clr,	clk=>clk,	reg_in=>R09in,	output=> BusMuxInR09);
	R10 : reg32	PORT MAP (input => w_BusMuxOut,	clr=>clr,	clk=>clk,	reg_in=>R10in,	output=> BusMuxInR10);
	R11 : reg32	PORT MAP (input => w_BusMuxOut,	clr=>clr,	clk=>clk,	reg_in=>R11in,	output=> BusMuxInR11);
	R12 : reg32	PORT MAP (input => w_BusMuxOut,	clr=>clr,	clk=>clk,	reg_in=>R12in,	output=> BusMuxInR12);
	R13 : reg32	PORT MAP (input => w_BusMuxOut,	clr=>clr,	clk=>clk,	reg_in=>R13in,	output=> BusMuxInR13);
	R14 : reg32	PORT MAP (input => w_BusMuxOut,	clr=>clr,	clk=>clk,	reg_in=>R14in,	output=> BusMuxInR14);
	R15 : reg32	PORT MAP (input => w_BusMuxOut,	clr=>clr,	clk=>clk,	reg_in=>R15in,	output=> BusMuxInR15);

	HI : reg32  PORT MAP (input => w_BusMuxOut,	clr=>clr,	clk=>clk,	reg_in=>HIin,	output=> BusMuxInHI);	-- to/from BUS
	LO : reg32	PORT MAP (input => w_BusMuxOut,	clr=>clr,	clk=>clk,	reg_in=>LOin,	output=> BusMuxInLO); -- to/from BUS
	ZHI : reg32	PORT MAP (input => gnd32,		clr=>clr,	clk=>clk,	reg_in=>	Zin,	output=> BusMuxInZHI); -- FROM ALU to BUS
 	ZLO : reg32	PORT MAP (input => gnd32,		clr=>clr,	clk=>clk,	reg_in=>	Zin,	output=> BusMuxInZLO); -- FROM ALU to BUS	
	Y  : reg32  PORT MAP (input => w_BusMuxOut,	clr=>clr,	clk=>clk,	reg_in=> Yin, 	output=> open); -- FROM BUS TO ALU
	PC : reg32	PORT MAP (input => w_BusMuxOut, clr=>clr,	clk=>clk,	reg_in=>	PCin,	output=> BusMuxInPC); --to/from BUS
	IR : reg32  PORT MAP (input => w_BusMuxOut, clr=>clr,	clk=>clk,	reg_in=>	IRin,	output=> open); --from BUS to OUT??
	
	MDR_inst : MDR
	PORT MAP(
		busMuxOut =>w_busMuxOut,
		MDataIn	=> MDataIn,
		clr 		=> clr,
		clk		=> clk,
		mdr_in	=> MDRin,
		MDRread	=> MDRread,
		output	=> BusMuxInMDR					
	);
	
	cpu_bus_inst : cpu_bus
	PORT MAP(
		R00out=>R00out, 	R01out=>R01out,	R02out=>R02out,	R03out=>R03out,
		R04out=>R04out, 	R05out=>R05out,	R06out=>R06out,	R07out=>R07out,
		R08out=>R08out, 	R09out=>R09out,	R10out=>R10out,	R11out=>R11out,
		R12out=>R12out, 	R13out=>R13out,	R14out=>R14out,	R15out=>R15out,
		hiout=>hiout,		loout=>loout,		zhiout=>zhiout,	zloout=>zloout,
		pcout=>pcout, 		mdrout=>mdrout,	portout=>gnd, cOut=>gnd,
		
		r00in=>BusMuxInR00,	r01in=>BusMuxInR01,	r02in=>BusMuxInR02,	r03in=>BusMuxInR03,
		r04in=>BusMuxInR04,	r05in=>BusMuxInR05,	r06in=>BusMuxInR06,	r07in=>BusMuxInR07, 
		r08in=>BusMuxInR08,	r09in=>BusMuxInR09,	r10in=>BusMuxInR10,	r11in=>BusMuxInR11,
		r12in=>BusMuxInR12,	r13in=>BusMuxInR13,	r14in=>BusMuxInR14,	r15in=>BusMuxInR15, 
		HIin=>BusMuxInHI,		LOin=>BusMuxInLO,		ZHiIn=>BusMuxInZHI,	ZLoIn=>BusMuxInZLO,
		PCin=>BusMuxInPC,		MDRin=>BusMuxInMDR,	portIn=>gnd32,		cIn=>gnd32,	
		BusMuxOut=>w_BusMuxOut	
	);

	
		
END;