LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY cla16_tb IS
END cla16_tb;

ARCHITECTURE behaviour OF cla16_tb IS
-- Declaration of Unit Under Test (UUT), 4-bit carry lookahead adder

COMPONENT cla16
PORT(
	A, B 						:	IN 	STD_LOGIC_VECTOR(15 downto 0);
	Cin						:	IN 	STD_LOGIC;
	GGout, PGout, Cout	:	OUT	STD_LOGIC;
	Sout						:	OUT	STD_LOGIC_VECTOR(15 downto 0)
	);
END COMPONENT cla16;

-- Input
signal A		:	STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
signal B		:	STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
signal Cin	:	STD_LOGIC := '0';
-- Output
signal GGout, PGout, Cout	:	STD_LOGIC;
signal Sout	:	STD_LOGIC_VECTOR(15 downto 0);
-- Clock
signal clk : std_logic;
constant clk_period : time := 10 ns;

BEGIN
-- Instantiation of UUT, 4-bit carry lookahead adder
	UUT : cla16
	PORT MAP (
		A		=> A,
		B		=> B,
		Cin	=> Cin,
		GGout	=> GGout,
		PGout	=> PGout,
		Cout	=> Cout,
		Sout	=>	Sout
	);

	clk_process : PROCESS
	BEGIN
		wait for 100ns;
			A <= "0000000000000000";
			B <= "0000000000000000";
			wait for clk_period;
			A <= "0000000000000001";
			B <= "0000000000000000";
			wait for clk_period;
			A <= "0000000000000000";
			B <= "0000000000000001";
			wait for clk_period;
			A <= "0000000000010000";
			B <= "0000000000000000";
			wait for clk_period;
			A <= "0000000000010000";
			B <= "0000000000000001";
			wait for clk_period;
			A <= "0001000100010001";
			B <= "0001000100010001";
			wait for clk_period;
			A <= "0000000000001111";
			B <= "0000000000000001";
			wait for clk_period;
			A <= "1111111111111111";
			B <= "0000000000000001";
			wait for clk_period;
			A <= "1111111111111111";
			B <= "1111111111111111";
			wait for clk_period;
		WAIT;
	END PROCESS;
END;