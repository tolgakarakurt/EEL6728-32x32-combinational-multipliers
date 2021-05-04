------------------------------------------------------------------------------------------
--Karakurt--------------------------------------------------------------------------------
------------------------------------------------------------------------------------------

-- cntu the control unit -- by app
library IEEE ;
use IEEE.std_logic_1164.all ;

ENTITY cntu IS -- the control unit by app
	PORT ( clk: IN STD_LOGIC;
	       rst: IN STD_LOGIC;
	       st : IN STD_LOGIC;
	       zi : IN STD_LOGIC;
	       op : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	      rdy : OUT STD_LOGIC
	     );
END cntu ;
------------------------------------------------------------------------------------------
ARCHITECTURE behv OF cntu IS
	-- TYPE states IS ( SI, SM, SF ) ;
	-- SIGNAL stt, nxtSt : states := SI ;

	SIGNAL stt   : STD_LOGIC_VECTOR(1 DOWNTO 0) ;
	SIGNAL nxtSt : STD_LOGIC_VECTOR(1 DOWNTO 0) ;

	-- we can use a "hard" encoding of states
	CONSTANT SI : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00" ;
	CONSTANT SM : STD_LOGIC_VECTOR(1 DOWNTO 0) := "01" ;
	CONSTANT SF : STD_LOGIC_VECTOR(1 DOWNTO 0) := "10" ;

	-- Internal op-code signals and related constants
	
	SIGNAL Aop : STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL Qop : STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL Sop : STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL Dop : STD_LOGIC;

	CONSTANT loadD : STD_LOGIC := '1' ;
	CONSTANT nopD  : STD_LOGIC := '0' ;
	CONSTANT nop   : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00" ;
	
	CONSTANT ldAshr: STD_LOGIC_VECTOR(1 DOWNTO 0) := "01";
	CONSTANT shrQ  : STD_LOGIC_VECTOR(1 DOWNTO 0) := "01";
	CONSTANT cnt   : STD_LOGIC_VECTOR(1 DOWNTO 0) := "01";

	CONSTANT reset : STD_LOGIC_VECTOR(1 DOWNTO 0) := "10";
	CONSTANT load  : STD_LOGIC_VECTOR(1 DOWNTO 0) := "10";

BEGIN
-- to synthesize edge-triggered flip-flops
-- with asynchronous reset when rst = 0
------------------------------------------------------------------------------------------
clkd: PROCESS ( clk, rst)
	BEGIN
		IF (rst = '0') THEN
			stt <= SI; --"00"
	
		ELSIF ( clk'EVENT AND clk = '1' AND clk'LAST_VALUE = '0' ) THEN
			stt <= nxtSt; 
		END IF ;
END PROCESS clkd ;
------------------------------------------------------------------------------------------
-- the stm process describes the transitions between states
-- and the output signals
stm: PROCESS ( stt, st, zi )
	BEGIN
	-- default assignments
		nxtSt <= stt ;
		Dop <= nopD ;
		Aop <= nop ;
		Qop <= nop ;
		Sop <= nop ;
		rdy <= '0' ;
	-- state transitions and output signals

	CASE stt IS
		WHEN SI =>  --"00"

			rdy <= '0';
			Dop <= loadD; --'1'
			Aop <= reset; --"10"
			Qop <= load;  --"10"
			Sop <= reset; --"10"

				IF (st = '1') THEN 
					nxtSt <= SM; --"01"
				ELSIF(st = '0') THEN
					nxtSt <= SI; --"00"
				END IF;

		WHEN SM =>  --"01"

			Aop <= ldAshr; --"01"
			Qop <= shrQ;   --"01"
			Sop <= cnt;    --"01"
				
				IF (zi = '1') THEN 
					nxtSt <= SF; --"10"
				ELSIF (zi = '0') THEN
					nxtSt <= SM;
				END IF;

		WHEN OTHERS => --- when SF --"10"

			rdy <= '1'; 

				IF (st = '0') THEN 
					nxtSt <= SI; --"00"
				ELSIF (st = '1') THEN 
					nxtSt <= SF;
				END IF;
	END CASE;
END PROCESS stm;
------------------------------------------------------------------------------------------
			----------/_SI_/--------	-----------/_SM_/--------	---------/_SF_/----------
			--myprog-1.	--onpaper-1.	--myprog-2. 	--onpaper-2. 	--myprog-3.	--onpaper-3.
op(6) <= Dop ;     	--'1';		--'1';		--'0';		--'0';		--'0';		--'0';
op(5 DOWNTO 4) <= Aop ; --"10";		--"10";		--"01";		--"11";		--"00";		--"01";
op(3 DOWNTO 2) <= Qop ;	--"10";		--"10";		--"01";		--"01";		--"00";		--"00";
op(1 DOWNTO 0) <= Sop ;	--"10";		--"01";		--"01";		--"10";		--"00";		--"00"

END behv;
------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
