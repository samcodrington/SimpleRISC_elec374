LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY rca32 IS
PORT(
	A, B 		:	IN 	STD_LOGIC_VECTOR(31 downto 0);
	Cin		:	IN 	STD_LOGIC;
	Sout		:	OUT STD_LOGIC_VECTOR(31 downto 0);
	Cout		:	OUT	STD_LOGIC
);
END rca32;

architecture behavioral of rca32 is

COMPONENT full_adder
PORT(
	A, B, Cin	:	IN STD_LOGIC;
	Cout, Sout	:	OUT STD_LOGIC
);
END COMPONENT;

SIGNAL c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13,
c14, c15, c16, c17, c18, c19, c20, c21, c22, c23, c24, c25,
c26, c27, c28, c29, c30, c31	:	STD_LOGIC;
 
BEGIN
 
FA1: full_adder PORT MAP( A(0), B(0), Cin, Sout(0), c1);
FA2: full_adder PORT MAP( A(1), B(1), c1, Sout(1), c2);
FA3: full_adder PORT MAP( A(2), B(2), c2, Sout(2), c3);
FA4: full_adder PORT MAP( A(3), B(3), c3, Sout(3), c4);
FA5: full_adder PORT MAP( A(4), B(4), c4, Sout(4), c5);
FA6: full_adder PORT MAP( A(5), B(5), c5, Sout(5), c6);
FA7: full_adder PORT MAP( A(6), B(6), c6, Sout(6), c7);
FA8: full_adder PORT MAP( A(7), B(7), c7, Sout(7), c8);
FA9: full_adder PORT MAP( A(8), B(8), c8, Sout(8), c9);
FA10: full_adder PORT MAP(A(9), B(9), c9, Sout(9), c10);
FA11: full_adder PORT MAP( A(10), B(10), c10, Sout(10), c11);
FA12: full_adder PORT MAP( A(11), B(11), c11, Sout(11), c12);
FA13: full_adder PORT MAP( A(12), B(12), c12, Sout(12), c13);
FA14: full_adder PORT MAP( A(13), B(13), c13, Sout(13), c14);
FA15: full_adder PORT MAP( A(14), B(14), c14, Sout(14), c15);
FA16: full_adder PORT MAP( A(15), B(15), c15, Sout(15), c16);
FA17: full_adder PORT MAP( A(16), B(16), c16, Sout(16), c17);
FA18: full_adder PORT MAP( A(17), B(17), c17, Sout(17), c18);
FA19: full_adder PORT MAP( A(18), B(18), c18, Sout(18), c19);
FA20: full_adder PORT MAP( A(19), B(19), c19, Sout(19), c20);
FA21: full_adder PORT MAP( A(20), B(20), c20, Sout(20), c21);
FA22: full_adder PORT MAP( A(21), B(21), c21, Sout(21), c22);
FA23: full_adder PORT MAP( A(22), B(22), c22, Sout(22), c23);
FA24: full_adder PORT MAP( A(23), B(23), c23, Sout(23), c24);
FA25: full_adder PORT MAP( A(24), B(24), c24, Sout(24), c25);
FA26: full_adder PORT MAP( A(25), B(25), c25, Sout(25), c26);
FA27: full_adder PORT MAP( A(26), B(26), c26, Sout(26), c27);
FA28: full_adder PORT MAP( A(27), B(27), c27, Sout(27), c28);
FA29: full_adder PORT MAP( A(28), B(28), c28, Sout(28), c29);
FA30: full_adder PORT MAP( A(29), B(29), c29, Sout(29), c30);
FA31: full_adder PORT MAP( A(30), B(30), c30, Sout(30), c31);
FA32: full_adder PORT MAP( A(31), B(31), c31, Sout(31), Cout);

END behavioral;