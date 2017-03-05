Library ieee;
USE ieee.std_logic_1164.all;

ENTITY cpu_codyale_tb IS
END;

ARCHITECTURE cpu_codyale_tb_arch OF cpu_codyale_tb IS
--SIGNALS & COMPONENTS
		TYPE Operation IS (Default, LoadR2, LoadR3, LoadR4, LoadR5, LoadR6, LoadR7,
		Add, Sub, Mul, Div, AndOp, OrOp, SHR, SHL, RotRight, RotLeft, Neg, NotOp);
		TYPE Stage IS (T0, T1, T2, T3, T4, T5, T6, T7, load);
		SIGNAL CurrentOp : Operation;
		SIGNAL CurrentStage : Stage;
		SIGNAL clk_tb, clr_tb, IncPC_tb, MDRRead_tb : STD_LOGIC;

		SIGNAL RegIn : STD_LOGIC_VECTOR(23 downto 0);--R##In Signals go to R## to store input (write)
		SIGNAL RegOut : STD_LOGIC_VECTOR(23 downto 0);--R##Out signals go to BusMuxEncoder (read)
		SIGNAL MDataIn_tb : STD_LOGIC_VECTOR(31 downto 0);
		SIGNAL --Outputs for Demonstration
		BusMuxOut_tb, PCOut_tb, IRout_tb,
		R00Out_tb,	R01Out_tb,	R02Out_tb,	R03Out_tb,	R04Out_tb,	R05Out_tb,	R06Out_tb,	R07Out_tb,
		R08Out_tb,	R09Out_tb,	R10Out_tb,	R11Out_tb,	R12Out_tb,	R13Out_tb,	R14Out_tb,	R15Out_tb,
		HIOut_tb,	LOOut_tb,	YOut_tb,	MDROut_tb	 	: STD_LOGIC_VECTOR(31 DOWNTO 0);
		SIGNAL ZOut_tb		: STD_LOGIC_VECTOR(63 DOWNTO 0);	
				
COMPONENT cpu_codyale IS
PORT(
		clk, 		
		--CONTROL PORTS
		clr,		IncPC,
		--Input Enables
		R00In,	R01In,	R02In,	R03In,	R04In,	R05In,	R06In,	R07In,	
		R08In,	R09In,	R10In,	R11In,	R12In,	R13In,	R14In,	R15In,
		HIIn,		LOIn, 	PCIn,		IRin,		ZIn,		Yin,
		MARin,	MDRin, 	MDRRead,
		--BusMuxSelects
		R00Out,	R01Out,	R02Out,	R03Out,	R04Out,	R05Out,	R06Out,	R07Out,	
		R08Out,	R09Out,	R10Out,	R11Out,	R12Out,	R13Out,	R14Out,	R15Out,
		HIOut,	LOOut,	ZHIOut,	ZLOOut, 	PCOut, 	MDROut,	PortOut, Cout			: IN STD_LOGIC;
		MDATAin,	PortIn,	Cin	: IN STD_LOGIC_VECTOR(31 DOWNTO 0) := x"00000000";
		--END CTL PORTS
		
		--DEMONSTRATION PORTS
		d_R00Out,	d_R01Out,	d_R02Out,	d_R03Out,	d_R04Out,	d_R05Out,	d_R06Out,	d_R07Out,
		d_R08Out,	d_R09Out,	d_R10Out,	d_R11Out,	d_R12Out,	d_R13Out,	d_R14Out,	d_R15Out,
		d_HIOut,		d_LOOut,		d_PCOut,		d_MDROut,	d_BusMuxOut, d_IROut, d_YOut 	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		d_ZOut																			: OUT STD_LOGIC_VECTOR(63 DOWNTO 0)	
		--END DEMO PORTS
);
END COMPONENT;

