LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_signed.all;

ENTITY twos_comp IS
PORT (
	input : IN  std_logic_vector(31 downto 0);
	output : OUT std_logic_vector(31 downto 0)
);
END twos_comp;
Architecture twos_comp_arch of twos_comp is
	SIGNAL neg, w_output : std_logic_vector(31 downto 0);
	SIGNAL one : std_logic_vector(31 downto 0);

BEGIN
	one <= x"00000001";
	output <= (not input) + one;
	
END ARCHITECTURE twos_comp_arch;

