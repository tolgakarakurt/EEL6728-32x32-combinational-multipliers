------------------------------------------------------------------------------------------
--Karakurt--------------------------------------------------------------------------------
------------------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY MAJ IS
	--generic (delay: time := 135 ps);
	PORT( I0, I1, I2: IN STD_LOGIC;
	  	       O: OUT STD_LOGIC );
END ENTITY;
------------------------------------------------------------------------------------------
ARCHITECTURE MAJ_arch OF MAJ IS
	--signal clk : std_logic := '0';
	--constant period : time := 10 ns;
BEGIN
	O <= (I0 AND I1) OR (I0 AND I2) OR (I1 AND I2); --after delay;
END ARCHITECTURE;
------------------------------------------------------------------------------------------
