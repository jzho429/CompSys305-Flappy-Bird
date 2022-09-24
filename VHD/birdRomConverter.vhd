LIBRARY IEEE;
USE  IEEE.STD_LOGIC_1164.all;
--USE  IEEE.STD_LOGIC_ARITH.all;
--USE  IEEE.STD_LOGIC_UNSIGNED.all;
USE  IEEE.NUMERIC_STD.all;

ENTITY birdRomConverter IS
	PORT
	(	vSync: IN STD_LOGIC;
		currentRow, currentCol: IN STD_LOGIC_VECTOR (9 DOWNTO 0);
		startRow, startCol: IN INTEGER;
		address		: OUT STD_LOGIC_VECTOR (10 DOWNTO 0);
		birdEnabledUp : OUT STD_LOGIC;
		birdEnabledDown : OUT STD_LOGIC
	);
END birdRomConverter;

ARCHITECTURE converter OF birdRomConverter is
	SIGNAL temprow : INTEGER;
	SIGNAL tempcol : INTEGER;
	SIGNAL pixrowInt: INTEGER;
	SIGNAL pixcolInt: INTEGER;
	SIGNAL birdUp: STD_LOGIC := '0';
BEGIN
PROCESS(currentRow, currentCol)
BEGIN
	pixrowInt <= to_integer(unsigned(currentRow));
	pixcolInt <= to_integer(unsigned(currentCol));
	
	IF (startRow <= pixrowInt and pixrowInt < startRow + 45) and (startCol <= pixcolInt and pixcolInt < startCol + 45) then
		birdEnabledUp <= '1';
		birdEnabledDown <= '0';
	ELSE
		birdEnabledUp <= '0';
		birdEnabledDown <= '0';
	END IF;
	
	temprow <= abs(pixrowInt - startRow);
	tempcol <= abs(pixcolInt - startCol);
	
	address <= std_logic_vector(to_unsigned(temprow * 45 + tempcol+1, 11));
END PROCESS;
END converter;