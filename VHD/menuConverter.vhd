LIBRARY IEEE;
USE  IEEE.STD_LOGIC_1164.all;
USE  IEEE.NUMERIC_STD.all;

ENTITY menuConverter IS
	PORT
	(
        currentRow, currentCol: IN STD_LOGIC_VECTOR(9 DOWNTO 0);
        state: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        menuAddress: OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
        menuEnabledOut: OUT STD_LOGIC;
        menuDeathEnabledOut: OUT STD_LOGIC
	);

END menuConverter;

ARCHITECTURE behaviour OF menuConverter IS
    SIGNAL currentRowInt: INTEGER;
    SIGNAL currentColInt: INTEGER;
    SIGNAL localisedStartRowMenu: INTEGER;
    SIGNAL localisedStartColMenu: INTEGER;
    SIGNAL startColMenu: INTEGER := 280;
    SIGNAL startRowMenu: INTEGER := 240;
    SIGNAL trainingEnabled : BOOLEAN;
    SIGNAL lvlOneEnabled : BOOLEAN;
    SIGNAL lvlTwoEnabled : BOOLEAN;
    SIGNAL lvlThreeEnabled : BOOLEAN;
    SIGNAL buttonColRange : BOOLEAN;
BEGIN
PROCESS (currentRow, currentCol)
BEGIN
    currentRowInt <= to_integer(unsigned(currentRow));
    currentColInt <= to_integer(unsigned(currentCol));
    localisedStartRowMenu <= abs(currentRowInt - startRowMenu);
    localisedStartColMenu <= abs(currentColInt - startColMenu); 
    buttonColRange <= (currentColInt > startColMenu AND currentColInt < startColMenu + 80);
    trainingEnabled <= (currentRowInt >= startRowMenu AND currentRowInt < startRowMenu + 28) AND buttonColRange;
    lvlOneEnabled <= (currentRowInt >= startRowMenu + 42 AND currentRowInt < startRowMenu + 42 + 28) AND buttonColRange;
    lvlTwoEnabled <= (currentRowInt >= startRowMenu + 42 * 2 AND currentRowInt < startRowMenu + 42 * 2 + 28) AND buttonColRange;
    lvlThreeEnabled <= (currentRowInt >= startRowMenu + 42 * 3 AND currentRowInt < startRowMenu + 42 * 3 + 28) AND buttonColRange;


    IF (trainingEnabled AND state = "000") THEN
        menuAddress <= STD_LOGIC_VECTOR(TO_UNSIGNED((localisedStartRowMenu/2 + 28) * 40 + localisedStartColMenu / 2, 12));
    ELSIF (lvlOneEnabled AND state = "000") THEN
        menuAddress <= STD_LOGIC_VECTOR(TO_UNSIGNED((localisedStartRowMenu/2 + 21) * 40 + localisedStartColMenu / 2, 12));
    ELSIF (trainingEnabled AND state = "110") THEN
        menuAddress <= STD_LOGIC_VECTOR(TO_UNSIGNED((localisedStartRowMenu/2) * 40 + localisedStartColMenu / 2, 12));
    ELSIF (lvlTwoEnabled) THEN
        menuAddress <= STD_LOGIC_VECTOR(TO_UNSIGNED((localisedStartRowMenu/2 + 14) * 40 + localisedStartColMenu / 2, 12));
    ELSIF (lvlThreeEnabled) THEN
        menuAddress <= STD_LOGIC_VECTOR(TO_UNSIGNED((localisedStartRowMenu/2 + 7) * 40 + localisedStartColMenu / 2, 12));
    END IF;

    IF ((trainingEnabled OR lvlOneEnabled OR lvlTwoEnabled OR lvlThreeEnabled) AND state = "000") THEN
        menuEnabledOut <= '1';
    ELSE
        menuEnabledOut <= '0';
    END IF;

    IF (trainingEnabled AND state = "110") THEN
        menuDeathEnabledOut <= '1';
    ELSE
        menuDeathEnabledOut <= '0';
    END IF;

END PROCESS;
END behaviour;