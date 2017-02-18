LIBRARY ieee;
use ieee.std_logic_1164.all;

ENTITY twos_comp_tb IS
END ENTITY;

ARCHITECTURE arch of twos_comp_tb IS
	SIGNAL in_tb, out_tb : std_logic_vector(31 downto 0);
	COMPONENT twos_comp
	PORT (
		input : IN  std_logic_vector(31 downto 0);
		output : OUT std_logic_vector(31 downto 0)
	);
	END COMPONENT;

BEGIN
	DUT : twos_comp
	PORT MAP (
		input => in_tb,
		output => out_tb
	);
	process
	begin
		wait for 10 ns;
		in_tb<= x"00000008";
		wait for 10 ns;
		
		in_tb<= x"FFFF00CC";
		wait;
	end process;
END;
