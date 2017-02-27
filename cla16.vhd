LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY cla16 IS
PORT(
	A, B 				:	IN 	STD_LOGIC_VECTOR(15 downto 0);
	Cin					:	IN 	STD_LOGIC;
	GGout, PGout, Cout	:	OUT STD_LOGIC;
	Sout				:	OUT	STD_LOGIC_VECTOR(15 downto 0)
	);
END cla4;

ARCHITECTURE behavioral OF cla16 IS

SIGNAL P,G,S			:	STD_LOGIC_VECTOR(3 downto 0) := "0000";
SIGNAL C				:	STD_LOGIC_VECTOR(4 downto 0) := "00000";
SIGNAL S1, S2, S3, S4	:	STD_LOGIC_VECTOR(15 downto 0);

C(0) <= Cin;

COMPONENT cla4
PORT(
	A, B 				:	IN 	STD_LOGIC_VECTOR(3 downto 0);
	Cin					:	IN 	STD_LOGIC;
	GGout, PGout, Cout	:	OUT STD_LOGIC;
	Sout				:	OUT	STD_LOGIC_VECTOR(3 downto 0)
	);
END COMPONENT;

BEGIN

	C(0) <= Cin;
	cla4_1	:	cla_bit_stage PORT MAP( A(3 downto 0), B(3 downto 0), C(0), G(0), P(0), S1;
	C(1) <= G(0) OR (P(0) AND C(0));
	cla4_2	:	cla_bit_stage PORT MAP( A(7 downto 4), B(7 downto 4), C(1), G(1), P(1), S2;
	C(2) <= G(1) OR (P(1) AND C(1));
	cla4_3	:	cla_bit_stage PORT MAP( A(11 downto 8), B(11 downto 8), C(2), G(2), P(2), S3;
	C(3) <= G(2) OR (P(2) AND C(2));
	cla4_4	:	cla_bit_stage PORT MAP( A(15 downto 12), B(15 downto 12), C(3), G(3), P(3), S4;
	C(4) <= G(3) OR (P(3) AND C(3));
	
	GGout <= G(3) OR (P(3) AND G(2)) OR (P(3) AND P(2) AND G(1)) OR (P(3) AND P(2) AND P(1) AND G(0));
	PGout <= P(3) AND P(2) AND P(1) AND P(0);
	Cout <= C(4);
	-- Double check order of sum
	Sout <= S4 & S3 & S2 & S1;
	
END behavioral;