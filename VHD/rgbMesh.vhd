library IEEE;
use  IEEE.STD_LOGIC_1164.all;
use  IEEE.STD_LOGIC_ARITH.all;
use  IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY rgbMesh IS
	PORT(   clk : in STD_LOGIC;
            backgroundColour : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
            birdColourUp : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
            birdColourDown : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
            birdEnabledUp : IN STD_LOGIC;
            birdEnabledDown: IN STD_LOGIC;
            pipeHeadColour, pipeBodyColour : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
            pipeHeadEnabled, pipeBodyEnabled : IN STD_LOGIC;
            pipeHeadColourTwo, pipeBodyColourTwo : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
            pipeHeadEnabledTwo, pipeBodyEnabledTwo : IN STD_LOGIC;
            cursorColour : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
            cursorEnabled : IN STD_LOGIC;
            groundColour : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
            groundEnabled : IN STD_LOGIC;
            scoreColour : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
            scoreEnabled : IN STD_LOGIC;
            titleEnabled : IN STD_LOGIC;
            titleColour : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
            menuEnabled : IN STD_LOGIC;
            menuColour : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
            heartEnabled: IN STD_LOGIC;
            heartColour: IN STD_LOGIC_VECTOR(11 DOWNTO 0);
            promptEnabled: IN STD_LOGIC;
            promptColour: IN STD_LOGIC_VECTOR(11 DOWNTO 0);
            menuDeathEnabled: IN STD_LOGIC;
            pickupEnabled: IN STD_LOGIC;
            pickupColour: IN STD_LOGIC_VECTOR(11 DOWNTO 0);
            outColour : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
    );
END rgbMesh;

ARCHITECTURE mesh OF rgbMesh IS
BEGIN
PROCESS(clk)
BEGIN
    IF (rising_edge(clk)) THEN
        IF (cursorEnabled = '1' and cursorColour /= "111100001111") THEN
            outColour <= cursorColour;
        ELSIF (birdEnabledUp = '1'  and birdEnabledDown = '0' and birdColourUp /= "111100001111") THEN
            outColour <= birdColourUp;
        ELSIF (birdEnabledDown = '1' and birdEnabledUp = '0' and birdColourDown /= "111100001111") THEN
            outColour <= birdColourDown;
        ELSIF (heartEnabled = '1' and heartColour /= "111100001111") THEN
            outColour <= heartColour;
        ELSIF (scoreEnabled = '1' and scoreColour /= "111100001111") THEN
            outColour <= scoreColour;
        ELSIF (promptEnabled = '1' and promptColour /= "111100001111") THEN
            outColour <= promptColour;
        ELSIF (titleEnabled = '1' and titleColour /= "111100001111") THEN
            outColour <= titleColour;
        ELSIF (menuEnabled = '1') THEN
            outColour <= menuColour;
        ELSIF (menuDeathEnabled = '1') THEN
            outColour <= menuColour;
        ELSIF (pickupEnabled = '1' and pickupColour /= "111100001111") THEN
            outColour <= pickupColour;
        ELSIF (groundEnabled = '1') THEN
            outColour <= groundColour;
        ELSIF (pipeHeadEnabled = '1') THEN
            outColour <= pipeHeadColour;
        ELSIF (pipeHeadEnabledTwo = '1') THEN
            outColour <= pipeHeadColourTwo;
		ELSIF (pipeBodyEnabled = '1') THEN
            outColour <= pipeBodyColour;
        ELSIF (pipeBodyEnabledTwo = '1') THEN
            outColour <= pipeBodyColourTwo;
        ELSE 
            outColour <= backgroundColour;
        END IF;
    END IF;
END PROCESS;
END mesh;