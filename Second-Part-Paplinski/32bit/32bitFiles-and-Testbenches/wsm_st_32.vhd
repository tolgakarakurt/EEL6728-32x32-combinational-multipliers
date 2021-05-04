------------------------------------------------------------------------------------------
--Karakurt--------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.all;
---------------------------------------------------------------------------------------------------

ENTITY wsm_st_32 is

GENERIC(m : INTEGER := 32);

	PORT ( 	clk_w: IN  STD_LOGIC;
		qq_w : IN  STD_LOGIC_VECTOR (m-1 downto 0);
		dd_w : IN  STD_LOGIC_VECTOR (m-1 downto 0);

		rst_w: IN  STD_LOGIC;
		st_w : IN  STD_LOGIC;
		rdy_w: OUT STD_LOGIC;
		aq_w : OUT STD_LOGIC_VECTOR(((2*m)-1) DOWNTO 0);

		op_w : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
		zI_w : OUT STD_LOGIC
		
		
             );		
	END wsm_st_32;
----------------------------------------------------------------------------------------------------

ARCHITECTURE structural OF wsm_st_32 IS

--Dpath--Dpath--Dpath--Dpath--Dpath--Dpath--Dpath--Dpath--Dpath--Dpath--Dpath--Dpath--Dpath--Dpath--Dpath
        COMPONENT Dpath_32b_st					  		          	  --Dpath
	PORT ( 	clk: IN  STD_LOGIC;								  --Dpath
		qq : IN  STD_LOGIC_VECTOR (m-1 downto 0);					  --Dpath
		dd : IN  STD_LOGIC_VECTOR (m-1 downto 0);					  --Dpath		
		op : IN  STD_LOGIC_VECTOR (6 DOWNTO 0);						  --Dpath	
		zI : OUT STD_LOGIC;								  --Dpath
		aq : OUT STD_LOGIC_VECTOR(((2*m)-1) DOWNTO 0)					  --Dpath
		);					 					  --Dpath					  	
	END COMPONENT;									  	  --Dpath
--Dpath--Dpath--Dpath--Dpath--Dpath--Dpath--Dpath--Dpath--Dpath--Dpath--Dpath--Dpath--Dpath--Dpath--Dpath

------cntu--cntu--cntu--cntu--cntu--cntu--cntu--cntu--cntu--cntu--cntu--cntu--cntu--cntu--cntu--cntu--cntu
COMPONENT cntu					  		          	  		    --cntu
	PORT ( clk: IN STD_LOGIC;								    --cntu
	       rst: IN STD_LOGIC;								    --cntu
	       st : IN STD_LOGIC;								    --cntu
	       zi : IN STD_LOGIC;								    --cntu
	       op : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);						    --cntu
	    --stt : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);						    --cntu
	      rdy : OUT STD_LOGIC								    --cntu
	     );					  						    --cntu
	END COMPONENT;										    --cntu
------cntu--cntu--cntu--cntu--cntu--cntu--cntu--cntu--cntu--cntu--cntu--cntu--cntu--cntu--cntu--cntu--cntu

BEGIN

U1   : cntu   	 	  PORT MAP(clk_w, rst_w, st_w, zI_w, op_w, rdy_w);
U2   : Dpath_32b_st       PORT MAP(clk_w, qq_w,  dd_w, op_w, zI_w, aq_w); 	 

END ARCHITECTURE structural;
		
