LIBRARY IEEE;
USE  IEEE.STD_LOGIC_1164.all;
USE  IEEE.NUMERIC_STD.all;

ENTITY pipeConverter IS
	PORT
	(
		currentRow, currentCol: IN STD_LOGIC_VECTOR (9 DOWNTO 0);
		startRowHead, startColHead: IN INTEGER;
		addressHead: OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
        addressBody: OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
		pipeHeadEnabled, pipeBodyEnabled : OUT STD_LOGIC
	);
END pipeConverter;

ARCHITECTURE behaviour OF pipeConverter is
	SIGNAL localisedRowHead : INTEGER;
	SIGNAL localisedRowHeadTop : INTEGER;
	SIGNAL localisedColHead : INTEGER;
	SIGNAL currentRowInt: INTEGER;
	SIGNAL currentColInt: INTEGER;
	SIGNAL startRowHeadTop: INTEGER := startRowHead - 180;
	SIGNAL startColBody: INTEGER := StartColHead + 3;
BEGIN
PROCESS(currentRow, currentCol)
BEGIN
	currentRowInt <= to_integer(unsigned(currentRow));
	currentColInt <= to_integer(unsigned(currentCol));

	localisedRowHead <= abs(currentRowInt - startRowHead);
	localisedColHead <= abs(currentColInt - startColHead);
	localisedRowHeadTop <= abs(currentRowInt - startRowHeadTop);
    --Pipe Head graphics
	IF (currentRowInt >= startRowHead and currentRowInt < startRowHead + 36) and (currentColInt > startColHead and currentColInt < startColHead + 75) THEN
		addressHead <= std_logic_vector(to_unsigned(localisedRowHead * 75 + localisedColHead, 12));
		pipeHeadEnabled <= '1';
	ELSIF (currentRowInt >= startRowHeadTop and currentRowInt < startRowHeadTop + 36) and (currentColInt > startColHead and currentColInt < startColHead + 75) THEN
		addressHead <= std_logic_vector(to_unsigned(2699 - ((localisedRowHeadTop + 1) * 75) + localisedColHead + 1, 12));
		pipeHeadEnabled <= '1';
	ELSE
		addressHead <= std_logic_vector(to_unsigned(0, 12));
		pipeHeadEnabled <= '0';
	END IF;

    --Pipe Body graphics
    IF ((currentRowInt >= startRowHead + 36 and currentRowInt < 480) or (currentRowInt <= startRowHeadTop - 1 and currentRowInt >= 0)) and (currentColInt > startColBody and currentColInt < startColBody + 69) THEN
		pipeBodyEnabled <= '1';
	ELSE
        pipeBodyEnabled <= '0';
	END IF;
	addressBody <= std_logic_vector(to_unsigned(abs(currentColInt - startColBody), 7));
	

END PROCESS;
END behaviour;