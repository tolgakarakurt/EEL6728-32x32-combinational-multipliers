------------------------------------------------------------------------------------------
--Karakurt--------------------------------------------------------------------------------
------------------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY step_cnt_32b_dp_tb IS
END ENTITY;
------------------------------------------------------------------------------------------ 
ARCHITECTURE tb OF step_cnt_32b_dp_tb IS
 
-- Component Declaration for the Unit Under Test (UUT)
------------------------------------------------------------------------------------------ 
COMPONENT step_cnt_32b_dp
	PORT(clk : IN STD_LOGIC;
             op  : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
	     zI  : OUT STD_LOGIC
            );
END COMPONENT;
------------------------------------------------------------------------------------------ 
--Inputs
SIGNAL clk_tb : STD_LOGIC := '0';
SIGNAL op_tb  : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0000000";
 
 
--Outputs
SIGNAL zI_tb   : STD_LOGIC;
CONSTANT period : time := 25 ns;
 
BEGIN
 
-- Instantiate the Unit Under Test (UUT)
uut: step_cnt_32b_dp       
			PORT MAP (clk => clk_tb,
				   op => op_tb,
				   zI => zI_tb
				  );
			clk_tb <= NOT clk_tb after period/2;
	  	
			op_tb <= "1101010", "0010101" AFTER 250 ns, "0010000" AFTER 1050 ns, "1101001" AFTER 1350 ns; 			
			--op_tb  <= "0000000", "1111111" AFTER 3 ns, "1110001" AFTER 6 ns, "0100001" AFTER 9 ns, "0110011" AFTER 12 ns, "1000101" AFTER 15 ns, "0011001" AFTER 19 ns, "0011100" AFTER 22 ns, "0111001" AFTER 26 ns, "0101101" AFTER 29 ns, "0010001" AFTER 31 ns, "1110111" AFTER 35 ns, "1010101" AFTER 39 ns, "1011001" AFTER 40 ns, "1010111" AFTER 45 ns, "1111101" AFTER 50 ns;
		


		

 stop: PROCESS
 BEGIN
	WAIT FOR 1600 ns; -- Total Simulation Time
		ASSERT FALSE
			REPORT "Simulation ended by TK at" & time'image(now)
		SEVERITY FAILURE;
	END PROCESS;
END tb;
------------------------------------------------------------------------------------------
