LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY work;
ENTITY cpu_codyale IS
	--PORT ();
END cpu_codyale;

ARCHITECTURE arch OF cpu_codyale IS
COMPONENT reg32
	PORT( 
		input				:	IN std_logic_vector(31 downto 0);
		clr,clk,reg_in	:	IN std_logic;
		output			:	OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT reg32;
	BEGIN
		--do shit here
	END;
END;