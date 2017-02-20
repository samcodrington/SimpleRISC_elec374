LIBRARY ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;

ENTITY booth_mul IS
	PORT
	(
		Ain :   IN STD_LOGIC_VECTOR(31 downto 0);
		Bin :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		output :  OUT  STD_LOGIC_VECTOR(63 DOWNTO 0)
	);
END booth_mul;

ARCHITECTURE booth_mul OF booth_mul IS
BEGIN
	process(Ain, Bin)
	variable result, temp, toResult:  	STD_LOGIC_VECTOR(63 downto 0);
	variable toAdd, toSub, zeroes : STD_LOGIC_VECTOR(31 downto 0);
	begin
		toAdd := Ain;
		toSub := (0 - Ain);
		result := x"0000000000000000";
		zeroes := x"00000000";
		for i in 0 to 31 loop
			if (i = 0) then
				if Bin(0) <= '1' then
					toResult(31 downto 0):= toSub;
			end if;
			else 
				if (Bin(i) <= '1' and Bin(i-1) <='0') then
					toResult(31 downto 0):= toSub;
				elsif (Bin(i) <= '0' and Bin(i-1) <='1') then
					toResult(31 downto 0):= toAdd;
				else
					toResult(31 downto 0) := zeroes;
				end if;
			end if;
		--	
		--	--Sign Extension
			if toResult(31) <= '1' then
				toResult(63 downto 32) := x"11111111";
			else
				toResult(63 downto 32) := x"00000000";
			end if;
			toResult := STD_LOGIC_VECTOR(SHIFT_LEFT(UNSIGNED(toResult), i));
			result := result + toResult;
		end loop;
		output <= result;
	end process;
END;
	