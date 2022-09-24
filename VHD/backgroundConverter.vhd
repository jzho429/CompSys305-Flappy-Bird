LIBRARY IEEE;
USE  IEEE.STD_LOGIC_1164.all;
USE  IEEE.NUMERIC_STD.all;

ENTITY backgroundConverter IS
	PORT
	(
        vSync: IN STD_LOGIC;
        currentRow, currentCol: IN STD_LOGIC_VECTOR(9 DOWNTO 0);
        address: OUT STD_LOGIC_VECTOR(12 DOWNTO 0)
	);

END backgroundConverter;

ARCHITECTURE behaviour OF backgroundConverter IS
    SIGNAL tempRow: INTEGER;
    SIGNAL tempCol: INTEGER;
    SIGNAL counter: INTEGER := 0;
BEGIN

PROCESS (vSync)
BEGIN
    IF (rising_edge(vSync)) THEN
        IF (counter >= 75*4) THEN
            counter <= 1;
        ELSE
            counter <= counter + 1;
        END IF;
    END IF;
END PROCESS;

PROCESS (currentRow, currentCol)  	
BEGIN
    tempRow <= to_integer(unsigned(currentRow));
    tempCol <= to_integer(unsigned(currentCol));
    IF (tempRow < 210) THEN
        address <= std_logic_vector(to_unsigned(0, 13));
    ELSE
        address <= std_logic_vector(to_unsigned((((tempRow-211)/4 mod 56)*75) + ((tempCol + counter)/4 mod 75), 13));
    END IF;
END PROCESS;
END behaviour;