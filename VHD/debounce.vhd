LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY debounce IS
  GENERIC(
    stableTime : INTEGER := 50);
  PORT(
    clk     : IN  STD_LOGIC; 
    lineIn  : IN  STD_LOGIC;
    lineOut  : OUT STD_LOGIC;
    lineStateOut: OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
    );
END debounce;

ARCHITECTURE logic OF debounce IS
  SIGNAL lineState   : STD_LOGIC_VECTOR(1 DOWNTO 0);
BEGIN  
  PROCESS(clk)
    VARIABLE count :  INTEGER RANGE 0 TO 25000*stableTime;
  BEGIN
    IF(rising_edge(clk)) THEN
      lineState(0) <= lineIn;
      lineState(1) <= lineState(0);
      If(lineState = "01") THEN
        count := 0;                 
      ELSIF(count < 25000*stableTime) THEN
        count := count + 1;
        lineOut <= '1';
      ELSE
        lineOut <= '0';
      END IF;    
    END IF;
    lineStateOut <= lineState;
  END PROCESS;
  
END logic;