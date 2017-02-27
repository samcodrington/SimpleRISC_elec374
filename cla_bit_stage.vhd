LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY cla_bit_stage IS
PORT(
A, B, Cin			:	IN STD_LOGIC;
Gout, Pout, Sout	:	OUT STD_LOGIC);
END cla_bit_stage;

ARCHITECTURE behavioral OF cla_bit_stage IS
BEGIN
	-- Bit Stage Cell VHDL code implementation
	Gout <= A AND B;
	Pout <= A XOR B;
	Sout <= Pout XOR Cin;
END behavioral;