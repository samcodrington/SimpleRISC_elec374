LIBRARY ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

ENTITY booth_mul IS
	PORT
	(
		Ain :   IN STD_LOGIC_VECTOR(31 downto 0);
		Bin :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		output :  OUT  STD_LOGIC_VECTOR(63 DOWNTO 0)
	);
END booth_mul;

ARCHITECTURE booth_mul OF booth_mul IS
	SIGNAL aneg :							STD_LOGIC_VECTOR(31 downto 0);
	SIGNAL shift_pos, shift_neg :  	STD_LOGIC_VECTOR(63 downto 0);
	SIGNAL result: 						STD_LOGIC_VECTOR(63 downto 0);
BEGIN
	process(Ain, Bin)
	begin
		shift_pos		<= x"00000000" & Ain;
		shift_neg 		<= x"00000000" & (not Ain + x"00000001");
		if (Bin(0) = '1') then
			result <= result + shift_pos;
		end if;
		for i in 1 to 15 loop
			shift_pos <= shift_pos(63 downto 2) & "00";
			shift_neg <= shift_neg(63 downto 2) & "00";
			if (Bin(i*2+1 downto i*2) = "01" ) then
					result <= result + shift_neg;
			elsif	(Bin(i*2+1 downto i*2) = "10" ) then
					result <= result + shift_pos;
			end if;
		end loop;
	output <= result;	
	end process;
END;
	