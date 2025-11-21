-- Button_Incrementer.vhd
-- component that debounces a push-button and increments an
-- 8-bit value on each clean rising edge of the button.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Button_Incrementer is

	generic ( 	-- values declared at instantiation 
	
		CLK_FREQ_HZ : integer := 50000000; -- system clock frequency (Hz)
		DEBOUNCE_MS : integer := 20;       -- debounce time (ms)
		btn_val	:	integer -- increments button depending on button val given
	);

	port (
		clk       : in  std_logic;                          -- system clock
		reset   : in  std_logic := '1';                   -- reset button
		btn_in    : in  std_logic;                          -- push button input (prefer active-high)
		output : out integer
	);

end Button_Incrementer;

architecture Behavioral of Button_Incrementer is

	-- debounce tick max_count calculated from generics
	constant db_time : natural := (CLK_FREQ_HZ / 1000) * DEBOUNCE_MS;

	-- synchronizer and debounce state
	signal sync0     : std_logic := '0';
	signal sync1     : std_logic := '0';
	signal stable    : std_logic := '0';
	signal prev_stab : std_logic := '0';
	signal db_cnt    : integer := 0;

begin

	-- Debounce, clock edge detection, and max_count increment process
	process(clk, reset)
	begin
		if reset = '0' then
			sync0     <= '0';
			sync1     <= '0';
			stable    <= '0';
			prev_stab <= '0';
			db_cnt    <= 0; -- max_counter for debouncer

		elsif rising_edge(clk) then
			-- two-stage synchronizer to avoid metastability
			sync0 <= btn_in;
			sync1 <= sync0;

			-- debouncer checks if value shave changed over duration of 20 ms (db_cnt)
			if sync1 /= stable then
				if db_cnt < db_time then
					db_cnt <= db_cnt + 1;
				else
					stable <= sync1;
					db_cnt <= 0;
				end if;
			else
				db_cnt <= 0;
			end if;

			-- checks for duplicate stable signals to avoid Duty Cycle overcorrecting
			if stable = '1' and prev_stab = '0' then
				output <= btn_val;
			else 
				output <= 0; 
			end if;

			prev_stab <= stable; -- set previous value to current stable value for future comparissons
		end if;
	end process;

end Behavioral;

