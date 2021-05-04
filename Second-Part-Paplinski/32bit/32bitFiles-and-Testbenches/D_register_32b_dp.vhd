------------------------------------------------------------------------------------------
--Karakurt--------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;

ENTITY D_register_32b_dp IS
    GENERIC(m : positive := 32);
    
	PORT(clk : IN STD_LOGIC;
             op  : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
	     DD  : IN STD_LOGIC_VECTOR(m-1 DOWNTO 0); 
             D   : OUT STD_LOGIC_VECTOR(m-1 DOWNTO 0)
            );
END ENTITY;

ARCHITECTURE behavioral of D_register_32b_dp IS

SIGNAL D_s : STD_LOGIC_VECTOR(m-1 DOWNTO 0):=x"0000_0000";
SIGNAL Dop : STD_LOGIC:= '0';

BEGIN
       Dop <= op(6);

	PROCESS(clk)
	BEGIN
		
			
		IF (clk 'event AND clk = '1') THEN
			IF (Dop = '0' ) THEN 			
			D_s <= D_s;
			ELSIF (Dop = '1' ) THEN 
			D_s <= DD;
			END IF;
		END IF;
	END PROCESS;
	D <= D_s;
END ARCHITECTURE;


