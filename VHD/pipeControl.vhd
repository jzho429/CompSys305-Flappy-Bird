LIBRARY IEEE;
USE  IEEE.STD_LOGIC_1164.all;
USE  IEEE.NUMERIC_STD.all;

ENTITY pipeControl IS
	PORT
	(
        startRowHead, startColHead: OUT INTEGER;
        startRowHeadTwo, startColHeadTwo: OUT INTEGER;
        pipeReset: OUT STD_LOGIC;
        speed: IN INTEGER;
        vSync, rightClick: IN STD_LOGIC;
        LFSRData: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        state: IN STD_LOGIC_VECTOR(2 DOWNTO 0)
	);

END pipeControl;

ARCHITECTURE behaviour OF pipeControl IS
    SIGNAL startRowHeadInt: INTEGER := 200;
    SIGNAL startColHeadInt: INTEGER := 800;
    SIGNAL startRowHeadIntTwo: INTEGER := 200;
    SIGNAL startColHeadIntTwo: INTEGER := -75;
BEGIN

PROCESS (vSync)  	
BEGIN
	-- Move pipe once every vertical sync
	IF (rising_edge(vSync)) THEN
        IF (state = "000") THEN
            startColHeadInt <= 800;
            startColHeadIntTwo <= -75;
            pipeReset <= '0';
        ELSIF (startColHeadIntTwo < 280 and startColHeadIntTwo >= 280 - speed) THEN
            startColHeadInt <= 640;
            startRowHeadInt <= 180 + to_integer(unsigned(LFSRData))*200/255;
            startColHeadIntTwo <= startColHeadIntTwo - speed;
            pipeReset <= '1';
        ELSIF (startColHeadInt < 280 and startColHeadInt >= 280 - speed) THEN
            startColHeadIntTwo <= 640;
            startRowHeadIntTwo <= 180 + to_integer(unsigned(LFSRData))*200/255;
            startColHeadInt <= startColHeadInt - speed;
            pipeReset <= '1';
        ELSE
            startColHeadInt <= startColHeadInt - speed;
            startColHeadIntTwo <= startColHeadIntTwo - speed;
            pipeReset <= '0';
        END IF;

        startColHead <= startColHeadInt;
        startRowHead <= startRowHeadInt;
        startColHeadTwo <= startColHeadIntTwo;
        startRowHeadTwo <= startRowHeadIntTwo;
	END IF;
END PROCESS;
END ARCHITECTURE;