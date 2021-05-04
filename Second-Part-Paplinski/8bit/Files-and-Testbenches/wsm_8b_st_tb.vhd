------------------------------------------------------------------------------------------
--Karakurt--------------------------------------------------------------------------------
------------------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.NUMERIC_STD.all;

ENTITY wsm_8b_st_tb IS
END ENTITY;
------------------------------------------------------------------------------------------ 
ARCHITECTURE tb OF wsm_8b_st_tb IS
 
-- Component Declaration for the Unit Under Test (UUT)
 
COMPONENT wsm_8b_st
	PORT ( 	clk_w: IN  STD_LOGIC;
		qq_w : IN  STD_LOGIC_VECTOR (7 downto 0);
		dd_w : IN  STD_LOGIC_VECTOR (7 downto 0);

		rst_w: IN  STD_LOGIC;
		st_w : IN  STD_LOGIC;
		rdy_w: OUT STD_LOGIC;
		aq_w : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);

		op_w : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
		zI_w : OUT STD_LOGIC
	
             );
END COMPONENT;
 
--Inputs
SIGNAL clk_w_tb : STD_LOGIC := '0';
SIGNAL qq_w_tb  : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000";
SIGNAL dd_w_tb  : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000";

SIGNAL rst_w_tb : STD_LOGIC;
SIGNAL st_w_tb  : STD_LOGIC;
SIGNAL rdy_w_tb : STD_LOGIC;
SIGNAL aq_w_tb  : STD_LOGIC_VECTOR(15 DOWNTO 0) := "0000000000000000";

SIGNAL op_w_tb  : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0000000";
SIGNAL zI_w_tb  : STD_LOGIC;

 
--Outputs


CONSTANT period : time := 100 ns;
 
BEGIN
 
-- Instantiate the Unit Under Test (UUT)
uut: wsm_8b_st       
			PORT MAP (clk_w => clk_w_tb,
				   qq_w => qq_w_tb,
				   dd_w => dd_w_tb,
				   
				  rst_w => rst_w_tb,
				   st_w => st_w_tb,
				  rdy_w => rdy_w_tb,
				   aq_w => aq_w_tb,

				   op_w => op_w_tb,
				   zI_w => zI_w_tb
				 
				  );

			clk_w_tb <= NOT clk_w_tb after period/2;
	  	
			qq_w_tb <= x"AD", x"00" AFTER 700 ns; 
			dd_w_tb <= x"9B", x"00" AFTER 500 ns; 
			rst_w_tb <= '0', '1' AFTER 100 ns; 
			st_w_tb  <= '0', '1' AFTER 200 ns, '0' AFTER 1300 ns;
		

 stop: PROCESS
 BEGIN
	WAIT FOR 1600 ns; -- Total Simulation Time
		ASSERT FALSE
			REPORT "Simulation ended by TK at" & time'image(now)
		SEVERITY FAILURE;
	END PROCESS;
END tb;
------------------------------------------------------------------------------------------
