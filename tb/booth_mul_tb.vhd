LIBRARY ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

ENTITY booth_mul_tb IS
END booth_mul_tb;

ARCHITECTURE arch OF booth_mul_tb IS
	COMPONENT booth_mul
	PORT (Ain :   IN STD_LOGIC_VECTOR(31 downto 0);
		Bin :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		output :  OUT  STD_LOGIC_VECTOR(63 DOWNTO 0)
	);
	END COMPONENT;
	
	signal A_tb, B_tb : STD_LOGIC_VECTOR(31 downto 0);
	signal out_tb : STD_LOGIC_VECTOR(63 downto 0);
--	alias result64 is <<signal .^.booth_mul.result: STD_LOGIC_VECTOR(63 downto 0)>>;
--	signal result_tb : result64;
BEGIN
	DUT : booth_mul PORT MAP (	Ain => A_tb, Bin => B_tb, output => out_tb);

	test: process
	begin 
		A_tb <= x"000000C2";
		B_tb <= x"00000203";
		wait for 10 ns;
		A_tb <= not A_tb;
		wait for 10 ns;
		B_tb <= x"F2F2ABDC";
		wait;
	end process test;
END;