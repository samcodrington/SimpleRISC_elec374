LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY alu_tb IS
END;

ARCHITECTURE alu_tb_arch OF alu_tb IS
	SIGNAL Ain_tb, Bin_tb, Zhi_tb, Zlo_tb		: std_logic_vector(31 downto 0);
	SIGNAL opcode_tb										: std_logic_vector(4 downto 0);
	COMPONENT ALU
		PORT
		(
			Ain :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
			Bin :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
			opcode :  IN  STD_LOGIC_VECTOR(4 DOWNTO 0);
			Zout :  OUT  STD_LOGIC_VECTOR(63 DOWNTO 0)
		);
	END COMPONENT;	

BEGIN
	DUT : ALU 
	PORT MAP(
		Ain => Ain_tb,
		Bin => Bin_tb,
		opcode => opcode_tb,
		Zout(63 downto 32) => Zhi_tb,
		Zout(31 downto 0) => Zlo_tb
	);
	test_proc :process
	begin
	opcode_tb <= "00000"; --init
	Ain_tb <= x"00000000";
	Bin_tb <= x"00000000";
	
	wait for 10 ns;
	Ain_tb <= x"000000F3";
	Bin_tb <= x"00000008";
	opcode_tb <= "00110";
	
	wait for 10 ns;
	Ain_tb <= x"00000F31";
	Bin_tb <= x"00002350";
	
	wait for 10 ns;
	opcode_tb <="00101";
	
	wait for 10 ns;
	Ain_tb <= x"FFFFFF00";
	Bin_tb <= x"00FFFFFF";
	opcode_tb <= "00111";
	
	wait for 10 ns;
	opcode_tb <= "01000";
	
	wait for 10 ns;
	opcode_tb <= "10010";
	wait for 10 ns;
	wait;
	end process test_proc;
END;