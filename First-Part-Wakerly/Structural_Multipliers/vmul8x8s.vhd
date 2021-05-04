------------------------------------------------------------------------------------------
--Karakurt--------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
------------------------------------------------------------------------------------------
entity vmul8x8s is
	port ( 	X: in STD_LOGIC_VECTOR (7 downto 0);
		Y: in STD_LOGIC_VECTOR (7 downto 0);
		P: out STD_LOGIC_VECTOR (15 downto 0) );
	end vmul8x8s;
------------------------------------------------------------------------------------------

architecture vmul8x8s_arch of vmul8x8s is
	component AND2
		port( I0, I1: in STD_LOGIC;
			   O: out STD_LOGIC );
	end component;

	component XOR3
		port( I0, I1, I2: in STD_LOGIC;
		   	       O: out STD_LOGIC );
	end component;

	component MAJ -- Majority function, O = I0*I1 + I0*I2 + I1*I2
		port( I0, I1, I2: in STD_LOGIC;
		  	       O: out STD_LOGIC );
	end component;

type array8x8 is array (0 to 7) of STD_LOGIC_VECTOR (7 downto 0);
signal PC: array8x8; -- product-component bits
signal PCS: array8x8; -- full-adder sum bits
signal PCC: array8x8; -- full-adder carry output bits
signal RAS, RAC: STD_LOGIC_VECTOR (7 downto 0); -- sum, carry

begin
	g1: for i in 0 to 7 generate -- product-component bits
		g2: for j in 0 to 7 generate
			U1: AND2 port map (Y(i), X(j), PC(i)(j));
		end generate;
	end generate;

	g3: for j in 0 to 7 generate
		PCS(0)(j) <= PC(0)(j); -- initialize first-row "virtual" adders
		PCC(0)(j) <= '0';
	end generate;

	g4: for i in 1 to 7 generate -- do full adders except the last row
		g5: for j in 0 to 6 generate
			U2: XOR3 port map (PC(i)(j),PCS(i-1)(j+1),PCC(i-1)(j),PCS(i)(j));
			U3: MAJ port map (PC(i)(j),PCS(i-1)(j+1),PCC(i-1)(j),PCC(i)(j));
			PCS(i)(7) <= PC(i)(7); -- leftmost "virtual" adder sum output
		end generate;
	end generate;

RAC(0) <= '0';
	g6: for i in 0 to 6 generate -- final ripple adder
		U7: XOR3 port map (PCS(7)(i+1), PCC(7)(i), RAC(i), RAS(i));
		U3: MAJ port map (PCS(7)(i+1), PCC(7)(i), RAC(i), RAC(i+1));
		end generate;

	g7: for i in 0 to 7 generate
		P(i) <= PCS(i)(0); -- get first 8 product bits from full-adder sums
	end generate;

	g8: for i in 8 to 14 generate
		P(i) <= RAS(i-8); -- get next 7 bits from ripple-adder sums
	end generate;

P(15) <= RAC(7); -- get last bit from ripple-adder carry

end vmul8x8s_arch;
