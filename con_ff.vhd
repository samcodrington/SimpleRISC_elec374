LIBRARY IEEE;
use ieee.std_logic_1164.all;

ENTITY con_ff IS
	PORT(
		busin	: IN STD_LOGIC_VECTOR(31 downto 0);
		IRin	: IN STD_LOGIC_VECTOR(1 downto 0);
		CONin : IN STD_LOGIC;
		Q		: OUT STD_LOGIC
	);
END ENTITY;

ARCHITECTURE behavioural OF con_ff IS
	BEGIN
	process(busin,IRin,CONin)
		begin
			if (CONin = '1') then
				case IRin is
					when "00" => 
						if busin = x"00000000" then Q <= '1'; --branch if equal to 0
						else Q <= '0';
						end if;
					when "01" => 
						if busin /= x"00000000" then Q <= '1'; --branch if equal to nonzero
						else Q <= '0';
						end if;
					when "10" =>
						if busin(31) = '0' then Q <= '1'; --branch if negative
						else Q <= '0';
						end if;
					when "11" =>
						if busin(31) = '1' then Q <= '1'; --branch if negative
						else Q <= '0';
						end if;
					when others => --shouldn't get here
				end case;
			else 
				Q <= '0';
			end if;
	end process;
END;
	