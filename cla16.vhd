LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY cla16 IS
PORT(
	A, B 						:	IN 	STD_LOGIC_VECTOR(15 downto 0);
	Cin						:	IN 	STD_LOGIC;
	GGout, PGout, Cout	:	OUT STD_LOGIC;
	Sout						:	OUT	STD_LOGIC_VECTOR(15 downto 0)
	);
END cla16;

ARCHITECTURE behavioral OF cla16 IS

SIGNAL P,G,S				:	STD_LOGIC_VECTOR(3 downto 0) := "0000";
SIGNAL S1, S2, S3, S4	:	STD_LOGIC_VECTOR(3 downto 0);
SIGNAL C0, C1, C2, C3, C4	:	STD_LOGIC;

ALIAS A_Part1 IS A(3 downto 0);
ALIAS A_Part2 IS A(7 downto 4);
ALIAS A_Part3 IS A(11 downto 8);
ALIAS A_Part4 IS A(15 downto 12);

ALIAS B_Part1 IS B(3 downto 0);
ALIAS B_Part2 IS B(7 downto 4);
ALIAS B_Part3 IS B(11 downto 8);
ALIAS B_Part4 IS B(15 downto 12);

COMPONENT cla4
PORT(
	A, B 						:	IN 	STD_LOGIC_VECTOR(3 downto 0);
	Cin						:	IN 	STD_LOGIC;
	GGout, PGout, Cout	:	OUT	STD_LOGIC;
	Sout						:	OUT	STD_LOGIC_VECTOR(3 downto 0)
	);
END COMPONENT;

COMPONENT cla_bit_stage 
PORT(
	A, B, Cin			:	IN STD_LOGIC;
	Gout, Pout, Sout	:	OUT STD_LOGIC
	);
END COMPONENT;

BEGIN

	C0 <= Cin;
	
	cla4_1	:	cla4 PORT MAP( A_part1, B_part1, C0, G(0), P(0), C1, S1);
	cla4_2	:	cla4 PORT MAP( A_part2, B_part2, C1, G(1), P(1), C2, S2);
	cla4_3	:	cla4 PORT MAP( A_part3, B_part3, C2, G(2), P(2), C3, S3);
	cla4_4	:	cla4 PORT MAP( A_part4, B_part4, C3, G(3), P(3), C4, S4);
	
	GGout <= G(3) OR (P(3) AND G(2)) OR (P(3) AND P(2) AND G(1)) OR (P(3) AND P(2) AND P(1) AND G(0));
	PGout <= P(3) AND P(2) AND P(1) AND P(0);
	Cout <= C4;
	-- Double check order of sum
	Sout <= S4 & S3 & S2 & S1;
	
END behavioral;