-- Button_Incrementer.vhd
-- component that debounces a push-button and increments an
-- 8-bit value on each clean rising edge of the button.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Button_Incrementer is

	generic (
		CLK_FREQ_HZ : integer := 50000000; -- system clock frequency (Hz)
		DEBOUNCE_MS : integer := 20;       -- debounce time (ms)
		count  : integer := 2         -- amount to add on each press (increases/decreases duty_cycle)
		constant btn_val	:	integer; -- increments button depending on button val given
	);
	port (
		clk       : in  std_logic;                          -- system clock
		reset   : in  std_logic := '1';                   -- reset button
		btn_in    : in  std_logic;                          -- push button input (prefer active-high)
	);

end Button_Incrementer;

architecture Behavioral of Button_Incrementer is

	-- debounce tick count computed from generics
	constant db_time : natural := (CLK_FREQ_HZ / 1000) * DEBOUNCE_MS;

	-- synchronizer and debounce state
	signal sync0     : std_logic := '0';
	signal sync1     : std_logic := '0';
	signal stable    : std_logic := '0';
	signal prev_stab : std_logic := '0';
	signal db_cnt    : integer := 0;
	-- internal value
	signal val       : unsigned(7 downto 0) := (others => '0');

begin

	-- Debounce, clock edge detection, and count increment process
	process(clk, reset)
	begin
		if reset = '0' then
			sync0     <= '0';
			sync1     <= '0';
			stable    <= '0';
			prev_stab <= '0';
			db_cnt    <= 0; -- counter for debouncer

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
				count <= count + button_val;
			end if;

			prev_stab <= stable;
		end if;
	end process;

end Behavioral;

--component declaration:
--
--	generic (
--		CLK_FREQ_HZ : integer := 50000000; -- system clock frequency (Hz)
--		DEBOUNCE_MS : integer := 20;       -- debounce time (ms)
--		count  : integer := 2         -- amount to add on each press (increases/decreases duty_cycle)
--	);
--	port (
--		clk       : in  std_logic;                          -- system clock
--		reset   : in  std_logic := '1';                   -- reset button
--		btn_in    : in  std_logic;                          -- push button input (prefer active-high)
--	);


-- end component;

-- instantiation in a VHDL top-level:
--
-- Button_Incrementer_inst : Button_Incrementer
--     generic map (
--         CLK_FREQ_HZ => 50000000,
--         DEBOUNCE_MS => 20,
--         STEP        => 8
--     );
--     port map (
--         clk       => CLOCK_50,
--         reset   => KEY[0],   -- or tie '1' if not used
--         btn_in    => KEY[1],
--         value_out => manual_duty_bus
--     );
