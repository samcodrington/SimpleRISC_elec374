LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Seven_Seg_Display_Out IS
	PORT (clk: IN STD_LOGIC;
		data: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		output: OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END Seven_Seg_Display_Out;

ARCHITECTURE Behavior of Seven_Seg_Display_Out IS
BEGIN

PROCESS (clk)
BEGIN
	IF (clk'EVENT AND clk = '0') THEN
		CASE data(3 DOWNTO 0) IS
		WHEN "0000" =>
			output <= "11000000";
		WHEN "0001" =>
			output <= "11111001";
		WHEN "0010" =>
			output <= "10100100";
		WHEN "0011" =>
			output <= "10110000";
		WHEN "0100" =>
			output <= "10011001";
		WHEN "0101" =>
			output <= "10010010";
		WHEN "0110" =>
			output <= "10000010";
		WHEN "0111" =>
			output <= "11111000";
		WHEN "1000" =>
			output <= "10000000";
		WHEN "1001" =>
			output <= "10010000";
		WHEN "1010" =>
			output <= "10001000";
		WHEN "1011" =>
			output <= "10000011";
		WHEN "1100" =>
			output <= "11000110";
		WHEN "1101" =>
			output <= "10100001";
		WHEN "1110" =>
			output <= "10000110";
		WHEN "1111" =>
			output <= "10001110";
		WHEN others =>
			Output <= "11111111";
		END CASE;
	END IF;
END PROCESS;
END ARCHITECTURE Behavior;