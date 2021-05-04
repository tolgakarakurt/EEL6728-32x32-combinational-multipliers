------------------------------------------------------------------------------------------
--Karakurt--------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;

ENTITY A_register_8b_dp IS
    GENERIC(m : INTEGER := 8);
    
	PORT(clk : IN STD_LOGIC;
             op  : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
	     F   : IN STD_LOGIC_VECTOR(m-1 DOWNTO 0); 
             A   : OUT STD_LOGIC_VECTOR(m-1 DOWNTO 0)
            );
END ENTITY;
------------------------------------------------------------------------------------------
ARCHITECTURE behavioral of A_register_8b_dp IS

SIGNAL Aop : STD_LOGIC_VECTOR(1 DOWNTO 0):= "00";

BEGIN
       Aop <= op(5 DOWNTO 4);
     
	PROCESS(clk,Aop)	
	BEGIN 
			IF     (clk 'event AND clk = '1') THEN
				 					
				IF (Aop = "00" ) THEN 
					A <= A;					
								        --NO LOADING
				 				
				ELSIF (Aop = "01" ) THEN
					A <= F(m-1) & F(m-1 DOWNTO 1);  --SHIFT and LOAD

				ELSIF (Aop = "10" OR Aop = "11" ) THEN
					A <= (OTHERS => '0');	 
					
			       
				END IF;
			
			END IF;
			
	END PROCESS;
	
END ARCHITECTURE;

------------------------------------------------------------------------------------------
