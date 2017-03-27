LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY ctl_unit_tb IS
END ENTITY;

ARCHITECTURE structural OF ctl_unit_tb IS
	COMPONENT ctl_unit  
		PORT(
			clk, reset, stop, con_ff	:	IN STD_LOGIC;
			IR									:	IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			--Indicators
			run, clr,
			--- Register Control Ports
			Rin, Rout, Gra, Grb, Grc,
			
			PCout, MDRout, ZHiOut, ZLoOut, HiOut, LoOut, 
			InportOut,
			
			HiIn, LOIn, CONin, PCin, IRin, Yin, Zin, 
			MARin, MDRin, Outport_en,Cout, BAout,
			
			--ALU Signals
			ADD, SUB, ANDop, ORop, 
			SHR, SHL, ROTR, ROTL,
			MUL, DIV, NEG, NOTop, 
			IncPC, claADD,
			
			--Memory Signals
			ReadSig, WriteSig 	: OUT STD_LOGIC
		);
	END COMPONENT;

	SIGNAL IR_tb								: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL clk_tb, reset_tb, stop_tb, con_ff_tb,
			--Indicators
			run_tb, clr_tb,
			--- Register Control Ports
			Rin_tb, Rout_tb, Gra_tb, Grb_tb, Grc_tb,
			
			PCout_tb, MDRout_tb, ZHiOut_tb, ZLoOut_tb, HiOut_tb, LoOut_tb, 
			InportOut_tb,
			
			HiIn_tb, LOIn_tb, CONin_tb, PCin_tb, IRin_tb, Yin_tb, Zin_tb, 
			MARin_tb, MDRin_tb, Outport_en_tb,Cout_tb, BAout_tb,
			
			--ALU Signals
			ADD_tb, SUB_tb, ANDop_tb, ORop_tb, 
			SHR_tb, SHL_tb, ROTR_tb, ROTL_tb,
			MUL_tb, DIV_tb, NEG_tb, NOTop_tb, 
			IncPC_tb, claADD_tb,
			
			--Memory Signals
			ReadSig_tb, WriteSig_tb 	: STD_LOGIC;
BEGIN
	DUT : ctl_unit
	PORT MAP(
			clk  =>            clk_tb, 
			reset  =>          reset_tb, 
			stop  =>           stop_tb, 
			con_ff  =>         con_ff_tb,
			IR		  =>         IR_tb,
			--Indicators
			run  =>            run_tb, 
			clr  =>            clr_tb,
			--- Register Control Ports
			Rin  =>            Rin_tb, 
			Rout  =>           Rout_tb, 
			Gra  =>            Gra_tb, 
			Grb  =>            Grb_tb, 
			Grc  =>            Grc_tb,
			                   
			PCout  =>          PCout_tb, 
			MDRout  =>         MDRout_tb, 
			ZHiOut  =>         ZHiOut_tb, 
			ZLoOut  =>         ZLoOut_tb, 
			HiOut  =>          HiOut_tb, 
			LoOut  =>          LoOut_tb, 
			InportOut  =>      InportOut_tb,
			                   
			HiIn  =>           HiIn_tb, 
			LOIn  =>           LOIn_tb, 
			CONin  =>          CONin_tb, 
			PCin  =>           PCin_tb, 
			IRin  =>           IRin_tb, 
			Yin  =>            Yin_tb, 
			Zin  =>            Zin_tb, 
			MARin  =>          MARin_tb, 
			MDRin  =>          MDRin_tb, 
			Outport_en  =>     Outport_en_tb,
			Cout  =>           Cout_tb, 
			BAout  =>          BAout_tb,
			                   
			--ALU Signals 
			ADD  =>            ADD_tb, 
			SUB  =>            SUB_tb, 
			ANDop  =>          ANDop_tb, 
			ORop  =>           ORop_tb, 
			SHR  =>            SHR_tb, 
			SHL  =>            SHL_tb, 
			ROTR  =>           ROTR_tb,
			ROTL  =>           ROTL_tb,
			MUL  =>            MUL_tb, 
			DIV  =>            DIV_tb, 
			NEG  =>            NEG_tb, 
			NOTop  =>          NOTop_tb, 
			IncPC  =>          IncPC_tb, 
			claADD  =>         claADD_tb,
			                   
			--Memory Signals   --Mem
			ReadSig  =>        ReadSig_tb, 
			WriteSig  =>       WriteSig_tb 	
	);
	clk_proc :PROCESS
		BEGIN
		clk_tb <= '1';
		wait for 5 ns;
		clk_tb <= '0';
		wait for 5 ns;
	END PROCESS;
	PROCESS
		BEGIN
		wait for 3 ns;
		reset_tb <= '1'; stop_tb <= '1'; con_ff_tb <= '0'; IR_tb <= x"00000000";
		wait until rising_edge(clk_tb);
		reset_tb <= '0';
		wait until rising_edge(clk_tb);
		stop_tb <= '0';
		IR_tb <= x"00800065";
		wait;
		
	END PROCESS;
END;