LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY MDR_tb IS
END;

ARCHITECTURE MDR_tb_arch OF MDR_tb IS
	--SIGNALS
	SIGNAL clk_tb								: std_logic:= '1';
	SIGNAL BMOut_tb, MDIn_tb,output_tb	: std_logic_vector (31 downto 0);
	SIGNAL  clr_tb, mdr_in_tb				: std_logic:= '0';
	SIGNAL MDRread_tb							: std_logic;
	--COMPONENTS
	COMPONENT MDR
		PORT(
			busMuxOut, MDataIn			:	IN std_logic_vector(31 downto 0);
			clr,clk,mdr_in,MDRread		:	IN std_logic;
			output							:	OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT MDR;
	
BEGIN
	--INSTANTIATION OF COMPONENTS
	DUT1 : MDR
	PORT MAP (
		busMuxOut 	=> BMOut_tb,
		MDataIn 		=> MDIn_tb,
		clr 			=> clr_tb,
		clk			=> clk_tb,
		mdr_in 		=> mdr_in_tb,
		MDRread 		=> MDRread_tb, 
		output		=> output_tb
	);
	--TEST LOGIC
	clk : process
	begin
		wait for 5 ns;
		clk_tb <= not clk_tb after 5 ns;
	end process clk;
	
	testProc : process
	begin
		wait for 5 ns;
		MDRread_tb <= '0';
		BMOut_tb <= x"F0F0_F0F0";
		MDIn_tb <= x"FFFF_0000";
		wait for 10 ns;
		MDR_in_tb <= '1';
		wait for 10 ns;
		MDRread_tb <= '1';
		wait for 10 ns;
		MDR_in_tb <='0';
		wait for 10 ns;
		MDIn_tb <= x"0000_FFFF";
		wait for 22 ns;
		clr_tb <='1';
		wait;
	end process testProc;
end;
		