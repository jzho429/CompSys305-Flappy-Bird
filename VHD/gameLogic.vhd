library IEEE;
use  IEEE.STD_LOGIC_1164.all;
use  IEEE.NUMERIC_STD.all;

ENTITY gameLogic IS
	PORT(   
            pipeCollision : IN STD_LOGIC;
            state: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            pipeReset: IN STD_LOGIC;
            heal: IN STD_LOGIC;
            birdRow: IN INTEGER;
            pauseState: IN STD_LOGIC;
            speed: OUT INTEGER;
            health: INOUT INTEGER RANGE 0 TO 3;
            score: OUT INTEGER RANGE 0 TO 999 := 0;
            death: OUT STD_LOGIC;
            pauseOut: OUT STD_LOGIC
        );
END gameLogic;

ARCHITECTURE logic OF gameLogic IS
SIGNAL counter: INTEGER := 0;
SIGNAL scoreCount: INTEGER RANGE 0 TO 999 := 0;
BEGIN
pauseOut <= pauseState;
speed <= 0 WHEN pauseState = '0' ELSE 4 WHEN state = "011" ELSE 6 WHEN state = "100" ELSE 8 WHEN state = "101" ELSE 4 WHEN state = "010" ELSE 0;
PROCESS(pipeCollision)
BEGIN
    IF (state = "001") THEN
        health <= 3;
        death <= '0';
    ELSIF (health = 0 OR birdRow >= 378) THEN
        death <= '1';
    ELSIF (heal = '1') THEN
        health <= 3;
    ELSIF(rising_edge(pipeCollision) AND health > 0) THEN
        health <= health - 1;
    END IF;
END PROCESS;
PROCESS(pipeReset)
BEGIN
    IF (state = "001") THEN
        scoreCount <= 0;
    ELSIF (rising_edge(pipeReset)) THEN
        scoreCount <= scoreCount + 1;
    END IF;
    score <= scoreCount;
END PROCESS;
END ARCHITECTURE;