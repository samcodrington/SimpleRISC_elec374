LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY CPU_BUS is
PORT(
	R00out, R01out, R02out, R03out,
	R04out, R05out, R06out, R07out,
	R08out, R09out, R10out, R11out,
	R12out, R13out, R14out, R15out,
	hiout, loout, zhiout, zloout,
	pcout, mdrout, portout, cOut: IN std_logic;
	r00in, r01in, r02in, r03in,
	r04in, r05in, r06in, r07in, 
	r08in, r09in, r10in, r11in, 
	r12in, r13in, r14in, r15in, 
	HIin, LOin, ZHiIn, ZLoIn,
	PCin, MDRin, portIn, cIn	:	IN std_logic_vector(31 downto 0);
	BusMuxOut	:	OUT std_logic_vector(31 downto 0)
);
END ENTITY;

ARCHITECTURE arch OF CPU_BUS IS
SIGNAL s : std_logic_vector(4 downto 0);
	COMPONENT busMux IS
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
	END COMPONENT busMux;
	COMPONENT busMux_encoder IS
		PORT(
			r00_out, r01_out, r02_out, r03_out,
			r04_out, r05_out, r06_out, r07_out,
			r08_out, r09_out, r10_out, r11_out,
			r12_out, r13_out, r14_out, r15_out,
			hi_out, lo_out, z_hi_out, z_lo_out,
			PC_out, MDR_out, port_out, c_out	: IN std_logic;
			s_out	:	OUT std_logic_vector(4 downto 0)
		);
	END COMPONENT busMux_encoder;
	BEGIN
	
	BM : busMux 
		PORT MAP(
		r00_in => R00In,		r01_in => R01In,		r02_in => R02In,		r03_in => R03In,
		r04_in => R04In,		r05_in => R05In,		r06_in => R06In,		r07_in => R07In,
		r08_in => R08In,		r09_in => R09In,		r10_in => R10In,		r11_in => R11In,
		r12_in => R12In,		r13_in => R13In,		r14_in => R14In,		r15_in => R15In,
		hi_in=> HIIn, 	lo_in=>LOIn, z_hi_in=> ZHIIn, z_lo_in=>ZLOIn,
		PC_in=> PCin, MDR_in=> MDRin, Port_in=>PortIn, c_sign_extended=> CIn,
		s_in => s,
		output => BusMuxOut

		);
	BM_enc : busMux_encoder
		PORT MAP(
		r00_out => R00out,		r01_out => R01out,		r02_out => R02Out,		r03_out => R03out,
		r04_out => R04out,		r05_out => R05out,		r06_out => R06Out,		r07_out => R07out,
		r08_out => R08out,		r09_out => R09out,		r10_out => R10Out,		r11_out => R11out,
		r12_out => R12out,		r13_out => R13out,		r14_out => R14Out,		r15_out => R15out,
		hi_out=> HIOut, 	lo_out => LOOut, z_hi_out=> ZHIOut, z_lo_Out=>ZLOOut,
		PC_out=> PCout, 	MDR_out=> MDROut, port_out=>PortOut, c_out=>COut,
		s_out => s
		);
	END;
		

		