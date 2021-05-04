------------------------------------------------------------------------------------------
--Karakurt--------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
------------------------------------------------------------------------------------------
entity vmul32x32p is
	port ( 	X: in STD_LOGIC_VECTOR (31 downto 0);
		Y: in STD_LOGIC_VECTOR (31 downto 0);
		P: out STD_LOGIC_VECTOR (63 downto 0) );
	end vmul32x32p;
------------------------------------------------------------------------------------------
architecture vmul32x32p_arch of vmul32x32p is
	function MAJ (I1, I2, I3: STD_LOGIC) return STD_LOGIC is
	begin
	return ((I1 and I2) or (I1 and I3) or (I2 and I3));
	end MAJ;

begin
	process (X, Y)

	type array32x32 is array (0 to 31) of STD_LOGIC_VECTOR (31 downto 0);
	variable PC: array32x32; -- product component bits
	variable PCS: array32x32; -- full-adder sum bits
	variable PCC: array32x32; -- full-adder carry output bits
	variable RAS, RAC: STD_LOGIC_VECTOR (31 downto 0); -- ripple adder sum
	
	begin -- and carry bits
	for i in 0 to 31 loop for j in 0 to 31 loop
		PC(i)(j) := Y(i) and X(j); -- compute product component bits
		end loop; 
	end loop;

	for j in 0 to 31 loop
		PCS(0)(j) := PC(0)(j); -- initialize first-row "virtual"
	PCC(0)(j) := '0'; -- adders (not shown in figure)
	end loop;
	for i in 1 to 31 loop -- do all full adders except last row
		for j in 0 to 30 loop
	PCS(i)(j) := PC(i)(j) xor PCS(i-1)(j+1) xor PCC(i-1)(j);
	PCC(i)(j) := MAJ(PC(i)(j), PCS(i-1)(j+1), PCC(i-1)(j));
	PCS(i)(31) := PC(i)(31); -- leftmost "virtual" adder sum output
		end loop;
	end loop;
	RAC(0) := '0';

	for i in 0 to 30 loop -- final ripple adder
		RAS(i) := PCS(31)(i+1) xor PCC(31)(i) xor RAC(i);
	RAC(i+1) := MAJ(PCS(31)(i+1), PCC(31)(i), RAC(i));
	end loop;

	for i in 0 to 31 loop
		P(i) <= PCS(i)(0); -- first 8 product bits from full-adder sums
	end loop;

	for i in 32 to 62 loop
		P(i) <= RAS(i-32); -- next 7 bits from ripple-adder sums
	end loop;
		P(63) <= RAC(31); -- last bit from ripple-adder carry
	end process;
end vmul32x32p_arch;
