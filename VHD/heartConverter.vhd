LIBRARY IEEE;
USE  IEEE.STD_LOGIC_1164.all;
USE  IEEE.NUMERIC_STD.all;

ENTITY heartConverter IS
	PORT
	(
        currentRow, currentCol: IN STD_LOGIC_VECTOR(9 DOWNTO 0);
        hearts: IN INTEGER RANGE 0 TO 3;
        state: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        address: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        heartEnabled: OUT STD_LOGIC
	);

END heartConverter;
ARCHITECTURE behaviour OF heartConverter IS
BEGIN
PROCESS (currentRow, currentCol)
    VARIABLE startRow: INTEGER := 40;
    VARIABLE startCol: INTEGER := 40;
    VARIABLE currentRowInt: INTEGER;
    VARIABLE currentColint: INTEGER;
    VARIABLE localRow: INTEGER;
    VARIABLE localCol: INTEGER;
BEGIN
    currentRowInt := to_integer(unsigned(currentRow));
    currentColInt := to_integer(unsigned(currentCol));
    localRow := currentRowInt - startRow;
    localCol := currentColInt - startCol;

    IF ((currentRowInt >= startRow AND currentRowInt < startRow + 36) AND (currentColInt > startCol AND currentColInt < startCol + (36 * hearts)) AND (state /= "000" AND state /= "001" AND state /= "010")) THEN
        heartEnabled <= '1';
    ELSE
        heartEnabled <= '0';
    END IF;
    address <= std_logic_vector(to_unsigned((localRow / 4 * 9) + ((localCol / 4) MOD 9), 7));
END PROCESS;    
END behaviour;