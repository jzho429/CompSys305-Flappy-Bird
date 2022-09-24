LIBRARY IEEE;
USE  IEEE.STD_LOGIC_1164.all;
USE  IEEE.NUMERIC_STD.all;

ENTITY groundConverter IS
	PORT
	(
        currentRow, currentCol: IN STD_LOGIC_VECTOR(9 DOWNTO 0);
        vSync: IN STD_LOGIC;
        speed: IN INTEGER;
        groundEnabled: OUT STD_LOGIC;
        address: OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
	);

END groundConverter;

ARCHITECTURE behaviour OF groundConverter IS
    SIGNAL tempRow: INTEGER;
    SIGNAL tempCol: INTEGER;
    SHARED VARIABLE positionOffset: INTEGER := 0;
BEGIN
PROCESS (currentRow, currentCol)  	
BEGIN
    tempRow <= to_integer(unsigned(currentRow));
    tempCol <= to_integer(unsigned(currentCol));
    IF (tempRow < 416) THEN
        groundEnabled <= '0';
    ELSIF (tempRow >= 416 and tempRow < 440) THEN
        groundEnabled <= '1';
        address <= std_logic_vector(to_unsigned((((tempRow-416) mod 24)*24) + ((tempCol + positionOffset) mod 24), 10));
    ELSIF (tempRow > 440) THEN
        address <= std_logic_vector(to_unsigned(575, 10));
        groundEnabled <= '1';
    END IF;
END PROCESS;

PROCESS(vSync)
BEGIN
    IF (rising_edge(vSync)) THEN
        positionOffset := positionOffset + speed;
    END IF;
END PROCESS;

END behaviour;