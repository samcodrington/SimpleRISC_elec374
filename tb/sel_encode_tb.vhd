LIBRARY IEEE;
use ieee.std_logic_1164.all;

ENTITY sel_encode_tb IS
END ENTITY;

ARCHITECTURE behavioural OF sel_encode_tb IS
	COMPONENT sel_encode 
		PORT(
			ir_in 							: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			GRAin, GRBin, GRCin, 
			Rin, Rout, BAout 				: IN STD_LOGIC;
			
			C_sign_extended 				: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			RIN_output, Rout_output 	: OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
		);
	END COMPONENT;
	SIGNAL ir_in_tb						: STD_LOGIC_VECTOR(31 downto 0);
	SIGNAL GRAin_tb, GRBin_tb, GRCin_tb, 
			 Rin_tb, Rout_tb, BAout_tb : STD_LOGIC;
	SIGNAL C_sign_extended_tb 				: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL RIN_output_tb, Rout_output_tb 	: STD_LOGIC_VECTOR(15 DOWNTO 0);
	BEGIN
	DUT : sel_encode
		PORT MAP(ir_in => ir_in_tb,						
			GRAin => GRAin_tb,
			GRBin => GRBin_tb,
			GRCin => GRCin_tb,
			Rin =>   Rin_tb,
			Rout =>  Rout_tb,
			BAout => BAout_tb,		
			C_sign_extended => C_sign_extended_tb,				
			RIN_output => RIN_output_tb,
			Rout_output => Rout_output_tb		
		);
	test_proc : process
		begin
		ir_in_tb <= b"00000_0100_0001_0110_0000000000000000";
		wait for 5 ns;
		Rin_tb <= '1';
		GRAin_tb <= '1'; 
		wait for 5 ns;
		GRAin_tb <= '0'; GRBin_tb<='1';
		wait for 5 ns;
		GRBin_tb <= '0'; GRCin_tb<='1';
		wait for 5 ns;
		ir_in_tb(18 downto 15) <= "1111";
		wait for 5 ns;
		Rin_tb <= '0';
		ir_in_tb <= b"00000_1001_0000_0101_0000000000000000";
		wait for 5 ns;
		Rout_tb <= '1';
		GRAin_tb <= '1'; 
		wait for 5 ns;
		GRAin_tb <= '0'; GRBin_tb<='1';
		wait for 5 ns;
		BAout_tb <= '1';
		wait for 5 ns;
		GRBin_tb <= '0'; GRCin_tb<='1'; BAout_tb<='0';
		wait for 5 ns;
		ir_in_tb(18 downto 15) <= "1111";
		wait for 5 ns;
		Rout_tb <= '0';
	end process;
END;
