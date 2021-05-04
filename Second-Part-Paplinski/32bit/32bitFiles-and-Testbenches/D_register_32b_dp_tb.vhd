------------------------------------------------------------------------------------------
--Karakurt--------------------------------------------------------------------------------
------------------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY D_register_32b_dp_tb IS
END ENTITY;
 
ARCHITECTURE tb OF D_register_32b_dp_tb IS
 
-- Component Declaration for the Unit Under Test (UUT)
------------------------------------------------------------------------------------------ 
COMPONENT D_register_32b_dp
	PORT(clk : IN STD_LOGIC;
             op  : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
	     DD  : IN STD_LOGIC_VECTOR(31 DOWNTO 0); 
             D   : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
            );
END COMPONENT;
------------------------------------------------------------------------------------------ 
--Inputs
SIGNAL clk_tb : STD_LOGIC := '0';
SIGNAL op_tb  : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0000000";
SIGNAL DD_tb  : STD_LOGIC_VECTOR(31 DOWNTO 0) := x"0000_0000"; 
 
--Outputs
SIGNAL D_tb   : STD_LOGIC_VECTOR(31 DOWNTO 0);
CONSTANT period : time := 2 ns;
 
BEGIN
 
-- Instantiate the Unit Under Test (UUT)
uut: D_register_32b_dp       
			PORT MAP (clk => clk_tb,
				   op => op_tb,
				   DD => DD_tb,
				    D => D_tb
				  );
			clk_tb <= NOT clk_tb after period/2;
	  	
			op_tb <= "0000000", "1111111" AFTER 10 ns, "1010101" AFTER 20 ns, "0101010" AFTER 30 ns,"1100011" AFTER 40 ns,"1011101" AFTER 50 ns;
		
			DD_tb <= x"0000_0000", x"FFFF_FFFF" AFTER 10 ns, x"5555_5555" AFTER 20 ns, x"8888_8888" AFTER 30 ns, x"2222_BBBB" AFTER 40 ns, x"8888_3333" AFTER 50 ns;

		

 stop: PROCESS
 BEGIN
	WAIT FOR 60 ns; -- Total Simulation Time
		ASSERT FALSE
			REPORT "Simulation ended by TK at" & time'image(now)
		SEVERITY FAILURE;
	END PROCESS;
END tb;
------------------------------------------------------------------------------------------
