LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY cla4 IS
PORT(
	A, B 			:	IN 	STD_LOGIC_VECTOR(3 downto 0);
	Cin				:	IN 	STD_LOGIC;
	GGout, PGout	:	OUT STD_LOGIC;
	Cout			:	OUT	STD_LOGIC
	);
END cla4;

ARCHITECTURE behavioral OF cla4 IS

SIGNAL P,G,S	:	STD_LOGIC_VECTOR(3 downto 0) := "0000";
SIGNAL C	:	STD_LOGIC_VECTOR(4 downto 0) := "00000";

C(0) <= Cin;

COMPONENT cla_bit_stage 
PORT(
	A, B, Cin			:	IN STD_LOGIC;
	Gout, Pout, Sout	:	OUT STD_LOGIC
	);
END COMPONENT;

BEGIN

	C(0) <= Cin;
	cla_adder1	:	cla_bit_stage PORT MAP( A(0), B(0), C(0), G(0), P(0), S(0);
	C(1) <= G(0) OR (P(0) AND C(0));
	cla_adder2	:	cla_bit_stage PORT MAP( A(1), B(1), C(1), G(1), P(1), S(1);
	C(2) <= G(1) OR (P(1) AND C(1));
	cla_adder3	:	cla_bit_stage PORT MAP( A(2), B(2), C(2), G(2), P(2), S(2);
	C(3) <= G(2) OR (P(2) AND C(2));
	cla_adder4	:	cla_bit_stage PORT MAP( A(3), B(3), C(3), G(3), P(3), S(3);
	C(4) <= G(3) OR (P(3) AND C(3));
	
	GGout <= G(3) OR (P(3) AND G(2)) OR (P(3) AND P(2) AND G(1)) OR (P(3) AND P(2) AND P(1) AND G(0));
	PGout <= P(3) AND P(2) AND P(1) AND P(0);
	Cout <= C(4);
	
END behavioral;