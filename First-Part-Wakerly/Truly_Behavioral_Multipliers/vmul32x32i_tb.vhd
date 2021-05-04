------------------------------------------------------------------------------------------
--Karakurt--------------------------------------------------------------------------------
------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
--use IEEE.std_logic_arith.all;
--USE IEEE.STD_LOGIC_UNSIGNED.all;
use ieee.numeric_std.all;
------------------------------------------------------------------------------------------
entity vmul32x32i_tb is
end entity;
 ------------------------------------------------------------------------------------------
architecture tb of vmul32x32i_tb is
------------------------------------------------------------------------------------------
component vmul32x32i
  port (X: in UNSIGNED(31 downto 0);
        Y: in UNSIGNED(31 downto 0);
        --C0_32b: in std_logic;
        P: out UNSIGNED (63 downto 0)
	--P_32b: OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
	--G_32b: OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
        --C32_32b: out STD_LOGIC
        );
end component;
------------------------------------------------------------------------------------------
--Inputs
signal X_tb : UNSIGNED(31 downto 0) := (others => '0');
signal Y_tb : UNSIGNED(31 downto 0) := (others => '0');
--signal C0_32b_tb : std_logic := '0';
 
--Outputs
--signal S_32b_tb : std_logic_vector(31 downto 0);
SIGNAL P_tb : UNSIGNED(63 DOWNTO 0);
--SIGNAL G_32b_tb : STD_LOGIC_VECTOR(31 DOWNTO 0);
--signal C32_32b_tb : std_logic;

BEGIN
 
-- Instantiate the Unit Under Test (UUT)
uut: vmul32x32i PORT MAP (
	X => X_tb,
	Y => Y_tb,
	--C0_32b => C0_32b_tb,
	P => P_tb
	--P_32b => P_32b_tb,
	--G_32b => G_32b_tb,
	--C32_32b => C32_32b_tb
		);

X_tb <=  x"0000_0000", x"FFFF_FFFF" AFTER 8 ns, x"AAAA_AAAA" AFTER 14 ns, x"8888_8888" AFTER 19 ns, x"9999_9999" AFTER 25 ns,x"EEEE_EEEE" AFTER 30 ns;
		
Y_tb <= x"0000_0000", x"FFFF_FFFF" AFTER 8 ns, x"AAAA_AAAA" AFTER 14 ns, x"8888_8888" AFTER 19 ns, x"9999_9999" AFTER 25 ns,x"EEEE_EEEE" AFTER 30 ns;
--C0_32b_tb <= '0', '1' AFTER 10 ns, '0' AFTER 20 ns, '1' AFTER 30 ns, '0' AFTER 40 ns, '1' AFTER 50 ns;
		

 stop: PROCESS
 BEGIN
	WAIT FOR 40 ns; -- Total Simulation Time
		ASSERT FALSE
			REPORT "Simulation ended by TK at" & time'image(now)
		SEVERITY FAILURE;
	END PROCESS;
END tb;

------------------------------------------------------------------------------------------
