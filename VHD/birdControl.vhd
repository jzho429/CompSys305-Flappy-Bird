LIBRARY IEEE;
USE  IEEE.STD_LOGIC_1164.all;
USE  IEEE.NUMERIC_STD.all;

ENTITY birdControl IS
	PORT
	(
		startRow, startCol: OUT INTEGER;
		vSync, leftClick: IN STD_LOGIC;
		state: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		pauseState: IN STD_LOGIC
	);

END birdControl;

ARCHITECTURE behaviour OF birdControl IS
    SIGNAL startrowInt: Integer := 240;
    SIGNAL timeX: INTEGER := 0;
    SIGNAL birdYMotion: INTEGER;
    SIGNAL temp: INTEGER;
	SIGNAL upSpeed: INTEGER;
BEGIN
upSpeed <= -3 WHEN (state = "000" OR state = "001") ELSE -6;
PROCESS (vSync)
BEGIN
	-- Move ball once every vertical sync
	IF (rising_edge(vSync)) THEN
		IF (pauseState = '1') THEN
			timeX <= timeX + 1;

			-- Adding gravity to bird movement
			IF ((leftClick = '1' AND (state /= "110" AND state /= "000")) OR (startRowInt >= 160 AND (state = "000" OR state = "001"))) THEN
				timeX <= 0;
			END IF;
			

			temp <= upSpeed + (timeX / 2);
			IF (temp > 10) THEN
				birdYMotion <= 10;
			ELSE 
				birdYMotion <= temp;
			END IF;
			startrowInt <= startrowInt + birdYMotion;



			IF (startrowInt > 378) THEN
				startrowInt <= 378;
				startRow <= 378;
			ELSIF (startrowInt < 0) THEN
				startrowInt <= 0;
				startRow <= 0;
			ELSE
				startRow <= startrowInt;
			END IF;
		END IF;
		startCol <= 297;
	END IF;
END PROCESS;
END ARCHITECTURE;