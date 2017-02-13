LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY full_adder IS
PORT(
A, B, Cin	:	IN STD_LOGIC;
Cout, Sout	:	OUT STD_LOGIC);
END full_adder;

ARCHITECTURE behavioral OF full_adder IS
BEGIN
	-- Full Adder VHDL code implementation
	Cout <= ((A AND Cin) OR (B AND Cin) OR (A AND B));
	Sout <= (A XOR B) XOR Cin;
END behavioral;