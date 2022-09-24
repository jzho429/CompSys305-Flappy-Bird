LIBRARY IEEE;
USE  IEEE.STD_LOGIC_1164.all;
USE  IEEE.NUMERIC_STD.all;

ENTITY cursorConverter IS
	PORT
	(
        currentRow, currentCol: IN STD_LOGIC_VECTOR(9 DOWNTO 0);
        startRow, startCol: IN STD_LOGIC_VECTOR(9 DOWNTO 0);
        cursorEnabled: OUT STD_LOGIC;
        address: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        state: IN STD_LOGIC_VECTOR(2 DOWNTO 0)
	);

END cursorConverter;

ARCHITECTURE behaviour OF cursorConverter IS
    SIGNAL tempRow: INTEGER;
    SIGNAL tempCol: INTEGER;
    SIGNAL currentRowInt: INTEGER;
    SIGNAL currentColInt: INTEGER;
    SIGNAL startRowInt: INTEGER;
    SIGNAL startColInt: INTEGER;
BEGIN
PROCESS (currentRow, currentCol)  	
BEGIN
    currentRowInt <= to_integer(unsigned(currentRow));
	currentColInt <= to_integer(unsigned(currentCol));
	startRowInt <= to_integer(unsigned(startRow));
    startColInt <= to_integer(unsigned(startCol));

	IF (startRowInt <= currentRowInt and currentRowInt < startRowInt + 16) and (startColInt < currentColInt and currentColInt < startColInt + 9)  and (state = "000" or state = "110") then
		cursorEnabled <= '1';
	ELSE
        cursorEnabled <= '0';
	END IF;
	temprow <= abs(currentRowInt - startRowInt);
	tempcol <= abs(currentColInt - startColInt);
	
	address <= std_logic_vector(to_unsigned(temprow * 9 + tempcol + 1, 8));
END PROCESS;
END behaviour;