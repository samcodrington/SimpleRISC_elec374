--GND, GND32 signal being used as a dummy wire for all unitialized control signals, ie. C sign extend, port

LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY work;
ENTITY cpu_codyale IS
	PORT (
		clk, 		
		--CONTROL PORTS
			clr,		IncPC,	MemRead, WriteSig,
			--REGISTER CONTROL PORTS
			BAout,	GRA,		GRB,		GRC,		Rin,		Rout,
			--NON-REGISTER CONTROL PORTS 
			-- Enables
			HIIn,		LOIn, 	PCIn,		IRin,		ZIn,		Yin,
			MARin,	MDRin, 	Conin,	
			--BusMuxSelects
			HIOut,	LOOut,	ZHIOut,	ZLOOut, 	PCOut, 	MDROut,	PortOut, Cout			: IN STD_LOGIC;
			PortIn	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		--END CTL PORTS
		
		--DEMONSTRATION PORTS
			d_R00Out,	d_R01Out,	d_R02Out,	d_R03Out,	d_R04Out,	d_R05Out,	d_R06Out,	d_R07Out,
			d_R08Out,	d_R09Out,	d_R10Out,	d_R11Out,	d_R12Out,	d_R13Out,	d_R14Out,	d_R15Out,
			d_HIOut,		d_LOOut,		d_PCOut,		d_MDROut,	d_BusMuxOut, d_IROut, 	d_YOut,		d_C_sign_extended,
			d_ZLoOut, 	d_ZHiOut : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
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
	BusMuxInPC,		BusMuxInMDR,	BusMuxInPort,	BusMuxInC,
	w_IRout,
	MARout, 			MDataIn			: std_logic_vector(31 downto 0);
	
	SIGNAL 	Rin_sel, Rout_sel : std_logic_vector(15 downto 0); -- Select & Encode Outputs
	SIGNAL w_con_ff_out : std_logic; --CON-FF output (to Control unit?)
	
	
	SIGNAL w_y2alu : std_logic_vector(31 downto 0);
	SIGNAL w_alu2z : std_logic_vector(63 downto 0);
	SIGNAL w_z2zhi, w_z2zlo : std_logic_vector(31 downto 0);
	
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
	
	COMPONENT r0_reg32
		PORT(
			input							:	IN std_logic_vector(31 downto 0);
			clr,clk,reg_in, BAout	:	IN std_logic;
			output						:	OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT r0_reg32;
	
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
		opcode				:	IN std_logic_vector (4 downto 0);
		IncPC					:  IN std_logic;
		Zout					:	OUT std_logic_vector(63 downto 0)
	);
	END COMPONENT ALU;
	
	component ram
	PORT
	(
		address		: IN STD_LOGIC_VECTOR (8 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		rden		: IN STD_LOGIC  := '1';
		wren		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
	end component;

	COMPONENT sel_encode 
		PORT(
			ir_in 							: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			GRAin, GRBin, GRCin, 
			Rin, Rout, BAout 				: IN STD_LOGIC;
			
			C_sign_extended 				: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			RIN_output, Rout_output 	: OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
		);
	END COMPONENT;	
	
	COMPONENT con_ff
		PORT(
			busin	: IN STD_LOGIC_VECTOR(31 downto 0);
			IRin	: IN STD_LOGIC_VECTOR(1 downto 0);
			CONin : IN STD_LOGIC;
			Q		: OUT STD_LOGIC
		);
	END COMPONENT;
		
	
BEGIN 
-- INSTANTIATION OF COMPONENTS
	con_ff_inst : con_ff
	PORT MAP(
		busin	=>w_BusMuxOut,
	   IRin	=>w_IRout(1 downto 0),
	   CONin =>CONin,
	   Q		=>w_con_ff_out
	);
	sel_encode_inst : sel_encode
	PORT MAP(
		ir_in => w_IRout,						
		GRAin => GRA,
		GRBin => GRB,
		GRCin => GRC,
		Rin =>   Rin,
		Rout =>  Rout,
		BAout => BAout,		
		C_sign_extended => BusMuxInC,				
		RIN_output => RIn_sel,
		Rout_output => Rout_sel		
	);
	MAR : reg32 PORT MAP (input => w_BusMuxOut, 	clr=>clr,	clk=>clk,	reg_in=>MARin, output=> MARout); -- BUS to RAM
	
	MDR_inst : MDR
	PORT MAP(
		busMuxOut =>w_busMuxOut,
		MDataIn	=> MDataIn,
		clr 		=> clr,
		clk		=> clk,
		mdr_in	=> MDRin,
		MDRread	=> MemRead,
		output	=> BusMuxInMDR					
	);
	ram_inst : ram
	PORT MAP(
		address=> MARout(8 downto 0),
		clock	=> clk,
		data	=> BusMuxInMDR,
		rden	=> MemRead,
		wren	=> WriteSig,
		q		 => MDataIn
	);
	--Registers
	R00 : r0_reg32	PORT MAP (input => w_BusMuxOut,	clr=>clr,	clk=>clk,	reg_in=>Rin_sel(0),	BAout => BAout, output=> BusMuxInR00);
	R01 : reg32	PORT MAP (input => w_BusMuxOut,	clr=>clr,	clk=>clk,	reg_in=>Rin_sel(1),		output=> BusMuxInR01);
	R02 : reg32	PORT MAP (input => w_BusMuxOut,	clr=>clr,	clk=>clk,	reg_in=>Rin_sel(2),		output=> BusMuxInR02);
	R03 : reg32	PORT MAP (input => w_BusMuxOut,	clr=>clr,	clk=>clk,	reg_in=>Rin_sel(3),		output=> BusMuxInR03);
	R04 : reg32	PORT MAP (input => w_BusMuxOut,	clr=>clr,	clk=>clk,	reg_in=>Rin_sel(4),		output=> BusMuxInR04);
	R05 : reg32	PORT MAP (input => w_BusMuxOut,	clr=>clr,	clk=>clk,	reg_in=>Rin_sel(5),		output=> BusMuxInR05);
	R06 : reg32	PORT MAP (input => w_BusMuxOut,	clr=>clr,	clk=>clk,	reg_in=>Rin_sel(6),		output=> BusMuxInR06);
	R07 : reg32	PORT MAP (input => w_BusMuxOut,	clr=>clr,	clk=>clk,	reg_in=>Rin_sel(7),		output=> BusMuxInR07);
	R08 : reg32	PORT MAP (input => w_BusMuxOut,	clr=>clr,	clk=>clk,	reg_in=>Rin_sel(8),		output=> BusMuxInR08);
	R09 : reg32	PORT MAP (input => w_BusMuxOut,	clr=>clr,	clk=>clk,	reg_in=>Rin_sel(9),		output=> BusMuxInR09);
	R10 : reg32	PORT MAP (input => w_BusMuxOut,	clr=>clr,	clk=>clk,	reg_in=>Rin_sel(10),		output=> BusMuxInR10);
	R11 : reg32	PORT MAP (input => w_BusMuxOut,	clr=>clr,	clk=>clk,	reg_in=>Rin_sel(11),		output=> BusMuxInR11);
	R12 : reg32	PORT MAP (input => w_BusMuxOut,	clr=>clr,	clk=>clk,	reg_in=>Rin_sel(12),		output=> BusMuxInR12);
	R13 : reg32	PORT MAP (input => w_BusMuxOut,	clr=>clr,	clk=>clk,	reg_in=>Rin_sel(13),		output=> BusMuxInR13);
	R14 : reg32	PORT MAP (input => w_BusMuxOut,	clr=>clr,	clk=>clk,	reg_in=>Rin_sel(14),		output=> BusMuxInR14);
	R15 : reg32	PORT MAP (input => w_BusMuxOut,	clr=>clr,	clk=>clk,	reg_in=>Rin_sel(15),		output=> BusMuxInR15);

	HI : reg32  PORT MAP (input => w_BusMuxOut,	clr=>clr,	clk=>clk,	reg_in=>HIin,	output=> BusMuxInHI);	-- to/from BUS
	LO : reg32	PORT MAP (input => w_BusMuxOut,	clr=>clr,	clk=>clk,	reg_in=>LOin,	output=> BusMuxInLO); -- to/from BUS
	ZHI : reg32	PORT MAP (input => w_alu2z(63 downto 32),		clr=>clr,	clk=>clk,	reg_in=>	Zin,	output=> BusMuxInZHI); -- FROM ALU to BUS
 	ZLO : reg32	PORT MAP (input => w_alu2z(31 downto 0),		clr=>clr,	clk=>clk,	reg_in=>	Zin,	output=> BusMuxInZLO); -- FROM ALU to BUS	
	Y  : reg32  PORT MAP (input => w_BusMuxOut,	clr=>clr,	clk=>clk,	reg_in=> Yin, 	output=> w_y2ALU); -- FROM BUS TO ALU
	PC : reg32	PORT MAP (input => w_BusMuxOut,	clr=>clr,	clk=>clk,	reg_in=>	PCin,	output=> BusMuxInPC); --to/from BUS
	IR : reg32  PORT MAP (input => w_BusMuxOut, 	clr=>clr,	clk=>clk,	reg_in=>	IRin,	output=> w_IRout); --from BUS to OUT??

	cpu_bus_inst : cpu_bus
	PORT MAP(
		R00out=>Rout_sel(0),		R01out=>Rout_sel(1),		R02out=>Rout_sel(2),		R03out=>Rout_sel(3),
		R04out=>Rout_sel(4), 	R05out=>Rout_sel(5),		R06out=>Rout_sel(6),		R07out=>Rout_sel(7),
		R08out=>Rout_sel(8),		R09out=>Rout_sel(9),		R10out=>Rout_sel(10),	R11out=>Rout_sel(11),
		R12out=>Rout_sel(12),	R13out=>Rout_sel(13),	R14out=>Rout_sel(14),	R15out=>Rout_sel(15),
		hiout=>hiout,		loout=>loout,		zhiout=>zhiout,	zloout=>zloout,
		pcout=>pcout, 		mdrout=>MDROut,	portout=>PortOut, cOut=>Cout,
		
		r00in=>BusMuxInR00,	r01in=>BusMuxInR01,	r02in=>BusMuxInR02,	r03in=>BusMuxInR03,
		r04in=>BusMuxInR04,	r05in=>BusMuxInR05,	r06in=>BusMuxInR06,	r07in=>BusMuxInR07, 
		r08in=>BusMuxInR08,	r09in=>BusMuxInR09,	r10in=>BusMuxInR10,	r11in=>BusMuxInR11,
		r12in=>BusMuxInR12,	r13in=>BusMuxInR13,	r14in=>BusMuxInR14,	r15in=>BusMuxInR15, 
		HIin=>BusMuxInHI,		LOin=>BusMuxInLO,		ZHiIn=>BusMuxInZHI,	ZLoIn=>BusMuxInZLO,
		PCin=>BusMuxInPC,		MDRin=>BusMuxInMDR,	portIn=>PortIn,		cIn=>BusMuxInC,	
		BusMuxOut=>w_BusMuxOut	
	);
	ALU_inst : ALU
	PORT MAP(
		Ain => w_y2alu, Bin =>w_BusMuxOut,
		opcode => MDataIn(31 downto 27),
		IncPC => IncPC,
		Zout => w_alu2z
	);
	
	process(clk,clr,BusMuxInR00,	BusMuxInR01,	BusMuxInR02,	BusMuxInR03,
	BusMuxInR04,	BusMuxInR05,	BusMuxInR06,	BusMuxInR07,
	BusMuxInR08,	BusMuxInR09,	BusMuxInR10,	BusMuxInR11,
	BusMuxInR12,	BusMuxInR13,	BusMuxInR14,	BusMuxInR15,
	BusMuxInHI,		BusMuxInLO,		BusMuxInZHI,	BusMuxInZLO,
	BusMuxInPC,		BusMuxInMDR,	BusMuxInPort,	BusMuxInC, w_IRout )
	begin
		d_R00Out <= BusMuxInR00;
		d_R01Out <= BusMuxInR01;
		d_R02Out <= BusMuxInR02;
		d_R03Out <= BusMuxInR03;
		d_R04Out <= BusMuxInR04;
		d_R05Out <= BusMuxInR05;
		d_R06Out <= BusMuxInR06;
		d_R07Out <= BusMuxInR07;
		d_R08Out <= BusMuxInR08;
		d_R09Out <= BusMuxInR09;
		d_R10Out <= BusMuxInR10;
		d_R11Out <= BusMuxInR11;
		d_R12Out <= BusMuxInR12;
		d_R13Out <= BusMuxInR13;
		d_R14Out <= BusMuxInR14;
		d_R15Out <= BusMuxInR15;
		d_HIOut  <= BusMuxInHi;	
		d_LOOut  <= BusMuxInLo;	
		d_PCOut  <= BusMuxInPC;	
		d_MDROut <= BusMuxInMDR;
		d_BusMuxOut <= w_BusMuxOut; 
		d_YOut	<= w_y2ALU;
		d_ZHiOut <= BusMuxInZHi;
		d_ZLoOut <= BusMuxInZLo;
		d_IRout <= w_IRout;
		d_C_sign_extended <= BusMuxInC;
	end process;
	
		
END;
