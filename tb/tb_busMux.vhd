LIBRARY ieee;
--USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE ieee.std_logic_1164.all;

ENTITY tb_busMux IS
END tb_busMux;

ARCHITECTURE behaviour of tb_busMux IS

	COMPONENT busMux
	PORT(
	r00_in, r01_in, r02_in, r03_in,
	r04_in, r05_in, r06_in, r07_in, 
	r08_in, r09_in, r10_in, r11_in, 
	r12_in, r13_in, r14_in, r15_in, 
	hi_in, lo_in, z_hi_in, z_lo_in,
	PC_in, MDR_in, port_in, c_sign_extended	:	IN std_logic_vector(31 downto 0);
	s_in		:	IN std_logic_vector(4 downto 0);
	output	:	OUT std_logic_vector(31 downto 0)
	);
	END COMPONENT;
	
	-- Input
	signal r00_in : std_logic_vector(31 downto 0) := std_logic_vector(to_unsigned(0, 32));
	signal r01_in : std_logic_vector(31 downto 0) := std_logic_vector(to_unsigned(1, 32));
	signal r02_in : std_logic_vector(31 downto 0) := std_logic_vector(to_unsigned(2, 32));
	signal r03_in : std_logic_vector(31 downto 0) := std_logic_vector(to_unsigned(3, 32));
	signal r04_in : std_logic_vector(31 downto 0) := std_logic_vector(to_unsigned(4, 32));
	signal r05_in : std_logic_vector(31 downto 0) := std_logic_vector(to_unsigned(5, 32));
	signal r06_in : std_logic_vector(31 downto 0) := std_logic_vector(to_unsigned(6, 32));
	signal r07_in : std_logic_vector(31 downto 0) := std_logic_vector(to_unsigned(7, 32));
	signal r08_in : std_logic_vector(31 downto 0) := std_logic_vector(to_unsigned(8, 32));
	signal r09_in : std_logic_vector(31 downto 0) := std_logic_vector(to_unsigned(9, 32));
	signal r10_in : std_logic_vector(31 downto 0) := std_logic_vector(to_unsigned(10, 32));
	signal r11_in : std_logic_vector(31 downto 0) := std_logic_vector(to_unsigned(11, 32));
	signal r12_in : std_logic_vector(31 downto 0) := std_logic_vector(to_unsigned(12, 32));
	signal r13_in : std_logic_vector(31 downto 0) := std_logic_vector(to_unsigned(13, 32));
	signal r14_in : std_logic_vector(31 downto 0) := std_logic_vector(to_unsigned(14, 32));
	signal r15_in : std_logic_vector(31 downto 0) := std_logic_vector(to_unsigned(15, 32));
	
	signal hi_in : std_logic_vector(31 downto 0) := std_logic_vector(to_unsigned(16, 32));
	signal lo_in : std_logic_vector(31 downto 0) := std_logic_vector(to_unsigned(17, 32));
	signal z_hi_in : std_logic_vector(31 downto 0) := std_logic_vector(to_unsigned(18, 32));
	signal z_lo_in : std_logic_vector(31 downto 0) := std_logic_vector(to_unsigned(19, 32));
	signal PC_in : std_logic_vector(31 downto 0) := std_logic_vector(to_unsigned(20, 32));
	signal MDR_in : std_logic_vector(31 downto 0) := std_logic_vector(to_unsigned(21, 32));
	signal port_in: std_logic_vector(31 downto 0) := std_logic_vector(to_unsigned(22, 32));
	signal c_sign_extended : std_logic_vector(31 downto 0) := std_logic_vector(to_unsigned(23, 32));
	
	signal s_in : std_logic_vector(4 downto 0) := std_logic_vector(to_unsigned(0, 5));

	-- Output
	signal output : std_logic_vector(31 downto 0);
	
	-- Clock
	signal clk : std_logic;
	constant clk_period : time := 10 ns;
	
	-- Simulate process
	BEGIN
		test_unit : busMux PORT MAP (
			r00_in => r00_in,
			r01_in => r01_in, 
			r02_in => r02_in, 
			r03_in => r03_in,
			r04_in => r04_in, 
			r05_in => r05_in, 
			r06_in => r06_in, 
			r07_in => r07_in, 
			r08_in => r08_in, 
			r09_in => r09_in, 
			r10_in => r10_in, 
			r11_in => r11_in, 
			r12_in => r12_in, 
			r13_in => r13_in, 
			r14_in => r14_in, 
			r15_in => r15_in, 
			hi_in => hi_in, 
			lo_in => lo_in, 
			z_hi_in => z_hi_in, 
			z_lo_in => z_lo_in,
			PC_in => PC_in, 
			MDR_in => MDR_in, 
			port_in => port_in, 
			c_sign_extended => c_sign_extended,
			s_in => s_in,
			output => output
		);
		
		clk_process : PROCESS
		BEGIN
			wait for 100ns;
				s_in <= "00000";
				wait for clk_period;
				s_in <= "00001";
				wait for clk_period;
				s_in <= "00010";
				wait for clk_period;
				s_in <= "00011";
				wait for clk_period;
				s_in <= "00100";
				wait for clk_period;
				s_in <= "00101";
				wait for clk_period;
				s_in <= "00110";
				wait for clk_period;
				s_in <= "00111";
				wait for clk_period;
				s_in <= "01000";
				wait for clk_period;
				s_in <= "01001";
				wait for clk_period;
				s_in <= "01010";
				wait for clk_period;
				s_in <= "01011";
				wait for clk_period;
				s_in <= "01100";
				wait for clk_period;
				s_in <= "01101";
				wait for clk_period;
				s_in <= "01110";
				wait for clk_period;
				s_in <= "01111";
				wait for clk_period;
				s_in <= "10000";
				wait for clk_period;
				
				
			WAIT;
		END PROCESS;
	END;