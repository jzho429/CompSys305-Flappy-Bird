LIBRARY IEEE;
USE  IEEE.STD_LOGIC_1164.all;
USE  IEEE.NUMERIC_STD.all;

ENTITY pickupControl IS
	PORT
	(
        startRowOut, startColOut: OUT INTEGER;
        pipeCol, pipeColTwo: IN INTEGER;
        speed: IN INTEGER;
        vSync: IN STD_LOGIC;
        LFSRData: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        state: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        used: IN STD_LOGIC
	);

END pickupControl;

ARCHITECTURE behaviour OF pickupControl IS
    SIGNAL startRowInt: INTEGER := 0;
    SIGNAL startColInt: INTEGER := -50;
    SIGNAL canSpawn: STD_LOGIC := '0';
    SIGNAL counter: INTEGER := 4;
BEGIN
PROCESS (vSync)  	
BEGIN
	-- Move pipe once every vertical sync
	IF (rising_edge(vSync)) THEN
        IF (state = "000") THEN
            startColInt <= -75;
        ELSIF (pipeColTwo < 460 AND pipeColTwo >= 460 - speed AND canSpawn = '1') THEN
            counter <= counter + 1;
            IF (counter >= 5) THEN
                startColInt <= 640;
                startRowInt <= 10 + to_integer(unsigned(LFSRData))*358/255;
                counter <= 0;
            END IF;
        ELSIF (pipeCol < 460 AND pipeCol >= 460 - speed AND canSpawn = '1') THEN
            counter <= counter + 1;
            IF (counter >= 5) THEN
                startColInt <= 640;
                startRowInt <= 10 + to_integer(unsigned(LFSRData))*358/255;
                counter <= 0;
            END IF;
        ELSE
            startColInt <= startColInt - speed;
        END IF;
        
        IF (startColInt < -36) THEN
            canSpawn <= '1';
        ELSE
            canSpawn <= '0';
        END IF;
        IF (used = '1') THEN
            startColInt <= -36;
        END IF;
        startColOut <= startColInt;
        startRowOut <= startRowInt;
	END IF;
END PROCESS;
END ARCHITECTURE;