------------------------------------------------------------------------------------------
--Karakurt--------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
------------------------------------------------------------------------------------------
entity vmul8x8p is
	port ( 	X: in STD_LOGIC_VECTOR (7 downto 0);
		Y: in STD_LOGIC_VECTOR (7 downto 0);
		P: out STD_LOGIC_VECTOR (15 downto 0) );
	end vmul8x8p;
------------------------------------------------------------------------------------------
architecture vmul8x8p_arch of vmul8x8p is
	function MAJ (I1, I2, I3: STD_LOGIC) return STD_LOGIC is
	begin
	return ((I1 and I2) or (I1 and I3) or (I2 and I3));
	end MAJ;

begin
	process (X, Y)

	type array8x8 is array (0 to 7) of STD_LOGIC_VECTOR (7 downto 0);
	variable PC: array8x8; -- product component bits
	variable PCS: array8x8; -- full-adder sum bits
	variable PCC: array8x8; -- full-adder carry output bits
	variable RAS, RAC: STD_LOGIC_VECTOR (7 downto 0); -- ripple adder sum
	
	begin -- and carry bits
	for i in 0 to 7 loop for j in 0 to 7 loop
		PC(i)(j) := Y(i) and X(j); -- compute product component bits
		end loop; 
	end loop;

	for j in 0 to 7 loop
		PCS(0)(j) := PC(0)(j); -- initialize first-row "virtual"
	PCC(0)(j) := '0'; -- adders (not shown in figure)
	end loop;
	for i in 1 to 7 loop -- do all full adders except last row
		for j in 0 to 6 loop
	PCS(i)(j) := PC(i)(j) xor PCS(i-1)(j+1) xor PCC(i-1)(j);
	PCC(i)(j) := MAJ(PC(i)(j), PCS(i-1)(j+1), PCC(i-1)(j));
	PCS(i)(7) := PC(i)(7); -- leftmost "virtual" adder sum output
		end loop;
	end loop;
	RAC(0) := '0';

	for i in 0 to 6 loop -- final ripple adder
		RAS(i) := PCS(7)(i+1) xor PCC(7)(i) xor RAC(i);
	RAC(i+1) := MAJ(PCS(7)(i+1), PCC(7)(i), RAC(i));
	end loop;

	for i in 0 to 7 loop
		P(i) <= PCS(i)(0); -- first 8 product bits from full-adder sums
	end loop;

	for i in 8 to 14 loop
		P(i) <= RAS(i-8); -- next 7 bits from ripple-adder sums
	end loop;
		P(15) <= RAC(7); -- last bit from ripple-adder carry
	end process;
end vmul8x8p_arch;
