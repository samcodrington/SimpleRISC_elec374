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
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

LIBRARY work;

ENTITY ALU IS 
	PORT
	(
		Ain :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		Bin :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		opcode :  IN  STD_LOGIC_VECTOR(4 DOWNTO 0);
		IncPC : IN STD_LOGIC;
		Zout :  OUT  STD_LOGIC_VECTOR(63 DOWNTO 0)
	);
END ALU;

ARCHITECTURE bdf_type OF ALU IS 

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
PORT(
		direction : IN STD_LOGIC;
		data : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		distance : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		result : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT cla16
PORT(
	A, B 				:	IN 	STD_LOGIC_VECTOR(15 downto 0);
	Cin					:	IN 	STD_LOGIC;
	GGout, PGout, Cout	:	OUT STD_LOGIC;
	Sout				:	OUT	STD_LOGIC_VECTOR(15 downto 0)
	);
END COMPONENT;

COMPONENT twos_comp
PORT(
	input	:	IN STD_LOGIC_VECTOR(31 downto 0);
	output:	OUT STD_LOGIC_VECTOR(31 downto 0)
);
END COMPONENT;

COMPONENT booth_mul
PORT(
		Ain :   IN STD_LOGIC_VECTOR(31 downto 0);
		Bin :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		output :  OUT  STD_LOGIC_VECTOR(63 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	div_quo,div_rem, rot_out, shift_out :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	dist :  STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL	lr_sel, rot_lr_sel :  STD_LOGIC;

SIGNAL	cla16_sum_out : STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	cla16_filler :	STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
SIGNAL	booth_out : STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL	RCA_c_out, gnd : STD_LOGIC;


BEGIN 
--COMPONENT INSTANTIATION
b2v_divider : lpm_divide0
PORT MAP(
			denom => Bin,
			numer => Ain,
			quotient =>div_quo,
			remain=>div_rem
		);
		 
b2v_rotator : lpm_clshift1
PORT MAP(
			direction => rot_lr_sel,
			data => Ain,
			distance => dist,
			result => rot_out
		);
		 
b2v_shifter : lpm_clshift0
PORT MAP(
			direction => lr_sel,
			data => Ain,
			distance => dist,
			result => shift_out
		);
		 
cla16_inst : cla16
PORT MAP(
			A => Ain(15 downto 0),
			B => Bin(15 downto 0),
			Cin => '0',
			GGout => GGout,
			PGout => PGout,
			Cout => Cout,
			Sout => cla16_sum_out
		);

bMulInst : booth_mul			
PORT MAP(
			Ain => Ain,
			Bin => Bin,
			output => booth_out
		);

op_proc: process(incPC,opcode,Ain,Bin, cla16_sum_out, booth_out)
begin
	if incPC = '1' then
		Zout(63 downto 32) <= x"00000000";	Zout(31 downto 0) <= (Bin + x"00000004");
	else 
		case opcode is

			when "00101" =>	Zout(63 downto 32) <= x"00000000";
									Zout(31 downto 0) <= (Ain + Bin); 		-- op<= add;
			when "00110" => Zout(63 downto 32) <= x"00000000";
									Zout(31 downto 0) <= (Ain - Bin);		-- op<= sub;
			when "00111" => Zout(63 downto 32) <= x"00000000";
									Zout(31 downto 0) <= (Ain and Bin);		-- op<= and_op;
			when "01000" =>	Zout(63 downto 32) <= x"00000000";
									Zout(31 downto 0) <= (Ain or Bin);  	--op<= or_op;
			when "01001" =>	Zout(63 downto 32) <= x"00000000";
									Zout(31 downto 0) <= shift_out;	
									dist <= Bin(4 downto 0); 
									lr_sel <= '0';							-- op<= shr;
			when "01010" =>	Zout(63 downto 32) <= x"00000000";
									Zout(31 downto 0) <= shift_out;
									dist <= Bin(4 downto 0); 
									lr_sel <= '1';							-- op<= shl;
			when "01011" =>	Zout(63 downto 32) <= x"00000000";
									Zout(31 downto 0) <=rot_out; 		
									dist <= Bin(4 downto 0); 
									lr_sel <= '0';							-- op<= rot_r;
			when "01100" =>	Zout(63 downto 32) <= x"00000000";	
									Zout(31 downto 0) <=rot_out;		
									dist <= Bin(4 downto 0); 
									lr_sel <= '1';							-- op<= rot_l;
			when "01101" =>	Zout(63 downto 32) <= x"00000000";
									Zout(31 downto 0) <= (Ain + Bin);		-- op<= add; --addi
			when "01110" =>	Zout(63 downto 32) <= x"00000000";	
									Zout(31 downto 0) <= (Ain and Bin);		-- op<= and_op; --andi
			when "01111" =>	Zout(63 downto 32) <= x"00000000";	
									Zout(31 downto 0) <= (Ain or Bin);		-- op<= or_op; --ori
			when "10000" =>	Zout <= booth_out; 						-- op<= mul;
			when "10001" =>	Zout(63 downto 32) <= div_rem;		
									Zout(31 downto 0) <= div_quo; 			-- op<= div;
			when "10010" =>	Zout(63 downto 32) <= x"00000000";	
							Zout(31 downto 0) <= (not Ain + x"00000001");  	 	-- op<= neg;
			when "10011" =>	Zout(63 downto 32) <= x"00000000";	
									Zout(31 downto 0) <= (not Ain);			-- op<= not_op;
			when "11000" =>	Zout <= x"000000000000" & cla16_sum_out;			-- op<= rc_add;
			when others => 	Zout(63 downto 0)  <= x"0F0F0F0F0F0F0F0F";		--ERROR;
		end case;
	end if;
end process;
END bdf_type;