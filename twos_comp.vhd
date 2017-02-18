LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY twos_comp IS
PORT (
	input : IN  std_logic_vector(31 downto 0);
	output : OUT std_logic_vector(31 downto 0)
);
END twos_comp;
Architecture twos_comp_arch of twos_comp is
	SIGNAL neg, w_output : std_logic_vector(31 downto 0);

	COMPONENT lpm_add_sub0
		PORT(add_sub : IN STD_LOGIC;
			 dataa : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			 datab : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			 result : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
			);
	END COMPONENT lpm_add_sub0;

BEGIN
	add1 : lpm_add_sub0
		PORT MAP(
			add_sub => '1',
			dataa  => neg,
			datab  => x"00000001",
			result => output
		);
		
	negate: process(input)
	begin
		for i in 0 to 31 loop
			neg(i)<= not input(i);
		end loop;
	end process negate;
	
END ARCHITECTURE twos_comp_arch;