BEGIN
	--SIGNAL gnd32 STD_LOGIC_VECTOR(31 downto 0) := x"00000000";
	--DUT inst
	DUT : cpu_codyale
	PORT MAP(
		clk => clk_tb,	clr => clr_tb, IncPC => IncPC_tb,
		--CONTROL PORTS
		R00In => RegIn(0),
		R01In => RegIn(1),
		R02In => RegIn(2),
		R03In => RegIn(3),
		R04In => RegIn(4),
		R05In => RegIn(5),
		R06In => RegIn(6),
		R07In => RegIn(7),	
		R08In => RegIn(8),
		R09In => RegIn(9),
		R10In => RegIn(10),
		R11In => RegIn(11),
		R12In => RegIn(12),
		R13In => RegIn(13),
		R14In => RegIn(14),
		R15In => RegIn(15),
		HIIn => RegIn(16),
		LOIn  => RegIn(17),
		PCIn	=> RegIn(18), 
		IRin	=> RegIn(19), 
		ZIn	=> RegIn(20), 
		Yin	=> RegIn(21), 	
		MARin => RegIn(22),
		MDRin => RegIn(23),
		MDRRead => MDRRead_tb,
		R00Out => RegOut(0), 
		R01Out => RegOut(1),
		R02Out => RegOut(2),
		R03Out => RegOut(3),
		R04Out => RegOut(4),
		R05Out => RegOut(5),
		R06Out => RegOut(6),
		R07Out => RegOut(7),	
		R08Out => RegOut(8),
		R09Out => RegOut(9),
		R10Out => RegOut(10),
		R11Out => RegOut(11),
		R12Out => RegOut(12),
		R13Out => RegOut(13),
		R14Out => RegOut(14),
		R15Out => RegOut(15),
		HIOut => RegOut(16),
		LOOut  => RegOut(17),
		ZHiOut => RegOut(18),
		ZLOOut => RegOut(19),
		PCOut => RegOut(20),	
		MDROut => RegOut(21),
		PortOut => RegOut(22),
		COut=> RegOut(23),
		PortIn => open,
		Cin => open, 
		MDATAin => MDataIn_tb, 				
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
		d_HIOut => HIOut_tb,
		d_LOOut => LOOut_tb,
		d_PCOut => PCOut_tb,
		d_MDROut => MDROut_tb,
		d_BusMuxOut => BusMuxOut_tb,
		d_IROut => IRout_tb,
		d_YOut => YOut_tb,
		d_ZOut => ZOut_tb
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
		--Default Inputs to Zeroes;
		CurrentOp <= Default;
		CurrentStage <= load;
		RegIn <= x"000000";
		RegOut <= x"000000";
		clr_tb <= '1';
		MDRRead_tb <= '0';
		IncPC_tb <= '0';
		MDataIn_tb <= x"00000000";
		------------------------------------------
		wait until RISING_EDGE(clk_tb);
		clr_tb <= '0';
		--Initializes Registers 2,3,4,5,6,7
		CurrentOp <= LoadR2;
		MDRRead_tb <= '1';
		MDatain_tb <= x"0000003C";
		RegIn(23) <= '1';
		
		wait until RISING_EDGE(clk_tb);
		RegOut(21) <= '1';		

		wait until RISING_EDGE(clk_tb);
		RegIn(2) <= '1';
		wait until RISING_EDGE(clk_tb);
		RegIn(2) <= '0';
		------------------------------------------
		CurrentOp <= LoadR3;
		MDatain_tb <= x"00000014";
		
		wait until RISING_EDGE(clk_tb);
		wait until RISING_EDGE(clk_tb);
		RegIn(3) <= '1';
		wait until RISING_EDGE(clk_tb);
		RegIn(3) <= '0';
		------------------------------------------
		CurrentOp <= LoadR4;
		MDatain_tb <= x"FFFFFFF4";
		
		wait until RISING_EDGE(clk_tb);
		wait until RISING_EDGE(clk_tb);
		RegIn(4) <= '1';
		wait until RISING_EDGE(clk_tb);
		RegIn(4) <= '0';		
		------------------------------------------
		CurrentOp <= LoadR5;
		MDatain_tb <= x"FFFFFFD8";
		
		wait until RISING_EDGE(clk_tb);
		wait until RISING_EDGE(clk_tb);
		RegIn(5) <= '1';
		wait until RISING_EDGE(clk_tb);
		RegIn(5) <= '0';
		
		------------------------------------------
		CurrentOp <= LoadR6;
		MDatain_tb <= x"FFFF0303";
		
		wait until RISING_EDGE(clk_tb);
		wait until RISING_EDGE(clk_tb);
		RegIn(6) <= '1';
		wait until RISING_EDGE(clk_tb);
		RegIn(6) <= '0';
		------------------------------------------
		CurrentOp <= LoadR7;
		MDatain_tb <= x"000003C3";
		wait until RISING_EDGE(clk_tb);
		wait until RISING_EDGE(clk_tb);
		RegIn(7) <= '1';
		wait until RISING_EDGE(clk_tb);
		RegIn(7) <= '0'; RegOut(21) <= '0';
		MDataIn_tb <= x"00000000";
		RegIn(23) <= '0';
		------------------------------------------
		-- Add R1, R2, R3
		CurrentOp <= Add;
		--T0 PCout, MARin, IncPC, Zin
		CurrentStage <= T0;
		RegOut(20) 	<= '1'; --PC
		RegIn(22) 	<= '1'; --MARin
		IncPC_tb		<= '1';
		RegIn(20)	<= '1'; -- Zin
		wait until RISING_EDGE(clk_tb);
		RegOut(20) <= '0'; RegIn(22) <= '0';
		IncPC_tb <= '0'; RegIn(20) <= '0';
		------------------------------------------
		--T1 Zlowout, PCin, Read, Mdatain[31..0], MDRin
		CurrentStage <= T1;
		RegOut(19) <= '1'; --ZLo
		RegIn(18)	<= '1'; --PC		
		MDataIn_tb	<= b"0010_1" & b"0001" & b"0010" & b"0011" & b"000" & x"000";
		RegIn(23)	<= '1'; --MDR
		wait until RISING_EDGE(clk_tb);
		RegOut(19) <= '0'; RegIn(18) <= '0'; RegIn(23) <= '0';
		------------------------------------------
		--T2 MDRout, IRin
		CurrentStage <= T2;
		RegOut(21) <= '1';--MDR
		RegIn(19) <= '1'; --IRin
		wait until RISING_EDGE(clk_tb);
		RegOut(21) <= '0';
		RegIn(19) <= '0';
		------------------------------------------
		--T3 R2out, Yin
		CurrentStage <= T3;
		RegOut(2) <= '1'; --R2
		RegIn(21) <= '1'; --Y
		wait until RISING_EDGE(clk_tb);
		RegOut(2) <= '0';
		RegIn(21) <= '0';
		------------------------------------------
		--T4 R3out, ADD, Zin
		CurrentStage <= T4;

		RegOut(3) <= '1'; --R3
		RegIn(20) <= '1'; --Z
		wait until RISING_EDGE(clk_tb);
		RegOut(3) <= '0';
		RegIn(20) <= '0'; 
		
		------------------------------------------
		--T5 Zlowout, R1in
		CurrentStage <= T5;
		RegOut(19) <= '1';
		RegIn(1) <= '1';
		wait until RISING_EDGE(clk_tb);
		RegOut(19) <= '0';
		RegIn(1) <= '0';
		------------------------------------------
		-- Sub, Mul, Div, AndOp, OrOp, SHR, SHL, RotRight, RotLeft, Neg, NotOp 
		
		------------------------------------------
		--sub R0, R4, R5
		CurrentOp <= Sub;
		--T0 PCout, MARin, IncPC, Zin
		CurrentStage <= T0;
		RegOut(20) 	<= '1'; --PC
		RegIn(22) 	<= '1'; --MARin
		IncPC_tb		<= '1';
		RegIn(20)	<= '1'; -- Zin
		wait until RISING_EDGE(clk_tb);
		RegOut(20) <= '0'; RegIn(22) <= '0';
		IncPC_tb <= '0'; RegIn(20) <= '0';
		------------------------------------------
		--T1 Zlowout, PCin, Read, Mdatain[31..0], MDRin
		CurrentStage <= T1;
		RegOut(19) <= '1'; --ZLo
		RegIn(18)	<= '1'; --PC		
		MDataIn_tb	<= b"0011_0" & b"0000" & b"0100" & b"0101" & b"000" & x"000";
		RegIn(23)	<= '1'; --MDR
		wait until RISING_EDGE(clk_tb);
		RegOut(19) <= '0'; RegIn(18) <= '0'; RegIn(23) <= '0';
		------------------------------------------
		--T2 MDRout, IRin
		CurrentStage <= T2;
		RegOut(21) <= '1';--MDR
		RegIn(19) <= '1'; --IRin
		wait until RISING_EDGE(clk_tb);
		RegOut(21) <= '0';
		RegIn(19) <= '0';
		------------------------------------------
		--T3 R4out, Yin
		CurrentStage <= T3;
		RegOut(4) <= '1'; --R4
		RegIn(21) <= '1'; --Y
		wait until RISING_EDGE(clk_tb);
		RegOut(4) <= '0';
		RegIn(21) <= '0';
		------------------------------------------
		--T4 R5out, SUB, Zin
		CurrentStage <= T4;

		RegOut(5) <= '1'; --R5
		RegIn(20) <= '1'; --Z
		wait until RISING_EDGE(clk_tb);
		RegOut(5) <= '0';
		RegIn(20) <= '0'; 
		
		------------------------------------------
		--T5 Zlowout, R1in
		CurrentStage <= T5;
		RegOut(19) <= '1'; --ZLo
		RegIn(0) <= '1'; --R0
		wait until RISING_EDGE(clk_tb);
		RegOut(19) <= '0';
		RegIn(0) <= '0';
		------------------------------------------
		--mul R5, R7
		CurrentOp <= Mul;
		--T0 PCout, MARin, IncPC, Zin
		CurrentStage <= T0;
		RegOut(20) 	<= '1'; --PC
		RegIn(22) 	<= '1'; --MARin
		IncPC_tb		<= '1';
		RegIn(20)	<= '1'; -- Zin
		wait until RISING_EDGE(clk_tb);
		RegOut(20) <= '0'; RegIn(22) <= '0';
		IncPC_tb <= '0'; RegIn(20) <= '0';
		------------------------------------------
		--T1 Zlowout, PCin, Read, Mdatain[31..0], MDRin
		CurrentStage <= T1;
		RegOut(19) <= '1'; --ZLo
		RegIn(18)	<= '1'; --PC		
		MDataIn_tb	<= b"1000_0" & b"0101" & b"0111" & b"000" & x"0000";
		RegIn(23)	<= '1'; --MDR
		wait until RISING_EDGE(clk_tb);
		RegOut(19) <= '0'; RegIn(18) <= '0'; RegIn(23) <= '0';
		------------------------------------------
		--T2 MDRout, IRin
		CurrentStage <= T2;
		RegOut(21) <= '1';--MDR
		RegIn(19) <= '1'; --IRin
		wait until RISING_EDGE(clk_tb);
		RegOut(21) <= '0';
		RegIn(19) <= '0';
		------------------------------------------
		--T3 R5out, Yin
		CurrentStage <= T3;
		RegOut(5) <= '1'; --R5
		RegIn(21) <= '1'; --Y
		wait until RISING_EDGE(clk_tb);
		RegOut(5) <= '0';
		RegIn(21) <= '0';
		------------------------------------------
		--T4 R7out, MUL, Zin
		CurrentStage <= T4;

		RegOut(7) <= '1'; --R7
		RegIn(20) <= '1'; --Z
		wait until RISING_EDGE(clk_tb);
		RegOut(7) <= '0';
		RegIn(20) <= '0'; 
		
		------------------------------------------
		--T5 Zlowout, LOin
		CurrentStage <= T5;
		RegOut(19) <= '1'; --ZLO
		RegIn(17) <= '1'; --LO
		wait until RISING_EDGE(clk_tb);
		RegOut(19) <= '0';
		RegIn(17) <= '0';
		------------------------------------------
		--T6 ZHIout, HIin
		CurrentStage <= T6;
		RegOut(18) <= '1'; 
		RegIn(16) <= '1';
		wait until RISING_EDGE(clk_tb);
		RegOut(18) <= '0';
		RegIn(16) <= '0';
		------------------------------------------
		--div R1, R3
		CurrentOp <= Div;
		--T0 PCout, MARin, IncPC, Zin
		CurrentStage <= T0;
		RegOut(20) 	<= '1'; --PC
		RegIn(22) 	<= '1'; --MARin
		IncPC_tb		<= '1';
		RegIn(20)	<= '1'; -- Zin
		wait until RISING_EDGE(clk_tb);
		RegOut(20) <= '0'; RegIn(22) <= '0';
		IncPC_tb <= '0'; RegIn(20) <= '0';
		------------------------------------------
		--T1 Zlowout, PCin, Read, Mdatain[31..0], MDRin
		CurrentStage <= T1;
		RegOut(19) <= '1'; --ZLo
		RegIn(18)	<= '1'; --PC		
		MDataIn_tb	<= b"1000_1" & b"0011" & b"0001" & b"000" & x"0000";
		RegIn(23)	<= '1'; --MDR
		wait until RISING_EDGE(clk_tb);
		RegOut(19) <= '0'; RegIn(18) <= '0'; RegIn(23) <= '0';
		------------------------------------------
		--T2 MDRout, IRin
		CurrentStage <= T2;
		RegOut(21) <= '1';--MDR
		RegIn(19) <= '1'; --IRin
		wait until RISING_EDGE(clk_tb);
		RegOut(21) <= '0';
		RegIn(19) <= '0';
		------------------------------------------
		--T3 R1out, Yin
		CurrentStage <= T3;
		RegOut(1) <= '1'; --R1
		RegIn(21) <= '1'; --Y
		wait until RISING_EDGE(clk_tb);
		RegOut(1) <= '0';
		RegIn(21) <= '0';
		------------------------------------------
		--T4 R3out, MUL, Zin
		CurrentStage <= T4;

		RegOut(3) <= '1'; --R3
		RegIn(20) <= '1'; --Z
		wait until RISING_EDGE(clk_tb);
		RegOut(3) <= '0';
		RegIn(20) <= '0'; 
		
		------------------------------------------
		--T5 Zlowout, LOin
		CurrentStage <= T5;
		RegOut(19) <= '1'; --ZLO
		RegIn(17) <= '1'; --LO
		wait until RISING_EDGE(clk_tb);
		RegOut(19) <= '0';
		RegIn(17) <= '0';
		------------------------------------------
		--T6 ZHIout, HIin
		CurrentStage <= T6;
		RegOut(18) <= '1'; 
		RegIn(16) <= '1';
		wait until RISING_EDGE(clk_tb);
		RegOut(18) <= '0';
		RegIn(16) <= '0';
		------------------------------------------
		--and  R0, R1, R7
		CurrentOp <= AndOp;
		--T0 PCout, MARin, IncPC, Zin
		CurrentStage <= T0;
		RegOut(20) 	<= '1'; --PC
		RegIn(22) 	<= '1'; --MARin
		IncPC_tb		<= '1';
		RegIn(20)	<= '1'; -- Zin
		wait until RISING_EDGE(clk_tb);
		RegOut(20) <= '0'; RegIn(22) <= '0';
		IncPC_tb <= '0'; RegIn(20) <= '0';
		------------------------------------------
		--T1 Zlowout, PCin, Read, Mdatain[31..0], MDRin
		CurrentStage <= T1;
		RegOut(19) <= '1'; --ZLo
		RegIn(18)	<= '1'; --PC		
		MDataIn_tb	<= b"0011_1" & b"0000" & b"0001" & b"0111" & b"000" & x"000";
		RegIn(23)	<= '1'; --MDR
		wait until RISING_EDGE(clk_tb);
		RegOut(19) <= '0'; RegIn(18) <= '0'; RegIn(23) <= '0';
		------------------------------------------
		--T2 MDRout, IRin
		CurrentStage <= T2;
		RegOut(21) <= '1';--MDR
		RegIn(19) <= '1'; --IRin
		wait until RISING_EDGE(clk_tb);
		RegOut(21) <= '0';
		RegIn(19) <= '0';
		------------------------------------------
		--T3 R1out, Yin
		CurrentStage <= T3;
		RegOut(1) <= '1'; --R1
		RegIn(21) <= '1'; --Y
		wait until RISING_EDGE(clk_tb);
		RegOut(1) <= '0';
		RegIn(21) <= '0';
		------------------------------------------
		--T4 R7out, AND, Zin
		CurrentStage <= T4;
--
		RegOut(7) <= '1'; --R7
		RegIn(20) <= '1'; --Z
		wait until RISING_EDGE(clk_tb);
		RegOut(7) <= '0';
		RegIn(20) <= '0'; 
		
		------------------------------------------
		--T5 Zlowout, R2in
		CurrentStage <= T5;
		RegOut(19) <= '1';
		RegIn(0) <= '1';
		wait until RISING_EDGE(clk_tb);
		RegOut(19) <= '0';
		RegIn(0) <= '0';
		------------------------------------------
		--or R0, R1, R7
		CurrentOp <= OrOp;
		--T0 PCout, MARin, IncPC, Zin
		CurrentStage <= T0;
		RegOut(20) 	<= '1'; --PC
		RegIn(22) 	<= '1'; --MARin
		IncPC_tb		<= '1';
		RegIn(20)	<= '1'; -- Zin
		wait until RISING_EDGE(clk_tb);
		RegOut(20) <= '0'; RegIn(22) <= '0';
		IncPC_tb <= '0'; RegIn(20) <= '0';
		------------------------------------------
		--T1 Zlowout, PCin, Read, Mdatain[31..0], MDRin
		CurrentStage <= T1;
		RegOut(19) <= '1'; --ZLo
		RegIn(18)	<= '1'; --PC		
		MDataIn_tb	<= b"0100_0" & b"0000" & b"0001" & b"0111" & b"000" & x"000";
		RegIn(23)	<= '1'; --MDR
		wait until RISING_EDGE(clk_tb);
		RegOut(19) <= '0'; RegIn(18) <= '0'; RegIn(23) <= '0';
		------------------------------------------
		--T2 MDRout, IRin
		CurrentStage <= T2;
		RegOut(21) <= '1';--MDR
		RegIn(19) <= '1'; --IRin
		wait until RISING_EDGE(clk_tb);
		RegOut(21) <= '0';
		RegIn(19) <= '0';
		------------------------------------------
		--T3 R1out, Yin
		CurrentStage <= T3;
		RegOut(1) <= '1'; --R1
		RegIn(21) <= '1'; --Y
		wait until RISING_EDGE(clk_tb);
		RegOut(1) <= '0';
		RegIn(21) <= '0';
		------------------------------------------
		--T4 R7out, AND, Zin
		CurrentStage <= T4;
--
		RegOut(7) <= '1'; --R7
		RegIn(20) <= '1'; --Z
		wait until RISING_EDGE(clk_tb);
		RegOut(7) <= '0';
		RegIn(20) <= '0'; 
		
		------------------------------------------
		--T5 Zlowout, R2in
		CurrentStage <= T5;
		RegOut(19) <= '1';
		RegIn(0) <= '1';
		wait until RISING_EDGE(clk_tb);
		RegOut(19) <= '0';
		RegIn(0) <= '0';
		------------------------------------------
		--shr R2, R1, R3
		CurrentOp <= SHR;
		--T0 PCout, MARin, IncPC, Zin
		CurrentStage <= T0;
		RegOut(20) 	<= '1'; --PC
		RegIn(22) 	<= '1'; --MARin
		IncPC_tb		<= '1';
		RegIn(20)	<= '1'; -- Zin
		wait until RISING_EDGE(clk_tb);
		RegOut(20) <= '0'; RegIn(22) <= '0';
		IncPC_tb <= '0'; RegIn(20) <= '0';
		------------------------------------------
		--T1 Zlowout, PCin, Read, Mdatain[31..0], MDRin
		CurrentStage <= T1;
		RegOut(19) <= '1'; --ZLo
		RegIn(18)	<= '1'; --PC		
		MDataIn_tb	<= b"0100_1" & b"0000" & b"0001" & b"0011" & b"000" & x"000";
		RegIn(23)	<= '1'; --MDR
		wait until RISING_EDGE(clk_tb);
		RegOut(19) <= '0'; RegIn(18) <= '0'; RegIn(23) <= '0';
		------------------------------------------
		--T2 MDRout, IRin
		CurrentStage <= T2;
		RegOut(21) <= '1';--MDR
		RegIn(19) <= '1'; --IRin
		wait until RISING_EDGE(clk_tb);
		RegOut(21) <= '0';
		RegIn(19) <= '0';
		------------------------------------------
		--T3 R1out, Yin
		CurrentStage <= T3;
		RegOut(1) <= '1'; --R1
		RegIn(21) <= '1'; --Y
		wait until RISING_EDGE(clk_tb);
		RegOut(1) <= '0';
		RegIn(21) <= '0';
		------------------------------------------
		--T4 R3, SHR, Zin
			-- Modified statement from T4 SHR, Zin -> R3, SHR, Zin
		CurrentStage <= T4;
		RegOut(3) <= '1'; --R3
		RegIn(20) <= '1'; --Z
		wait until RISING_EDGE(clk_tb);
		RegOut(3) <= '0';
		RegIn(20) <= '0'; 
		------------------------------------------
		--T5 Zlowout, R2in
		CurrentStage <= T5;
		RegOut(19) <= '1';
		RegIn(2) <= '1';
		wait until RISING_EDGE(clk_tb);
		RegOut(19) <= '0';
		RegIn(2) <= '0';
		------------------------------------------
		
		--shl R3, R0, R5
		CurrentOp <= SHL;
		--T0 PCout, MARin, IncPC, Zin
		CurrentStage <= T0;
		RegOut(20) 	<= '1'; --PC
		RegIn(22) 	<= '1'; --MARin
		IncPC_tb		<= '1';
		RegIn(20)	<= '1'; -- Zin
		wait until RISING_EDGE(clk_tb);
		RegOut(20) <= '0'; RegIn(22) <= '0';
		IncPC_tb <= '0'; RegIn(20) <= '0';
		------------------------------------------
		--T1 Zlowout, PCin, Read, Mdatain[31..0], MDRin
		CurrentStage <= T1;
		RegOut(19) <= '1'; --ZLo
		RegIn(18)	<= '1'; --PC		
		MDataIn_tb	<= b"0101_0" & b"0011" & b"0000" & b"0101" & b"000" & x"000";
		RegIn(23)	<= '1'; --MDR
		wait until RISING_EDGE(clk_tb);
		RegOut(19) <= '0'; RegIn(18) <= '0'; RegIn(23) <= '0';
		------------------------------------------
		--T2 MDRout, IRin
		CurrentStage <= T2;
		RegOut(21) <= '1';--MDR
		RegIn(19) <= '1'; --IRin
		wait until RISING_EDGE(clk_tb);
		RegOut(21) <= '0';
		RegIn(19) <= '0';
		------------------------------------------
		--T3 R0out, Yin
		CurrentStage <= T3;
		RegOut(0) <= '1'; --R0
		RegIn(21) <= '1'; --Y
		wait until RISING_EDGE(clk_tb);
		RegOut(0) <= '0';
		RegIn(21) <= '0';
		------------------------------------------
		--T4 R5, SHL, Zin
			-- Modified statement from T4 SHL, Zin -> R5, SHL, Zin
		CurrentStage <= T4;
		RegOut(5) <= '1'; --R5
		RegIn(20) <= '1'; --Z
		wait until RISING_EDGE(clk_tb);
		RegOut(5) <= '0';
		RegIn(20) <= '0'; 
		------------------------------------------
		--T5 Zlowout, R3in
		CurrentStage <= T5;
		RegOut(19) <= '1';
		RegIn(3) <= '1';
		wait until RISING_EDGE(clk_tb);
		RegOut(19) <= '0';
		RegIn(3) <= '0';
		------------------------------------------
		
		--ror R1, R1, R2
		CurrentOp <= RotRight;
		--T0 PCout, MARin, IncPC, Zin
		CurrentStage <= T0;
		RegOut(20) 	<= '1'; --PC
		RegIn(22) 	<= '1'; --MARin
		IncPC_tb		<= '1';
		RegIn(20)	<= '1'; -- Zin
		wait until RISING_EDGE(clk_tb);
		RegOut(20) <= '0'; RegIn(22) <= '0';
		IncPC_tb <= '0'; RegIn(20) <= '0';
		------------------------------------------
		--T1 Zlowout, PCin, Read, Mdatain[31..0], MDRin
		CurrentStage <= T1;
		RegOut(19) <= '1'; --ZLo
		RegIn(18)	<= '1'; --PC		
		MDataIn_tb	<= b"0101_1" & b"0001" & b"0001" & b"0010" & b"000" & x"000";
		RegIn(23)	<= '1'; --MDR
		wait until RISING_EDGE(clk_tb);
		RegOut(19) <= '0'; RegIn(18) <= '0'; RegIn(23) <= '0';
		------------------------------------------
		--T2 MDRout, IRin
		CurrentStage <= T2;
		RegOut(21) <= '1';--MDR
		RegIn(19) <= '1'; --IRin
		wait until RISING_EDGE(clk_tb);
		RegOut(21) <= '0';
		RegIn(19) <= '0';
		------------------------------------------
		--T3 R1out, Yin
		CurrentStage <= T3;
		RegOut(1) <= '1'; --R1
		RegIn(21) <= '1'; --Y
		wait until RISING_EDGE(clk_tb);
		RegOut(1) <= '0';
		RegIn(21) <= '0';
		------------------------------------------
		--T4 R2, ROR, Zin
			-- Modified statement from T4 ROR, Zin -> R2, ROR, Zin
		CurrentStage <= T4;
		RegOut(2) <= '1'; --R2
		RegIn(20) <= '1'; --Z
		wait until RISING_EDGE(clk_tb);
		RegOut(2) <= '0';
		RegIn(20) <= '0'; 
		------------------------------------------
		--T5 Zlowout, R1in
		CurrentStage <= T5;
		RegOut(19) <= '1';
		RegIn(1) <= '1';
		wait until RISING_EDGE(clk_tb);
		RegOut(19) <= '0';
		RegIn(1) <= '0';
		------------------------------------------
		
		--rol R0, R0, R4
		CurrentOp <= RotLeft;
		--T0 PCout, MARin, IncPC, Zin
		CurrentStage <= T0;
		RegOut(20) 	<= '1'; --PC
		RegIn(22) 	<= '1'; --MARin
		IncPC_tb		<= '1';
		RegIn(20)	<= '1'; -- Zin
		wait until RISING_EDGE(clk_tb);
		RegOut(20) <= '0'; RegIn(22) <= '0';
		IncPC_tb <= '0'; RegIn(20) <= '0';
		------------------------------------------
		--T1 Zlowout, PCin, Read, Mdatain[31..0], MDRin
		CurrentStage <= T1;
		RegOut(19) <= '1'; --ZLo
		RegIn(18)	<= '1'; --PC		
		MDataIn_tb	<= b"0110_0" & b"0001" & b"0001" & b"0010" & b"000" & x"000";
		RegIn(23)	<= '1'; --MDR
		wait until RISING_EDGE(clk_tb);
		RegOut(19) <= '0'; RegIn(18) <= '0'; RegIn(23) <= '0';
		------------------------------------------
		--T2 MDRout, IRin
		CurrentStage <= T2;
		RegOut(21) <= '1';--MDR
		RegIn(19) <= '1'; --IRin
		wait until RISING_EDGE(clk_tb);
		RegOut(21) <= '0';
		RegIn(19) <= '0';
		------------------------------------------
		--T3 R0out, Yin
		CurrentStage <= T3;
		RegOut(0) <= '1'; --R0
		RegIn(21) <= '1'; --Y
		wait until RISING_EDGE(clk_tb);
		RegOut(0) <= '0';
		RegIn(21) <= '0';
		------------------------------------------
		--T4 R4, ROL, Zin
			-- Modified statement from T4 ROL, Zin -> R4, ROR, Zin
		CurrentStage <= T4;
		RegOut(4) <= '1'; --R4
		RegIn(20) <= '1'; --Z
		wait until RISING_EDGE(clk_tb);
		RegOut(4) <= '0';
		RegIn(20) <= '0'; 
		------------------------------------------
		--T5 Zlowout, R0in
		CurrentStage <= T5;
		RegOut(19) <= '1';
		RegIn(0) <= '1';
		wait until RISING_EDGE(clk_tb);
		RegOut(19) <= '0';
		RegIn(0) <= '0';
		-----------------------------------------
		
		--neg R1, R2
		
		--not R1, R2
		
		--**CLA Adder**
		
		--??Booth with Bit Pair??
		
		--demonstrate asynchronous clear
		wait until RISING_EDGE(clk_tb);
		
		wait;
	
	end process test_process;
END;