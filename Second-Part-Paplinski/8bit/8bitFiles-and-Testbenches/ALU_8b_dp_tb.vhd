------------------------------------------------------------------------------------------
--Karakurt--------------------------------------------------------------------------------
------------------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL; 

ENTITY ALU_8b_dp_tb IS
END ENTITY;
 
ARCHITECTURE tb OF ALU_8b_dp_tb IS
 
-- Component Declaration for the Unit Under Test (UUT)
------------------------------------------------------------------------------------------
COMPONENT ALU_8b_dp
	PORT(A  : IN SIGNED(7 DOWNTO 0);
	     B  : IN SIGNED(7 DOWNTO 0); 
             op : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
	     F  : OUT SIGNED(7 DOWNTO 0)
             );
END COMPONENT;
------------------------------------------------------------------------------------------
--Inputs
SIGNAL A_tb   : SIGNED(7 DOWNTO 0) := "00000000";
SIGNAL B_tb   : SIGNED(7 DOWNTO 0) := "00000000";
SIGNAL op_tb  : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
 
 
--Outputs
SIGNAL F_tb   : SIGNED(7 DOWNTO 0);
--CONSTANT period : time := 2 ns;
 
BEGIN
 
-- Instantiate the Unit Under Test (UUT)
uut: ALU_8b_dp       
			PORT MAP ( A  => A_tb,
				   B  => B_tb,
				   op => op_tb,
				   F => F_tb
				  );
			--clk_tb <= NOT clk_tb after period/2;
	  	        A_tb   <= "00000000", "11111111" AFTER 8 ns, "01000101" AFTER 12 ns, "11100101" AFTER 25 ns, "01100111" AFTER 34 ns, "10001101" AFTER 45 ns;-- "00111001" AFTER 19 ns, "00111100" AFTER 22 ns, "01111001" AFTER 26 ns, "01011101" AFTER 29 ns, "00101001" AFTER 31 ns, "11110111" AFTER 35 ns, "10101101" AFTER 39 ns, "10111001" AFTER 40 ns, "10101111" AFTER 45 ns, "11111101" AFTER 50 ns;
			B_tb   <= "00000000", "11110111" AFTER 8 ns, "11100001" AFTER 12 ns, "01000001" AFTER 25 ns, "01100011" AFTER 34 ns, "10000101" AFTER 45 ns;-- "00110001" AFTER 19 ns, "00110100" AFTER 22 ns, "01110001" AFTER 26 ns, "01010101" AFTER 29 ns, "00100001" AFTER 31 ns, "11100111" AFTER 35 ns, "10100101" AFTER 39 ns, "10110001" AFTER 40 ns, "10100111" AFTER 45 ns, "11101101" AFTER 50 ns;
			op_tb  <= "00", "11" AFTER 8 ns, "01" AFTER 12 ns, "10" AFTER 25 ns, "11" AFTER 34 ns, "01" AFTER 45 ns; --"01" AFTER 19 ns, "00" AFTER 22 ns, "01" AFTER 26 ns, "10" AFTER 29 ns, "01" AFTER 31 ns, "11" AFTER 35 ns, "10" AFTER 39 ns, "01" AFTER 40 ns, "11" AFTER 45 ns, "10" AFTER 50 ns;
		


		

 stop: PROCESS
 BEGIN
	WAIT FOR 60 ns; -- Total Simulation Time
		ASSERT FALSE
			REPORT "Simulation ended by TK at" & time'image(now)
		SEVERITY FAILURE;
	END PROCESS;
END tb;
------------------------------------------------------------------------------------------
