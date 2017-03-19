LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY con_ff_tb IS
END ENTITY;

ARCHITECTURE tb of con_ff_tb IS
	COMPONENT con_ff 
	PORT(
		busin	: IN STD_LOGIC_VECTOR(31 downto 0);
		IRin	: IN STD_LOGIC_VECTOR(1 downto 0);
		CONin : IN STD_LOGIC;
		Q		: OUT STD_LOGIC
	);
	END COMPONENT;
	SIGNAL busin : STD_LOGIC_VECTOR(31 downto 0);
	SIGNAL IRin : STD_LOGIC_VECTOR(1 downto 0);
	SIGNAL CONin, Q : STD_LOGIC;
	BEGIN
	
	DUT: con_ff	PORT MAP(busin => busin, IRin=> IRin, CONin=>CONin, Q=> Q);
	test_proc: PROCESS
		BEGIN
		busin <=x"FFFF0000";
		IRin <= "00";
		wait for 5 ns;
		IRin <= "01";
		wait for 5 ns;
		CONin <='1';
		wait for 5 ns;
		IRin <= "00";
		wait for 5 ns;
		busin <=x"00000000";
		wait for 5 ns;
		IRin <= "10";
		wait for 5 ns;
		busin <=x"00000010";
		wait for 5 ns;
		busin <=x"11111110";
		wait for 5 ns;
		IRin <="11";
		wait for 5 ns;
		busin <=x"00000010";
		wait for 5 ns;
		busin <=x"11111110";
		wait;
	END PROCESS;
		
	
	
	
END;