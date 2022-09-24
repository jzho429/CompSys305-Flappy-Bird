library IEEE;
use  IEEE.STD_LOGIC_1164.all;
use  IEEE.NUMERIC_STD.all;

ENTITY collisionDetection IS
	PORT(   currentRow, currentCol : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
            birdColour : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
            birdEnabled : IN STD_LOGIC;
            pipeHeadEnabled, pipeBodyEnabled, pipeHeadEnabledTwo, pipeBodyEnabledTwo: IN STD_LOGIC;
            pickupEnabled, invincibleEnabled : IN STD_LOGIC;
            pickupColour : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
            collisionOut : OUT STD_LOGIC;
            healOut : OUT STD_LOGIC
        );
END collisionDetection;

ARCHITECTURE detection OF collisionDetection IS
BEGIN
PROCESS(currentRow, currentCol)
BEGIN
    IF ((birdEnabled = '1' and birdColour /= "111100001111") AND (pipeHeadEnabled = '1' OR pipeBodyEnabled = '1' OR pipeHeadEnabledTwo = '1' OR pipeBodyEnabledTwo = '1')) THEN
        collisionOut <= '1';
    ELSE
        collisionOut <= '0';
    END IF;
    IF ((birdEnabled = '1' and birdColour /= "111100001111") AND (pickupEnabled = '1' AND pickupColour /= "111100001111")) THEN
        healOut <= '1';
    ELSE
        healOut <= '0';
    END IF;
END PROCESS;
END detection;