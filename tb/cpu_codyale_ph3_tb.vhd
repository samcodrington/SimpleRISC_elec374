LIBRARY IEEE;
USE ieee.std_logic_1164.all;

ENTITY cpu_codyale_ph3_tb IS
END ENTITY;

ARCHITECTURE behavioural OF cpu_codyale_ph3_tb IS 

SIGNAL clk_tb, reset_tb, stop_tb, Strobe_tb, d_Run_tb : std_logic;
SIGNAL Inport_tb, OutPort_tb, 	d_R00Out_tb,	d_R01Out_tb,	d_R02Out_tb,	d_R03Out_tb,	d_R04Out_tb,	d_R05Out_tb,	d_R06Out_tb,	d_R07Out_tb,
		d_R08Out_tb,	d_R09Out_tb,	d_R10Out_tb,	d_R11Out_tb,	d_R12Out_tb,	d_R13Out_tb,	d_R14Out_tb,	d_R15Out_tb,
		d_HIOut_tb,		d_LOOut_tb,		d_PCOut_tb,		d_MDROut_tb,	d_BusMuxOut_tb, d_IROut_tb, 	d_YOut_tb,		d_C_sign_extended_tb,
		d_ZLoOut_tb, 	d_ZHiOut_tb,	d_MARout_tb		: std_logic_vector(31 downto 0); 
		
COMPONENT cpu_codyale
	PORT(
		--CONTROL PORTS
			clk,	reset, stop, Strobe : IN STD_LOGIC;
			InPort	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		--END CTL PORTS
		
		--DEMONSTRATION PORTS
			d_Run		: OUT STD_LOGIC;
			d_R00Out,	d_R01Out,	d_R02Out,	d_R03Out,	d_R04Out,	d_R05Out,	d_R06Out,	d_R07Out,
			d_R08Out,	d_R09Out,	d_R10Out,	d_R11Out,	d_R12Out,	d_R13Out,	d_R14Out,	d_R15Out,
			d_HIOut,		d_LOOut,		d_PCOut,		d_MDROut,	d_BusMuxOut, d_IROut, 	d_YOut,		d_C_sign_extended,
			d_ZLoOut, 	d_ZHiOut,	d_MARout,
			OutPort		: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
		--END DEMO PORTS
	);
END COMPONENT;

BEGIN
	DUT : cpu_codyale
	PORT MAP (
		clk=>clk_tb,	
		reset=>reset_tb, 
		stop=>stop_tb, 
		Strobe=>Strobe_tb,
		InPort=>InPort_tb,
		--END CTL PORTS
		
		--DEMONSTRATION PORTS
		d_Run=>d_Run_tb,
		d_R00Out=>d_R00Out_tb,	d_R01Out=>d_R01Out_tb,	d_R02Out=>d_R02Out_tb,	d_R03Out=>d_R03Out_tb,
		d_R04Out=>d_R04Out_tb,	d_R05Out=>d_R05Out_tb,	d_R06Out=>d_R06Out_tb,	d_R07Out=>d_R07Out_tb,
		d_R08Out=>d_R08Out_tb,	d_R09Out=>d_R09Out_tb,	d_R10Out=>d_R10Out_tb,	d_R11Out=>d_R11Out_tb,
		d_R12Out=>d_R12Out_tb,	d_R13Out=>d_R13Out_tb,	d_R14Out=>d_R14Out_tb,	d_R15Out=>d_R15Out_tb,
		d_HIOut=>d_HIOut_tb,	d_LOOut=>d_LOOut_tb,		d_PCOut=>d_PCOut_tb,		d_MDROut=>d_MDROut_tb,
		d_BusMuxOut=>d_BusMuxOut_tb, 						d_IROut=>d_IROut_tb, 	d_YOut=>d_YOut_tb,		
		d_C_sign_extended=>d_C_sign_extended_tb,		d_ZLoOut=>d_ZLoOut_tb, 	d_ZHiOut=>d_ZHiOut_tb,	d_MARout=>d_MARout_tb
	);
	clk_process :PROCESS
	BEGIN
		clk_tb <= '0','1' after 5 ns;
		wait for 10 ns;
	END PROCESS;
	
	tb : PROCESS
	BEGIN
		reset_tb <= '1'; stop_tb <='1';
		wait until rising_edge(clk_tb);
		reset_tb <= '0';
		wait;
	END PROCESS;
END;