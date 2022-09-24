LIBRARY IEEE;
USE  IEEE.STD_LOGIC_1164.all;
USE  IEEE.NUMERIC_STD.all;

ENTITY textConverter IS
    PORT
    (
        currentRow, currentCol: IN STD_LOGIC_VECTOR(9 DOWNTO 0);
        state: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        titleAddress: OUT STD_LOGIC_VECTOR(12 DOWNTO 0);
        titleEnabledOut: OUT STD_LOGIC
    );

END textConverter;

ARCHITECTURE behaviour OF textConverter IS
    SIGNAL currentRowInt: INTEGER;
    SIGNAL currentColInt: INTEGER;
    SIGNAL localisedStartRowTitle: INTEGER;
    SIGNAL localisedStartColTitle: INTEGER;
    SIGNAL startRowTitle: INTEGER := 90;
    SIGNAL startColTitle: INTEGER := 225;
    SIGNAL titleEnabled: BOOLEAN;
BEGIN
PROCESS (currentRow, currentCol)
BEGIN
    currentRowInt <= to_integer(unsigned(currentRow));
    currentColInt <= to_integer(unsigned(currentCol));
    localisedStartRowTitle <= abs(currentRowInt - startRowTitle);
    localisedStartColTitle <= abs(currentColInt - startColTitle);
    titleEnabled <= (currentRowInt >= startRowTitle AND currentRowInt < startRowTitle + 50) AND (currentColInt > startColTitle AND currentColInt < startColTitle + 190);

    IF (state = "000") THEN --TITLE TEXT
        titleAddress <= STD_LOGIC_VECTOR(TO_UNSIGNED((localisedStartRowTitle / 2) * 95 + localisedStartColTitle / 2, 13));
    ELSIF (state = "001") THEN --GET READY TEXT
        titleAddress <= STD_LOGIC_VECTOR(TO_UNSIGNED((localisedStartRowTitle / 2 + 25) * 95 + localisedStartColTitle / 2, 13));
    ELSIF (state = "110") THEN --GAME OVER TEXT
        titleAddress <= STD_LOGIC_VECTOR(TO_UNSIGNED((localisedStartRowTitle / 2 + 50) * 95 + localisedStartColTitle / 2, 13));
    END IF;
    IF (titleEnabled AND (state = "000" OR state = "001" OR state = "110")) THEN
        titleEnabledOut <= '1';
    ELSE
        titleEnabledOut <= '0';
    END IF;

END PROCESS;
END behaviour;