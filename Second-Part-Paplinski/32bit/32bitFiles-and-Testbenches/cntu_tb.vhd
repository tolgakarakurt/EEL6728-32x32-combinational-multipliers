------------------------------------------------------------------------------------------
--Karakurt--------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY cntu_tb IS
END ENTITY;
 
ARCHITECTURE tb OF cntu_tb IS
 
-- Component Declaration for the Unit Under Test (UUT)
------------------------------------------------------------------------------------------ 
COMPONENT cntu

	PORT ( clk: IN STD_LOGIC ;
	       rst: IN STD_LOGIC ;
	       st : IN STD_LOGIC ;
	       zi : IN STD_LOGIC ;
	       op : OUT STD_LOGIC_VECTOR(6 DOWNTO 0) ;
	      rdy : OUT STD_LOGIC
	     );


------------------------------------------------------------------------------------------

END COMPONENT;
 
--Inputs
SIGNAL clk_tb : STD_LOGIC := '1';
SIGNAL rst_tb : STD_LOGIC := '0';
SIGNAL st_tb  : STD_LOGIC := '0'; 
SIGNAL zi_tb  : STD_LOGIC := '0';

--Outputs
SIGNAL op_tb  : STD_LOGIC_VECTOR(6 DOWNTO 0); --:= "0000000";
SIGNAL rdy_tb : STD_LOGIC := '0';
--SIGNAL nxtSt_tb  : STD_LOGIC_VECTOR(1 DOWNTO 0);
--SIGNAL stt_tb    : STD_LOGIC_VECTOR(1 DOWNTO 0);

CONSTANT period : time := 100 ns;
 
BEGIN
 
-- Instantiate the Unit Under Test (UUT)
uut: cntu       
			PORT MAP (clk  => clk_tb,
				  rst  => rst_tb,
				  st   => st_tb,
				  zi   => zi_tb,
				  op   => op_tb,
			          rdy  => rdy_tb
					--nxtSt => nxtSt_tb,
					--stt   => stt_tb
				  );

			clk_tb <= NOT clk_tb after period/2;
	  	
			rst_tb  <= '1', '0' AFTER 20 ns, '1' AFTER 80 ns;
			st_tb   <= '0', '1' AFTER 170 ns, '0' AFTER 670 ns;--'1' AFTER 42 ns, '1' AFTER 60 ns, '0' AFTER 75 ns; 

			zi_tb   <= '0', '1' AFTER 430 ns, '0' AFTER 530 ns;--'0' AFTER 40 ns, '1' AFTER 60 ns, '0' AFTER 75 ns;  
			

		

 stop: PROCESS
 BEGIN
	WAIT FOR 800 ns; -- Total Simulation Time
		ASSERT FALSE
			REPORT "Simulation ended by TK at" & time'image(now)
		SEVERITY FAILURE;
	END PROCESS;
END tb;
------------------------------------------------------------------------------------------
