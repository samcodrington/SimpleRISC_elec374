LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY alu_tb IS
END;

ARCHITECTURE alu_tb_arch OF alu_tb IS
	SIGNAL Ain_tb, Bin_tb, Zhi_tb, Zlo_tb		: std_logic_vector(31 downto 0);
	SIGNAL ADD, SUB, ANDop, ORop, 
			SHR, SHL, ROTR, ROTL,
			MUL, DIV, NEG, NOTop, 
			IncPC, claADD									: std_logic;
	COMPONENT ALU
		PORT
		(
			Ain :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
			Bin :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
			ADD, SUB, ANDop, ORop, 
			SHR, SHL, ROTR, ROTL,
			MUL, DIV, NEG, NOTop, 
			IncPC, claADD	: IN STD_LOGIC;
			Zout :  OUT  STD_LOGIC_VECTOR(63 DOWNTO 0)
		);
	END COMPONENT;	

BEGIN
	DUT : ALU 
	PORT MAP(
		Ain => Ain_tb,
		Bin => Bin_tb,
		ADD => ADD, 
		SUB => SUB, 
		ANDop => ANDop, 
		ORop=> ORop, 
		SHR => SHR, 
		SHL => SHL, 
		ROTR=> ROTR, 
		ROTL=> ROTL,
		MUL => MUL, 
		DIV => DIV, 
		NEG => NEG, 
		NOTop=>NOTop, 
		IncPC=>IncPC, 
		claADD=>claADD,
		Zout(63 downto 32) => Zhi_tb,
		Zout(31 downto 0) => Zlo_tb
	);
	test_proc :process
	begin
	incPC <= '0';
	Ain_tb <= x"00000FF0";
	Bin_tb <= x"00000001";
	wait for 10 ns;
	SHL <= '1';
	wait for 10 ns;
	SHL <= '0';
	wait for 10 ns;
	SHR <= '1';
	wait;
	
	end process test_proc;
END;