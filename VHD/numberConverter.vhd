LIBRARY IEEE;
USE  IEEE.STD_LOGIC_1164.all;
USE  IEEE.NUMERIC_STD.all;

ENTITY numberConverter IS
	PORT
	(	
		displayNumber: IN INTEGER RANGE 0 TO 999;
		currentRow, currentCol: IN STD_LOGIC_VECTOR (9 DOWNTO 0);
		address: OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
		textEnabled: OUT STD_LOGIC;
		state: IN STD_LOGIC_VECTOR(2 DOWNTO 0)
	);
END numberConverter;

ARCHITECTURE behaviour OF numberConverter IS
	SIGNAL startRow: INTEGER := 50;--RANGE 0 TO 480 := 50;
	SIGNAL startCol: INTEGER := 314;--RANGE 0 TO 640 := 314;
	SIGNAL currentNumber: INTEGER;--RANGE 0 TO 9;
	SIGNAL currentRowInt: INTEGER;--RANGE 0 TO 525;
	SIGNAL currentColInt: INTEGER;--RANGE 0 TO 800;
	SIGNAL localisedRow: INTEGER;--RANGE 0 TO 480;
	SIGNAL localisedCol: INTEGER;--RANGE 0 TO 640;
	SIGNAL localisedColOffset: INTEGER;--RANGE 0 TO 24;
	SIGNAL startColOnes: INTEGER;--RANGE 0 TO 640;
	SIGNAL startColTens: INTEGER;--RANGE 0 TO 640;
	SIGNAL startColHundreds: INTEGER;--RANGE 0 TO 640;
	SIGNAL digitsRequired: INTEGER;--RANGE 0 TO 3;
	SIGNAL totalWidth: INTEGER;--RANGE 0 TO 36;
	SIGNAL verticalOffsetHack: INTEGER := 0;
BEGIN
PROCESS (currentRow, currentCol)
BEGIN
	IF (displayNumber/100 /= 0) THEN
		digitsRequired <= 3;
	ELSIF (displayNumber/10 /= 0) THEN
		digitsRequired <= 2;
	ELSE
		digitsRequired <= 1;
	END IF;
	startCol <= 320 - 6 * digitsRequired;
	currentRowInt <= to_integer(unsigned(currentRow));
	currentColInt <= to_integer(unsigned(currentCol));
	localisedRow <= abs(currentRowInt - startRow);
	localisedCol <= abs(currentColInt - startCol);
	startColOnes <= 320 - 6 + ((digitsRequired - 1) * 6);
	startColTens <= 320 - 12 + ((digitsRequired - 2) * 6);
	startColHundreds <= 320 - 18;
	IF (currentColInt >= startColOnes AND currentColInt < startColOnes + 12) THEN
		currentNumber <= displayNumber MOD 10;
		verticalOffsetHack <= 0;
	ELSIF (currentColInt >= startColTens AND currentColInt < startColTens + 12) THEN
		currentNumber <= (displayNumber MOD 100) / 10;
		verticalOffsetHack <= 1;
	ELSIF (currentColInt >= startColHundreds AND currentColInt < startColHundreds + 12) THEN
		currentNumber <= displayNumber / 100;
		verticalOffsetHack <= 2;
	END IF;
	totalWidth <= digitsRequired * 12;
	localisedColOffset <= (digitsRequired - 1) * 12;
	address <= STD_LOGIC_VECTOR(TO_UNSIGNED((localisedRow + currentNumber * 18 + verticalOffsetHack) * 12 + (localisedCol - localisedColOffset),12));
	IF ((currentRowInt >= startRow AND currentRowInt < startRow + 18) AND (currentColInt > startCol AND currentColInt < startCol + totalWidth) AND state /= "000") THEN
		textEnabled <= '1';
	ELSE
		textEnabled <= '0';
	END IF;
END PROCESS;
END ARCHITECTURE;