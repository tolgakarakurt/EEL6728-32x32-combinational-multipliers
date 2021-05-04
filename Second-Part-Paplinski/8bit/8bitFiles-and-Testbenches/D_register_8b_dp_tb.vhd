------------------------------------------------------------------------------------------
--Karakurt--------------------------------------------------------------------------------
------------------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY D_register_8b_dp_tb IS
END ENTITY;
 
ARCHITECTURE tb OF D_register_8b_dp_tb IS
 
-- Component Declaration for the Unit Under Test (UUT)
------------------------------------------------------------------------------------------ 
COMPONENT D_register_8b_dp
	PORT(clk : IN STD_LOGIC;
             op  : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
	     DD  : IN STD_LOGIC_VECTOR(7 DOWNTO 0); 
             D   : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
            );
END COMPONENT;
------------------------------------------------------------------------------------------ 
--Inputs
SIGNAL clk_tb : STD_LOGIC := '0';
SIGNAL op_tb  : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0000000";
SIGNAL DD_tb  : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000"; 
 
--Outputs
SIGNAL D_tb   : STD_LOGIC_VECTOR(7 DOWNTO 0);
CONSTANT period : time := 2 ns;
 
BEGIN
 
-- Instantiate the Unit Under Test (UUT)
uut: D_register_8b_dp       
			PORT MAP (clk => clk_tb,
				   op => op_tb,
				   DD => DD_tb,
				    D => D_tb
				  );
			clk_tb <= NOT clk_tb after period/2;
	  	
			op_tb <= "0000000", "1111111" AFTER 10 ns, "1010101" AFTER 20 ns, "0101010" AFTER 30 ns,"1100011" AFTER 40 ns,"1011101" AFTER 50 ns;
		
			DD_tb <= "00000000", "11111111" AFTER 10 ns, "01010101" AFTER 20 ns, "10011001" AFTER 30 ns,"00101100" AFTER 40 ns,"10000011" AFTER 50 ns;

		

 stop: PROCESS
 BEGIN
	WAIT FOR 60 ns; -- Total Simulation Time
		ASSERT FALSE
			REPORT "Simulation ended by TK at" & time'image(now)
		SEVERITY FAILURE;
	END PROCESS;
END tb;
------------------------------------------------------------------------------------------
