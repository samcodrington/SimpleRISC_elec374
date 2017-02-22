LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY cpu_bus_tb IS
END ENTITY;
ARCHITECTURE cpu_bus_arch OF cpu_bus_tb IS

	
	COMPONENT cpu_bus IS
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
	END COMPONENT cpu_bus;
	
	SIGNAL tb_BusMuxOut	:	std_logic_vector(31 downto 0);
	SIGNAL bus_out : std_logic_vector(23 downto 0);
	SIGNAL tb_r00in,tb_r01in,tb_r02in, tb_r03in,
	tb_r04in,tb_r05in,tb_r06in, tb_r07in, 
	tb_r08in,tb_r09in,tb_r10in, tb_r11in, 
	tb_r12in,tb_r13in,tb_r14in, tb_r15in, 
	tb_HIin, tb_LOin, tb_ZHiIn, tb_ZLoIn,
	tb_PCin, tb_MDRin,tb_portIn,tb_cIn	:	std_logic_vector(31 downto 0);
BEGIN
	DUT : cpu_bus
	PORT MAP(
	R00out =>bus_out(0) ,	R01out =>bus_out(1) ,	R02out =>bus_out(2) ,	R03out =>bus_out(3) ,
	R04out =>bus_out(4) ,	R05out =>bus_out(5) ,	R06out =>bus_out(6) ,	R07out =>bus_out(7) ,
	R08out =>bus_out(8) ,	R09out =>bus_out(9) ,	R10out =>bus_out(10) ,	R11out =>bus_out(11) ,
	R12out =>bus_out(12) ,	R13out =>bus_out(13) ,	R14out =>bus_out(14) ,	R15out =>bus_out(15) ,
	hiout => bus_out(16) ,	loout => bus_out(17) ,	Zhiout =>bus_out(18) ,	Zloout =>bus_out(19) ,
	PCout => bus_out(20) ,	MDRout =>bus_out(21) ,	portout=>bus_out(22) ,	Cout =>  bus_out(23) ,
	
	R00in =>tb_R00in,	R01in =>tb_R01in,	R02in =>tb_R02in,	R03in =>tb_R03in,
	R04in =>tb_R04in,	R05in =>tb_R05in,	R06in =>tb_R06in,	R07in =>tb_R07in,
	R08in =>tb_R08in,	R09in =>tb_R09in,	R10in =>tb_R10in,	R11in =>tb_R11in,
	R12in =>tb_R12in,	R13in =>tb_R13in,	R14in =>tb_R14in,	R15in =>tb_R15in,
	hiin => tb_hiin,	loin => tb_loin,	Zhiin =>tb_Zhiin,	Zloin =>tb_Zloin,
	PCin => tb_PCin,	MDRin =>tb_MDRin,	portin=>tb_portin,	Cin =>  tb_Cin,
	BusMuxOut => tb_BusMuxOut
	);
	tb_proc : process
	begin
		tb_R00in <= x"00000000";
		tb_R01in <= x"00000004";
		tb_R02in <= x"00000008";
		tb_R03in <= x"0000000C";
		tb_R04in <= x"00000010";
		tb_R05in <= x"00000014";
		tb_R06in <= x"00000018";
		tb_R07in <= x"0000001C";
		tb_R08in <= x"00000020";
		tb_R09in <= x"00000024";
		tb_R10in <= x"00000028";
		tb_R11in <= x"0000002C";
		tb_R12in <= x"00000030";
		tb_R13in <= x"00000034";
		tb_R14in <= x"00000038";
		tb_R15in <= x"0000003C";
		tb_HIin  <= x"00000040";
		tb_LOin  <= x"00000044";
		tb_ZHIin <= x"00000048";
		tb_ZLOin <= x"0000004C";
		tb_PCin  <= x"00000050";
		tb_MDRin <= x"00000054";
		tb_portin<= x"00000058";
		tb_Cin   <= x"0000005C";
		wait for 10 ns;
		
		
		bus_out <= "000000000000000000000001";
		wait for 10 ns;
		bus_out <= "000000000000000000000010";
		wait for 10 ns;
		bus_out <= "000000000000000000000100";
		wait for 10 ns;
		bus_out <= "000000000000000000001000";
		wait for 10 ns;
		bus_out <= "000000000000000000010000";
		wait for 10 ns;
		bus_out <= "000000000000000000100000";
		wait for 10 ns;
		bus_out <= "000000000000000001000000";
		wait for 10 ns;
		bus_out <= "000000000000000010000000";
		wait for 10 ns;
		bus_out <= "000000000000000100000000";
		wait for 10 ns;
		bus_out <= "000000000000001000000000";
		wait for 10 ns;
		bus_out <= "000000000000010000000000";
		wait for 10 ns;
		bus_out <= "000000000000100000000000";
		wait for 10 ns;
		bus_out <= "000000000001000000000000";
		wait for 10 ns;
		bus_out <= "000000000010000000000000";
		wait for 10 ns;
		bus_out <= "000000000100000000000000";
		wait for 10 ns;
		bus_out <= "000000001000000000000000";
		wait for 10 ns;
		bus_out <= "000000010000000000000000";
		wait for 10 ns;
		bus_out <= "000000100000000000000000";
		wait for 10 ns;
		bus_out <= "000001000000000000000000";
		wait for 10 ns;
		bus_out <= "000010000000000000000000";
		wait for 10 ns;
		bus_out <= "000100000000000000000000";
		wait for 10 ns;
		bus_out <= "001000000000000000000000";
		wait for 10 ns;
		bus_out <= "010000000000000000000000";
		wait for 10 ns;
		bus_out <= "100000000000000000000000";
		wait for 10 ns;
		bus_out <= "100000000000000000000001";
		wait;
	end process tb_proc;

END;