Library ieee;
USE ieee.std_logic_1164.all;

ENTITY cpu_codyale_tb IS
END;

ARCHITECTURE cpu_codyale_tb_arch OF cpu_codyale_tb IS
--SIGNALS & COMPONENTS
COMPONENT cpu_codyale IS
PORT(
		--CONTROL PORTS
			clk,	clr,	IncPC,	MemRead, WriteSig,	strobe,	OutPort_en,
			--REGISTER CONTROL PORTS
			BAout,	GRA,		GRB,		GRC,		Rin,		Rout,
			--NON-REGISTER CONTROL PORTS 
			-- Enables
			HIIn,		LOIn, 	PCIn,		IRin,		ZIn,		Yin,
			MARin,	MDRin, 	Conin,	
			--BusMuxSelects
			HIOut,	LOOut,	ZHIOut,	ZLOOut, 	PCOut, 	MDROut,	PortOut, Cout			: IN STD_LOGIC;
			InPort	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		--END CTL PORTS
		
		--DEMONSTRATION PORTS
			d_CON_FF_out	: OUT STD_LOGIC;
			d_R00Out,	d_R01Out,	d_R02Out,	d_R03Out,	d_R04Out,	d_R05Out,	d_R06Out,	d_R07Out,
			d_R08Out,	d_R09Out,	d_R10Out,	d_R11Out,	d_R12Out,	d_R13Out,	d_R14Out,	d_R15Out,
			d_HIOut,		d_LOOut,		d_PCOut,		d_MDROut,	d_BusMuxOut, d_IROut, 	d_YOut,		d_C_sign_extended,
			d_ZLoOut, 	d_ZHiOut,	d_MARout,
			OutPort		: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
		--END DEMO PORTS
);
END COMPONENT;

		--Non Required Signals
		TYPE Operation IS (Default, LoadR2, LoadR3, LoadR4, LoadR5, LoadR6, LoadR7,
		Add, Sub, Mul, Div, AndOp, OrOp, SHR, SHL, RotRight, RotLeft, Neg, NotOp,
		Load, LoadI, LoadR, Store, StoreR, AddI, BranchZero, BranchNZero, BranchPos, BranchNeg,
		Jump, JumpR, Movefhi, Moveflo, Input, Output
		);
		TYPE Stage IS (T0, T1, T2, T3, T4, T5, T6, T7, load);
		SIGNAL CurrentOp : Operation;
		SIGNAL CurrentStage : Stage;
		
		--Required Signals
		--TestBench Signals
		SIGNAL 	clk_tb, 	clr_tb, 	IncPC_tb,MemRd_tb,WriteSig_tb,	strobe_tb, Outport_en_tb, 
		--Register TB Signals
		BAout_tb,	GRA_tb,		GRB_tb,		GRC_tb,		Rin_tb,		Rout_tb,	
		--Non-Register TB Signals
		--Enable TB Signals
		HIIn_tb,		LOIn_tb, 	PCIn_tb,		IRin_tb,		ZIn_tb,		Yin_tb,
		MARin_tb,	MDRin_tb, 	Conin_tb,	
		--BusMuxSelect TB Signals
		HIOut_tb,	LOOut_tb,	ZHIOut_tb,	ZLOOut_tb, 	PCOut_tb, 	MDROut_tb,	
		PortOut_tb, Cout_tb	: STD_LOGIC;
		SIGNAL InPort_tb,		OutPort_tb : STD_LOGIC_VECTOR(31 downto 0);
		SIGNAL --Outputs for Demonstration
		BusMuxOut_tb, IRout_tb,d_PCOut_tb,
		R00Out_tb,	R01Out_tb,	R02Out_tb,	R03Out_tb,	R04Out_tb,	R05Out_tb,	R06Out_tb,	R07Out_tb,
		R08Out_tb,	R09Out_tb,	R10Out_tb,	R11Out_tb,	R12Out_tb,	R13Out_tb,	R14Out_tb,	R15Out_tb,
		d_HIOut_tb,	d_LOOut_tb,	d_YOut_tb,	d_MDROut_tb,MarOut_tb,	d_ZHiOut_tb,	d_ZLoOut_tb, 	C_sign_extended_tb	: STD_LOGIC_VECTOR(31 DOWNTO 0);
				
