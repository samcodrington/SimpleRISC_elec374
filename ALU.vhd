-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- PROGRAM		"Quartus II 64-Bit"
-- VERSION		"Version 13.0.1 Build 232 06/12/2013 Service Pack 1 SJ Web Edition"
-- CREATED		"Mon Feb 13 09:20:11 2017"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY ALU IS 
	PORT
	(
		Ain :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		Bin :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		opcode :  IN  STD_LOGIC_VECTOR(4 DOWNTO 0);
		Zout :  OUT  STD_LOGIC_VECTOR(63 DOWNTO 0)
	);
END ALU;

ARCHITECTURE bdf_type OF ALU IS 

COMPONENT lpm_add_sub0
	PORT(add_sub : IN STD_LOGIC;
		 dataa : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 datab : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT lpm_divide0
	PORT(denom : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 numer : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 quotient : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 remain : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT lpm_clshift1
	PORT(direction : IN STD_LOGIC;
		 data : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 distance : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT lpm_clshift0
	PORT(direction : IN STD_LOGIC;
		 data : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 distance : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	add_out :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	sub_out :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	incpc_out :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	dist :  STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL	div_quo :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	div_rem :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	lr_sel :  STD_LOGIC;
SIGNAL	rot_lr_sel :  STD_LOGIC;
SIGNAL	rot_out :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	shift_out :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	zlo : STD_LOGIC_VECTOR(31 DOWNTO 0);
TYPE op IS (add, sub, mul, div, and_op, or_op, shr, shl, rot_r, rot_l, inc_pc, neg, not_op, ;


BEGIN 
--COMPONENT INSTANTIATION
adder : lpm_add_sub0
PORT MAP(add_sub => '0',
		 dataa => Ain,
		 datab => Bin,
		 result =>add_out);

subber : lpm_add_sub0
PORT MAP(add_sub => '1',
		 dataa => Ain,
		 datab => Bin,
		 result =>sub_out);

incpc : lpm_add_sub0
PORT MAP(add_sub => '0',
			dataa => Ain,
			datab => x"0000_0004",
			result=> incpc_out);


b2v_divider : lpm_divide0
PORT MAP(denom => Bin,
		 numer => Ain,
		 quotient =>div_quo,
		 remainder=>div_rem);


b2v_rotator : lpm_clshift1
PORT MAP(direction => rot_lr_sel,
		 data => Ain,
		 distance => dist,
		 result => rot_out);


b2v_shifter : lpm_clshift0
PORT MAP(direction => lr_sel,
		 data => Ain,
		 distance => dist,
		 result => shift_out);

process(Ain,Bin,opcode)
case opcode is
	when "00101" op<= add;
	when "00110" op<= sub;
	when "00111" op<= and_op;
	when "01000" op<= or_op;
	when "01001" op<= shr;
	when "01010" op<= shl;
	when "01011" op<= rot_r;
	when "01100" op<= rot_l;
	when "
end case;		 

END bdf_type;