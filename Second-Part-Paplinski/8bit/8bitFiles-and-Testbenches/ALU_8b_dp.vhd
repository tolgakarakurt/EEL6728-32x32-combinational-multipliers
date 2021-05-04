------------------------------------------------------------------------------------------
--Karakurt--------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.NUMERIC_STD.all;

ENTITY ALU_8b_dp IS
    GENERIC(m : INTEGER := 8);
    
	PORT(A  : IN  SIGNED(m-1 DOWNTO 0);
	     B  : IN  SIGNED(m-1 DOWNTO 0); 
             op : IN  STD_LOGIC_VECTOR(1 DOWNTO 0);
	     F  : OUT SIGNED(m-1 DOWNTO 0)
            );
END ENTITY;
------------------------------------------------------------------------------------------
ARCHITECTURE behavioral of ALU_8b_dp IS

SIGNAL Fop : STD_LOGIC_VECTOR(1 DOWNTO 0):="00";

BEGIN
      Fop <= op(1 DOWNTO 0);

	WITH Fop SELECT
		F <= A+B   WHEN "01", 
		     A-B   WHEN "10",
		     A     WHEN OTHERS;

END ARCHITECTURE;

------------------------------------------------------------------------------------------
