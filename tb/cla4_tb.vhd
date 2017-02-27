LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY cla4_tb IS
END cla4_tb;

ARCHITECTURE behaviour OF cla4_tb IS
-- Declaration of Unit Under Test (UUT), 4-bit carry lookahead adder

COMPONENT cla4
PORT(
	A, B 						:	IN 	STD_LOGIC_VECTOR(3 downto 0);
	Cin						:	IN 	STD_LOGIC;
	GGout, PGout, Cout	:	OUT STD_LOGIC;
	Sout						:	OUT STD_LOGIC_VECTOR(3 downto 0)
	);
END COMPONENT cla4;

-- Input
signal A		:	STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
signal B		:	STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
signal Cin	:	STD_LOGIC := '0';
-- Output
signal GGout, PGout, Cout	:	STD_LOGIC;
signal Sout	:	STD_LOGIC_VECTOR(3 downto 0);
-- Clock
signal clk : std_logic;
constant clk_period : time := 10 ns;

BEGIN
-- Instantiation of UUT, 4-bit carry lookahead adder
	UUT : cla4
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
			A <= "0000";
			B <= "0000";
			wait for clk_period;
			A <= "0001";
			B <= "0000";
			wait for clk_period;
			A <= "0000";
			B <= "0001";
			wait for clk_period;
			A <= "0001";
			B <= "0001";
			wait for clk_period;
			A <= "1111";
			B <= "0001";
			wait for clk_period;
			A <= "1111";
			B <= "0011";
			wait for clk_period;		
		WAIT;
	END PROCESS;
END;