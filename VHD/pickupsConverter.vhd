LIBRARY IEEE;
USE  IEEE.STD_LOGIC_1164.all;
USE  IEEE.NUMERIC_STD.all;

ENTITY pickupsConverter IS
	PORT
	(
        currentRow, currentCol: IN STD_LOGIC_VECTOR(9 DOWNTO 0);
        startRow, startCol: IN INTEGER;
        state: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        heal, special: OUT STD_LOGIC;
        address: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        pickupEnabled: OUT STD_LOGIC
	);

END pickupsConverter;
ARCHITECTURE behaviour OF pickupsConverter IS
BEGIN

PROCESS (currentRow, currentCol)
    VARIABLE currentRowInt: INTEGER;
    VARIABLE currentColInt: INTEGER;
    VARIABLE localRow: INTEGER;
    VARIABLE localCol: INTEGER; 
BEGIN
    currentRowInt := to_integer(unsigned(currentRow));
    currentColInt := to_integer(unsigned(currentCol));
    localRow := abs(currentRowInt - startRow);
    localCol := abs(currentColInt - startCol);
    
    IF (currentRowInt >= startRow AND currentRowInt < startRow + 36) AND (currentColInt > startCol AND currentColInt < startCol + 36) AND (state = "011" OR state = "100" OR state = "101" OR state = "110")  THEN
        pickupEnabled <= '1';
    ELSE
        pickupEnabled <= '0';
    END IF;
    address <= std_logic_vector(to_unsigned((localRow / 4 * 9) + (localCol / 4), 7));
END PROCESS;    
END behaviour;

--  ELSIF (startColHeadIntTwo < 280 and startColHeadIntTwo >= 280 - speed) THEN