BEGIN
	--SIGNAL gnd32 STD_LOGIC_VECTOR(31 downto 0) := x"00000000";
	--DUT inst
	DUT : cpu_codyale
	PORT MAP(
		--CONTROL PORTS
		clk => clk_tb,	clr => clr_tb, IncPC => IncPC_tb,
		MemRead=>MemRd_tb, WriteSig=>WriteSig_tb, strobe=>strobe_tb, Outport_en=>Outport_en_tb,
		
		--REGISTER CONTROL PORTS
		BAout=>BAout_tb,	GRA=>GRA_tb,	GRB=>GRB_tb,	GRC=>GRC_tb,	
		Rin=>Rin_tb,	Rout=>Rout_tb,
		--NON-REGISTER CONTROL PORTS 
		-- Enables
		HIIn => HIIn_tb,
		LOIn  =>LOIn_tb,
		PCIn	=>PCIn_tb,
		IRin	=>IRin_tb,
		ZIn	=>ZIn_tb,
		Yin	=>Yin_tb,
		MARin =>MARin_tb,
		MDRin =>MDRin_tb,
		CONin =>CONin_tb,
		--BusMuxSelects
		HIOut => HIOut_tb,
		LOOut => LOOut_tb,
		ZHiOut=> ZHiOut_tb,
		ZLOOut=> ZLOOut_tb,
		PCOut => PCOut_tb,	
		MDROut=> MDROut_tb,
		PortOut=>PortOut_tb,
		COut	=> Cout_tb,
		InPort=> InPort_tb,
		--END CONTROL PORTS
		--DEMONSTRATION PORTS
		d_R00Out => R00Out_tb,
		d_R01Out => R01Out_tb,
		d_R02Out => R02Out_tb,
		d_R03Out => R03Out_tb,
		d_R04Out => R04Out_tb,
		d_R05Out => R05Out_tb,
		d_R06Out => R06Out_tb,
		d_R07Out => R07Out_tb,
		d_R08Out => R08Out_tb,
		d_R09Out => R09Out_tb,
		d_R10Out => R10Out_tb,
		d_R11Out => R11Out_tb,
		d_R12Out => R12Out_tb,
		d_R13Out => R13Out_tb,
		d_R14Out => R14Out_tb,
		d_R15Out => R15Out_tb,
		d_HIOut => d_HIOut_tb,
		d_LOOut => d_LOOut_tb,
		d_PCOut => d_PCOut_tb,
		d_MDROut => d_MDROut_tb,
		d_BusMuxOut => BusMuxOut_tb,
		d_IROut => IRout_tb,
		d_YOut => d_YOut_tb,
		d_ZHiOut => d_ZHiOut_tb,
		d_ZLoOut => d_ZLoOut_tb,
		d_MARout => MarOut_tb,
		OutPort => OutPort_tb
	);
	--processes
	clk_process : process
	begin
		clk_tb <= '0', '1' after 5 ns;
		Wait for 10 ns;
	end process clk_process;
	
	--Testing process
	test_process : process
		begin
		CurrentOp <= default;
		CurrentStage <= Load;
		clr_tb <='1';	
		IncPC_tb<='0';	MemRd_tb<='0';	WriteSig_tb<='0';	strobe_tb<='0'; 
		GRA_tb<='0';	GRB_tb<='0';	GRC_tb<='0';		
		BAout_tb<='0';	Rin_tb<='0';	Rout_tb<='0';	
		Outport_en_tb<='0';	
		HIin_tb<='0';	LOin_tb<='0'; 	PCin_tb<='0';	IRin_tb<='0';	
		Zin_tb<='0';	Yin_tb<='0';	MARin_tb<='0';	MDRin_tb<='0';	Conin_tb<='0';
		
		HIOut_tb<='0';	LOOut_tb<='0';	ZHIOut_tb<='0';
		ZLOOut_tb<='0'; 	PCOut_tb<='0'; 	MDROut_tb<='0';	
		PortOut_tb<='0'; Cout_tb<='0';
		wait until RISING_EDGE(clk_tb); 
		clr_tb <='0';
		
		--LD Instruction
		-- ld	R1, M[1] (contains 1984 in binary)
		-- Memory Address 0 (00000000100000000000000000000001)
		CurrentOp <= Load;
		CurrentStage <= T0;
		PCOut_tb	<='1';	
		MARin_tb <='1';	
		IncPC_tb <='1';
		Zin_tb	<='1';
		wait until RISING_EDGE(clk_tb); 
		PCOut_tb	<='0';	MARin_tb <='0';	IncPC_tb <='0';	Zin_tb	<='0';
		
		CurrentStage<=T1;
		ZLoOut_tb<='1';
		PCin_tb	<='1';
		MemRd_tb	<='1';
		MDRin_tb	<='1';
		wait until RISING_EDGE(clk_tb); 
		wait until RISING_EDGE(clk_tb); 
		wait until RISING_EDGE(clk_tb); 
		ZLoOut_tb<='0';	PCin_tb	<='0';	MemRd_tb	<='0';	MDRin_tb	<='0';	
		
		CurrentStage <= T2;
		MDROut_tb<= '1';
		IRin_tb	<= '1';
		wait until RISING_EDGE(clk_tb); 
		MDROut_tb<= '0';	IRin_tb	<= '0';
		
		CurrentStage <= T3;
		Grb_tb	<='1';
		BAout_tb <='1';
		Yin_tb	<='1';
		wait until RISING_EDGE(clk_tb); 
		Grb_tb	<='0';	BAout_tb <='0';	Yin_tb<='0';
		
		CurrentStage <= T4;
		Cout_tb 	<='1';
		Zin_tb	<='1';
		wait until RISING_EDGE(clk_tb);
		Cout_tb 	<='0';	Zin_tb	<='0';
		
		CurrentStage <= T5;
		ZLoOut_tb<= '1';
		MARin_tb	<= '1';
		wait until RISING_EDGE(clk_tb);
		ZLoOut_tb<= '0';	MARin_tb	<= '0';
		
		CurrentStage <= T6;
		MemRd_tb <= '1';	
		MDRin_tb <= '1';
		wait until RISING_EDGE(clk_tb); 
		wait until RISING_EDGE(clk_tb); 
		wait until RISING_EDGE(clk_tb); 
		MemRd_tb <= '0';	MDRin_tb <='0';
		
		CurrentStage <= T7;
		MDROut_tb<= '1';
		GRA_tb	<= '1';
		Rin_tb	<= '1';
		wait until RISING_EDGE(clk_tb); 
		MDROut_tb<= '0';	GRA_tb	<= '0';	Rin_tb	<= '0';
		
		
		
		--LD Instruction
		-- ldi	R2, 2017
		-- Memory Address 4 (00000001000000000000111111000001)
		CurrentOp <= LoadI;
		CurrentStage <= T0;
		PCOut_tb	<='1';	
		MARin_tb <='1';	
		IncPC_tb <='1';
		Zin_tb	<='1';
		wait until RISING_EDGE(clk_tb); 
		PCOut_tb	<='0';	MARin_tb <='0';	IncPC_tb <='0';	Zin_tb	<='0';
		
		CurrentStage<=T1;
		ZLoOut_tb<='1';
		PCin_tb	<='1';
		MemRd_tb	<='1';
		MDRin_tb	<='1';
		wait until RISING_EDGE(clk_tb); 
		wait until RISING_EDGE(clk_tb); 
		wait until RISING_EDGE(clk_tb); 
		ZLoOut_tb<='0';	PCin_tb	<='0';	MemRd_tb	<='0';	MDRin_tb	<='0';	
		
		CurrentStage <= T2;
		MDROut_tb<= '1';
		IRin_tb	<= '1';
		wait until RISING_EDGE(clk_tb); 
		MDROut_tb<= '0';	IRin_tb	<= '0';
		
		CurrentStage <= T3;
		GRb_tb	<= '1';
		BAout_tb <= '1';
		Yin_tb	<= '1';
		wait until RISING_EDGE(clk_tb); 
		GRb_tb	<= '0';	BAout_tb <= '0';	Yin_tb	<= '0';
		
		CurrentStage <= T4;
		Cout_tb	<= '1';
		Zin_tb	<= '1';
		wait until RISING_EDGE(clk_tb); 
		Cout_tb	<= '0';	Zin_tb	<= '0';
		
		CurrentStage <= T5;
		ZLoOut_tb<= '1';
		Gra_tb	<= '1';
		Rin_tb	<= '1';
		wait until RISING_EDGE(clk_tb); 
		ZLoOut_tb<= '0';	Gra_tb	<= '0';	Rin_tb	<= '0';
		
		
		wait;
		

	end process test_process;
END;