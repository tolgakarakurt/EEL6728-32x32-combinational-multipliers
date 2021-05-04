------------------------------------------------------------------------------------------
--Karakurt--------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;

ENTITY Q_register_8b_dp IS
    GENERIC(n : positive := 8);
    
	PORT(clk : IN STD_LOGIC;
             op  : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
	     QQ  : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0); 
             f0  : IN STD_LOGIC;
	     q_1 : IN STD_LOGIC := '0';
             --Q   : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0);
	     Qn_1: OUT STD_LOGIC_VECTOR(n DOWNTO 0);
	     q0_1: OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
             
            );
END ENTITY;
------------------------------------------------------------------------------------------
ARCHITECTURE behavioral of Q_register_8b_dp IS

SIGNAL Qop : STD_LOGIC_VECTOR(1 DOWNTO 0);
--SIGNAL Qn_1: STD_LOGIC_VECTOR(n DOWNTO 0):= "000000000";

BEGIN
       Qop <= op(3 DOWNTO 2);

	PROCESS(clk)
	BEGIN

		IF (clk 'event AND clk = '1') THEN
			IF (Qop = "00" ) THEN 
			
			Qn_1 <= Qn_1;				--NO LOADING
			
			
			ELSIF (Qop = "01" ) THEN 
				Qn_1 <= f0 & Qn_1(n DOWNTO 1);  --SHIFTING
				
				
			ELSIF(Qop = "10" OR Qop = "11" ) THEN 
				Qn_1 <= QQ & q_1; 		--CONCATENATION & LOADING
				
			END IF;
		
		END IF;
		q0_1 <= Qn_1(1 DOWNTO 0);
		
	END PROCESS;

END ARCHITECTURE;
------------------------------------------------------------------------------------------

