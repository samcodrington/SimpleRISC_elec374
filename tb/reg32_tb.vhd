LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY reg32_tb IS
END;


ARCHITECTURE reg32_tb_arch OF reg32_tb IS
	--SIGNALS
	SIGNAL input_tb, output_tb 			: std_logic_vector (31 downto 0);
	SIGNAL clr_tb, clk_tb, reg_in_tb 	: std_logic:= '0';
	
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
	DUT1 : reg32
	PORT MAP (
		input => input_tb,
		clr 	=> clr_tb,
		clk	=> clk_tb,
		reg_in=>	reg_in_tb,
		output=> output_tb
	);
	-- TEST LOGIC	
	clk_process: process
	begin
		wait for 5 ns;
		clk_tb <= not clk_tb after 5 ns;		
	end process clk_process;
	sim_process: process
	begin
		wait for 5 ns;
		input_tb 	<= x"0000_0000";
		reg_in_tb	<='1';
		wait for 10 ns;
		reg_in_tb	<='0';
		wait for 10 ns;
		input_tb		<=x"FFFF_FFFF";
		wait for 10 ns;
		reg_in_tb	<='1';
		wait for 10 ns;
		clr_tb		<='1';
		wait for 10 ns;
		clr_tb		<='0';
	end process sim_process;
end;