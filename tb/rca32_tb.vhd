LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY rca32_tb IS
END rca32_tb;

ARCHITECTURE behaviour OF rca32_tb IS
-- Declaration of Unit Under Test (UUT), 32-bit ripple-carry adder
COMPONENT rca32
PORT(
	A, B 		:	IN		STD_LOGIC_VECTOR(31 downto 0);
	Cin			:	IN		STD_LOGIC;
	Sout		:	OUT	STD_LOGIC_VECTOR(31 downto 0);
	Cout		:	OUT	STD_LOGIC
);
END COMPONENT rca32;

-- Input
signal A		:	STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal B		:	STD_LOGIC_VECTOR(31 downto 0)	:= (others => '0');
signal Cin	:	STD_LOGIC := '0';
-- Output
signal Sout	:	STD_LOGIC_VECTOR(31 downto 0);
signal Cout	:	STD_LOGIC;
-- Clock
signal clk : std_logic;
constant clk_period : time := 10 ns;

BEGIN
-- Instantiation of UUT, 32-bit ripple-carry adder
	UUT : rca32
	PORT MAP (
		A		=> A,
		B		=> B,
		Cin	=> Cin,
		Sout	=>	Sout,
		Cout	=> Cout
	);

	clk_process : PROCESS
	BEGIN
		wait for 100ns;
			A <= "00000000000000000000";
			B <= "00000000000000000000";
			wait for clk_period;
			A <= "00000000000000000001";
			B <= "00000000000000000001";
			wait for clk_period;
			A <= "00000000000000000001";
			B <= "00000000000000000000";
			wait for clk_period;
			A <= "00000000000000000000";
			B <= "00000000000000000001";
			wait for clk_period;
			A <= "00000000000000000001";
			B <= "00000000000000000011";
			wait for clk_period;
			A <= "00000000000000000011";
			B <= "00000000000000000001";
			wait for clk_period;
			A <= "00000000011000000000";
			B <= "00000000000111111111";
			wait for clk_period;
			A <= "01111111111111111111";
			B <= "00000000000000000001";
			wait for clk_period;
			A <= "01111111111111111111";
			B <= "10000000000000000000";
			wait for clk_period;
			A <= "11111111111111111111";
			B <= "00000000000000000001";
			wait for clk_period;
			A <= "11111111111111111111";
			B <= "11111111111111111111";
			wait for clk_period;
				
		WAIT;
	END PROCESS;
END;