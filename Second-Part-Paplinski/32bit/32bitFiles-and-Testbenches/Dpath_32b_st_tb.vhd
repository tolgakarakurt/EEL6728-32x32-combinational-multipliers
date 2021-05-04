------------------------------------------------------------------------------------------
--U76553044-------------------------------------------------------------------------------
--Karakurt--------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.NUMERIC_STD.all;

ENTITY Dpath_32b_st_tb IS
END ENTITY;
------------------------------------------------------------------------------------------ 
ARCHITECTURE tb OF Dpath_32b_st_tb IS
 
-- Component Declaration for the Unit Under Test (UUT)
------------------------------------------------------------------------------------------ 
COMPONENT Dpath_32b_st
	PORT ( 	clk: IN  STD_LOGIC;
		qq : IN  STD_LOGIC_VECTOR (31 downto 0);
		dd : IN  STD_LOGIC_VECTOR (31 downto 0);
		op : IN  STD_LOGIC_VECTOR (6 DOWNTO 0);
		zI : OUT STD_LOGIC;
		aq : OUT STD_LOGIC_VECTOR (63 DOWNTO 0)
		);
END COMPONENT;
------------------------------------------------------------------------------------------ 
--Inputs
SIGNAL clk_tb : STD_LOGIC := '0';
SIGNAL qq_tb  : STD_LOGIC_VECTOR(31 DOWNTO 0) := x"0000_0000";
SIGNAL dd_tb  : STD_LOGIC_VECTOR(31 DOWNTO 0) := x"0000_0000";
SIGNAL op_tb  : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0000000";

 
--Outputs
SIGNAL zI_tb  : STD_LOGIC;
SIGNAL aq_tb  : STD_LOGIC_VECTOR(63 DOWNTO 0);


CONSTANT period : time := 25 ns;
------------------------------------------------------------------------------------------ 
BEGIN
 
-- Instantiate the Unit Under Test (UUT)
uut: Dpath_32b_st       
			PORT MAP (clk => clk_tb,
				   qq => qq_tb,
				   dd => dd_tb,
				   op => op_tb,
				   zI => zI_tb,
				   aq => aq_tb

				  );

			clk_tb <= NOT clk_tb after period/2;
	  	
			qq_tb <= x"6565_6565", x"0000_0000" AFTER 700 ns; 
		
			dd_tb <= x"5353_5353", x"0000_0000" AFTER 500 ns; 
			
			op_tb <= "1101010", "0010101" AFTER 250 ns, "0010000" AFTER 1050 ns, "1101001" AFTER 1350 ns; 

		

 stop: PROCESS
 BEGIN
	WAIT FOR 1600 ns; -- Total Simulation Time
		ASSERT FALSE
			REPORT "Simulation ended by TK at" & time'image(now)
		SEVERITY FAILURE;
	END PROCESS;
END tb;
------------------------------------------------------------------------------------------
