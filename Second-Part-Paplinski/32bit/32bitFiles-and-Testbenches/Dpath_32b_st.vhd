------------------------------------------------------------------------------------------
--Karakurt--------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.all;
---------------------------------------------------------------------------------------------------

ENTITY Dpath_32b_st is

GENERIC(m : INTEGER := 32);

	PORT ( 	clk: IN  STD_LOGIC;
		qq : IN  STD_LOGIC_VECTOR (m-1 downto 0);
		dd : IN  STD_LOGIC_VECTOR (m-1 downto 0);
		op : IN  STD_LOGIC_VECTOR (6 DOWNTO 0);
		zI : OUT STD_LOGIC;
		aq : OUT STD_LOGIC_VECTOR(((2*m)-1) DOWNTO 0)
             );		
	END Dpath_32b_st;
----------------------------------------------------------------------------------------------------

ARCHITECTURE structural OF Dpath_32b_st IS

--DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD	
        COMPONENT D_register_32b_dp					  		          	 --D
	PORT(clk : IN  STD_LOGIC;						          	 --D	
             op  : IN  STD_LOGIC_VECTOR(6 DOWNTO 0);					  	 --D
	     DD  : IN  STD_LOGIC_VECTOR(m-1 DOWNTO 0); 					  	 --D
             D   : OUT STD_LOGIC_VECTOR(m-1 DOWNTO 0)					  	 --D
            );										  	 --D
	END COMPONENT;									  	 --D
--DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD

--AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
	COMPONENT A_register_32b_dp								  	 --A
	PORT(clk : IN  STD_LOGIC;							  	 --A
             op  : IN  STD_LOGIC_VECTOR(6 DOWNTO 0);					  	 --A
	     F   : IN  STD_LOGIC_VECTOR(m-1 DOWNTO 0); 					  	 --A
             A   : OUT STD_LOGIC_VECTOR(m-1 DOWNTO 0)					  	 --A
            );										  	 --A
	END COMPONENT;									  	 --A
											  	 --A
											  	 --A
--AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA

--QQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQ
	COMPONENT Q_register_32b_dp 							  	 --Q
	PORT(clk : IN  STD_LOGIC;							  	 --Q
             op  : IN  STD_LOGIC_VECTOR(6 DOWNTO 0);					  	 --Q
	     QQ  : IN  STD_LOGIC_VECTOR(m-1 DOWNTO 0); 					  	 --Q
             f0  : IN  STD_LOGIC;							  	 --Q
	     q_1 : IN  STD_LOGIC := '0';						  	 --Q
             --Q   : OUT STD_LOGIC_VECTOR(m-1 DOWNTO 0);					  	 --Q
	     Qn_1: OUT STD_LOGIC_VECTOR(m DOWNTO 0);
	     q0_1: OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
	     					  	 --Q
            );										  	 --Q
	END COMPONENT;									  	 --Q
--QQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQ

-----ALU_ALU_ALU_ALU_ALU_ALU_ALU_ALU_ALU_ALU_ALU_ALU_ALU_ALU_ALU_ALU_ALU_ALU_ALU_ALU_ALU_ALU_ALU_ALU
	COMPONENT ALU_32b_dp								       --ALU
	PORT(A  : IN  SIGNED(m-1 DOWNTO 0);						       --ALU	
	     B  : IN  SIGNED(m-1 DOWNTO 0); 						       --ALU
             op : IN  STD_LOGIC_VECTOR(1 DOWNTO 0);					       --ALU	
	     F  : OUT SIGNED(m-1 DOWNTO 0)						       --ALU
            );										       --ALU
	END COMPONENT;									       --ALU
-----ALU_ALU_ALU_ALU_ALU_ALU_ALU_ALU_ALU_ALU_ALU_ALU_ALU_ALU_ALU_ALU_ALU_ALU_ALU_ALU_ALU_ALU_ALU_ALU


--step_cnt--step_cnt--step_cnt--step_cnt--step_cnt--step_cnt--step_cnt--step_cnt--step_cnt--step_cnt
	COMPONENT step_cnt_32b_dp						          --step_cnt
	PORT(clk : IN STD_LOGIC;							  --step_cnt
             op  : IN STD_LOGIC_VECTOR(6 DOWNTO 0);					  --step_cnt
	     zI  : OUT STD_LOGIC							  --step_cnt
            );										  --step_cnt
	END COMPONENT;									  --step_cnt
--step_cnt--step_cnt--step_cnt--step_cnt--step_cnt--step_cnt--step_cnt--step_cnt--step_cnt--step_cnt

SIGNAL   D_s  : STD_LOGIC_VECTOR(m-1 DOWNTO 0):= x"0000_0000";
SIGNAL   A_s  : STD_LOGIC_VECTOR(m-1 DOWNTO 0):= x"0000_0000";
SIGNAL   Q_s  : STD_LOGIC_VECTOR(m DOWNTO 0):= "000000000000000000000000000000000";
CONSTANT q_1_s: STD_LOGIC:= '0';
SIGNAL  q0_1_s: STD_LOGIC_VECTOR(1 DOWNTO 0):= "00";
SIGNAL   F_s  : SIGNED(m-1 DOWNTO 0):= x"0000_0000"; 
SIGNAL   zI_s : STD_LOGIC:= '0';

BEGIN
-------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------

 U1   : D_register_32b_dp  PORT MAP(clk, op, dd, D_s); 	--D_s 
		         	
 U2   : Q_register_32b_dp  PORT MAP(clk, op, qq, F_s(0), q_1_s, Q_s, q0_1_s);

 U3   : A_register_32b_dp  PORT MAP(clk, op, STD_LOGIC_VECTOR(F_s), A_s);
 
 U4   : ALU_32b_dp         PORT MAP(SIGNED(A_s), SIGNED(D_s), q0_1_s, F_s);	
 U5   : step_cnt_32b_dp    PORT MAP(clk, op, zI_s);
-------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------

aq <= A_s & Q_s(m DOWNTO 1);  
zI <= zI_s;
-------------------------------------------------------------------------------------------------------------------------  
-------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------
END ARCHITECTURE structural;
