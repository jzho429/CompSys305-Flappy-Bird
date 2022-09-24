LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY stateMachine IS
    PORT (
        reset : IN STD_LOGIC := '0';
        clock : IN STD_LOGIC;
        dead : IN STD_LOGIC := '0';
        mouseLeft : IN STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
        mouseRight : IN STD_LOGIC := '0';
        mouseRow : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
        mouseCol : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
        stateOut : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
    );
END stateMachine;

ARCHITECTURE BEHAVIOR OF stateMachine IS
    TYPE type_fstate IS (menu,idle,training,lvl1,lvl2,lvl3,death);
    SIGNAL fstate : type_fstate;
    SIGNAL reg_fstate : type_fstate;
    SHARED VARIABLE mouseRowInt: INTEGER := 0;
    SHARED VARIABLE mouseColInt: INTEGER := 0;
BEGIN
    PROCESS (clock,reg_fstate)
    BEGIN
        IF (RISING_EDGE(clock)) THEN
            fstate <= reg_fstate;
        END IF;
    END PROCESS;

    PROCESS (mouseRow, mouseCol)
    BEGIN
        mouseRowInt := TO_INTEGER(UNSIGNED(mouseRow));
        mouseColInt := TO_INTEGER(UNSIGNED(mouseCol));
    END PROCESS;

    PROCESS (fstate,reset,dead,mouseLeft,mouseRight,mouseRow,mouseCol)
    VARIABLE buttonCol: BOOLEAN;
    VARIABLE lvl: INTEGER := 0;
    BEGIN
        buttonCol := mouseColInt >= 280 AND mouseColInt < 360;
        IF (reset='1') THEN
            reg_fstate <= menu;
            stateOut <= "000";
        ELSE
            stateOut <= "000";
            CASE fstate IS
                WHEN menu =>
                    IF (mouseLeft = "01" AND (mouseRowInt >= 240 AND mouseRowInt < 268) AND buttonCol) THEN
                        reg_fstate <= idle;
                        lvl := 0;
                    ELSIF (mouseLeft = "01" AND (mouseRowInt >= 284 AND mouseRowInt < 310) AND buttonCol) THEN
                        reg_fstate <= idle;
                        lvl := 1;
                    ELSIF (mouseLeft = "01" AND (mouseRowInt >= 324 AND mouseRowInt < 352) AND buttonCol) THEN
                        reg_fstate <= idle;
                        lvl := 2;
                    ELSIF (mouseLeft = "01" AND (mouseRowInt >= 366 AND mouseRowInt < 394) AND buttonCol) THEN
                        reg_fstate <= idle;
                        lvl := 3;
                    -- Inserting 'else' block to prevent latch inference
                    ELSE
                        reg_fstate <= menu;
                    END IF;

                    stateOut <= "000";
                WHEN idle =>
                    IF (mouseLeft = "01") THEN
                        CASE lvl IS
                            WHEN 0 => reg_fstate <= training;
                            WHEN 1 => reg_fstate <= lvl1;
                            WHEN 2 => reg_fstate <= lvl2;
                            WHEN 3 => reg_fstate <= lvl3;
                            WHEN OTHERS => reg_fstate <= idle;
                        END CASE;
                    ELSE
                        reg_fstate <= idle;
                    END IF;

                    stateOut <= "001";
                WHEN training =>
                    IF (mouseRight = '1') THEN
                        reg_fstate <= menu;
                    -- Inserting 'else' block to prevent latch inference
                    ELSE
                        reg_fstate <= training;
                    END IF;

                    stateOut <= "010";
                WHEN lvl1 =>
                    IF ((dead = '1')) THEN
                        reg_fstate <= death;
                    -- Inserting 'else' block to prevent latch inference
                    ELSE
                        reg_fstate <= lvl1;
                    END IF;

                    stateOut <= "011";
                WHEN lvl2 =>
                    IF ((dead = '1')) THEN
                        reg_fstate <= death;
                    -- Inserting 'else' block to prevent latch inference
                    ELSE
                        reg_fstate <= lvl2;
                    END IF;

                    stateOut <= "100";
                WHEN lvl3 =>
                    IF ((dead = '1')) THEN
                        reg_fstate <= death;
                    -- Inserting 'else' block to prevent latch inference
                    ELSE
                        reg_fstate <= lvl3;
                    END IF;

                    stateOut <= "101";
                WHEN death =>
                    --IF (mouseLeft = "01" AND (mouseRowInt >= 240 AND mouseRowInt < 268) AND buttonCol) THEN
                        --reg_fstate <= idle;
                    IF (mouseLeft = "01" AND (mouseRowInt >= 284 AND mouseRowInt < 310) AND buttonCol) THEN
                        reg_fstate <= menu;
                    -- Inserting 'else' block to prevent latch inference
                    ELSE
                        reg_fstate <= death;
                    END IF;

                    stateOut <= "110";
                WHEN OTHERS => 
                    stateOut <= "XXX";
                    report "Reach undefined state";
            END CASE;
        END IF;
    END PROCESS;
END BEHAVIOR;
