LIBRARY IEEE;
USE  IEEE.STD_LOGIC_1164.all;
USE  IEEE.NUMERIC_STD.all;

ENTITY promptConverter IS
	PORT
	(
        currentRow, currentCol: IN STD_LOGIC_VECTOR(9 DOWNTO 0);
        state: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        address: OUT STD_LOGIC_VECTOR(10 DOWNTO 0);
        promptEnabled: OUT STD_LOGIC
	);

END promptConverter;
ARCHITECTURE behaviour OF promptConverter IS
BEGIN
PROCESS (currentRow, currentCol)
    VARIABLE startRow: INTEGER := 290;
    VARIABLE startCol: INTEGER := 264;
    VARIABLE currentRowInt: INTEGER;
    VARIABLE currentColint: INTEGER;
    VARIABLE localRow: INTEGER;
    VARIABLE localCol: INTEGER;
BEGIN
    currentRowInt := to_integer(unsigned(currentRow));
    currentColInt := to_integer(unsigned(currentCol));
    localRow := currentRowInt - startRow;
    localCol := currentColInt - startCol;

    IF ((currentRowInt >= startRow AND currentRowInt < startRow + 60) AND (currentColInt >= startCol AND currentColInt < startCol + 114) AND state = "001") THEN
        promptEnabled <= '1';
    ELSE
        promptEnabled <= '0';
    END IF;
    address <= std_logic_vector(to_unsigned((localRow / 2) * 57 + (localCol / 2), 11));
END PROCESS;    
END behaviour;