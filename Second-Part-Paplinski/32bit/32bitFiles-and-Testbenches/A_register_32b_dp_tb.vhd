------------------------------------------------------------------------------------------
--Karakurt--------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY A_register_32b_dp_tb IS
END ENTITY;
 
ARCHITECTURE tb OF A_register_32b_dp_tb IS
 
-- Component Declaration for the Unit Under Test (UUT)
------------------------------------------------------------------------------------------ 
COMPONENT A_register_32b_dp
	PORT(clk : IN STD_LOGIC;
             op  : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
	     F   : IN STD_LOGIC_VECTOR(31 DOWNTO 0); 
             A   : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
            );
END COMPONENT;
------------------------------------------------------------------------------------------ 
--Inputs
SIGNAL clk_tb : STD_LOGIC := '0';
SIGNAL op_tb  : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0000000";
SIGNAL F_tb   : STD_LOGIC_VECTOR(31 DOWNTO 0) := x"0000_0000"; 
 
--Outputs
SIGNAL A_tb   : STD_LOGIC_VECTOR(31 DOWNTO 0);
CONSTANT period : time := 6 ns;
 
BEGIN
 
-- Instantiate the Unit Under Test (UUT)
uut: A_register_32b_dp       
			PORT MAP (clk => clk_tb,
				   op => op_tb,
				    F => F_tb,
				    A => A_tb
				  );
			clk_tb <= NOT clk_tb after period/2;
	  	
			op_tb  <= "0000000", "1111111" AFTER 50 ns, "1010101" AFTER 100 ns, "0101010" AFTER 150 ns, "0010011" AFTER 200 ns, "1011100" AFTER 250 ns;
		
			F_tb   <= x"0000_0000", x"FFFF_FFFF" AFTER 50 ns, x"5555_5555" AFTER 100 ns, x"9999_9999" AFTER 150 ns, x"3333_3333" AFTER 200 ns, x"8888_8888" AFTER 250 ns;

		

 stop: PROCESS
 BEGIN
	WAIT FOR 300 ns; -- Total Simulation Time
		ASSERT FALSE
			REPORT "Simulation ended by TK at" & time'image(now)
		SEVERITY FAILURE;
	END PROCESS;
END tb;
------------------------------------------------------------------------------------------
