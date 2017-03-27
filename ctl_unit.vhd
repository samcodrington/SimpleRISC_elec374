LIBRARY.IEEE;
USE ieee.std_logic_1164.all;

ENTITY ctl_unit IS
	PORT(
		clk, rst, stop, con_ff	:	IN STD_LOGIC;
		IR								:	IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		
		

	);
END ctl_unit;
