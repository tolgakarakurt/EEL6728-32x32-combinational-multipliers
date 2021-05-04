------------------------------------------------------------------------------------------
--Karakurt--------------------------------------------------------------------------------
------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;


entity vmul8x8s_tb is
end entity;
 
architecture tb of vmul8x8s_tb is

component vmul8x8s
  port (X: in std_logic_vector (7 downto 0);
        Y: in std_logic_vector (7 downto 0);
        --C0_32b: in std_logic;
        P: out std_logic_vector (15 downto 0)
	--P_32b: OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
	--G_32b: OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
        --C32_32b: out STD_LOGIC
        );
end component;

--Inputs
signal X_tb : std_logic_vector(7 downto 0) := (others => '0');
signal Y_tb : std_logic_vector(7 downto 0) := (others => '0');
--signal C0_32b_tb : std_logic := '0';
 
--Outputs
--signal S_32b_tb : std_logic_vector(31 downto 0);
SIGNAL P_tb : STD_LOGIC_VECTOR(15 DOWNTO 0);
--SIGNAL G_32b_tb : STD_LOGIC_VECTOR(31 DOWNTO 0);
--signal C32_32b_tb : std_logic;

BEGIN
 
-- Instantiate the Unit Under Test (UUT)
uut: vmul8x8s PORT MAP (
	X => X_tb,
	Y => Y_tb,
	--C0_32b => C0_32b_tb,
	P => P_tb
	--P_32b => P_32b_tb,
	--G_32b => G_32b_tb,
	--C32_32b => C32_32b_tb
		);

X_tb <= "00000000", "10101010" AFTER 5 ns, "01010101" AFTER 8 ns, "00110011" AFTER 12 ns, "00010001" AFTER 14 ns,"11001100" AFTER 16 ns,"11101110" AFTER 22 ns,"10001000" AFTER 27 ns,"11011101" AFTER 35 ns,"00111100" AFTER 40 ns,"10011001" AFTER 50 ns;
		
Y_tb <= "00000000", "10101010" AFTER 5 ns, "01010101" AFTER 8 ns, "00110011" AFTER 12 ns, "00010001" AFTER 14 ns,"11001100" AFTER 16 ns,"11101110" AFTER 22 ns,"10001000" AFTER 27 ns,"11011101" AFTER 35 ns,"00111100" AFTER 40 ns,"10011001" AFTER 50 ns;

--C0_32b_tb <= '0', '1' AFTER 10 ns, '0' AFTER 20 ns, '1' AFTER 30 ns, '0' AFTER 40 ns, '1' AFTER 50 ns;
		

 stop: PROCESS
 BEGIN
	WAIT FOR 60 ns; -- Total Simulation Time
		ASSERT FALSE
			REPORT "Simulation ended by TK at" & time'image(now)
		SEVERITY FAILURE;
	END PROCESS;
END tb;


