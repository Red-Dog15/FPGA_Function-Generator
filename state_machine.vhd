
--	 State machine entity File --

-- State machine

library ieee;
use ieee.std_logic_1164.all;

entity state_machine is

	port(
		clk		 : in	std_logic;
		input	 : in	std_logic;
		reset	 : in	std_logic;
		output	 : out	std_logic_vector(1 downto 0)
	);

end entity;

architecture rtl of four_state_moore_state_machine is

	-- Build an enumerated type for the state machine
	type state_type is (s0, s1, s2, s3);

	-- Register to hold the current state
	signal state   : state_type;

begin

	-- Logic to advance to the next state
	process (clk, reset)
	begin
		if reset = '1' then
			state <= s0;
		elsif (rising_edge(clk)) then
			case state is
				when s0=>
					if input = '1' then
						state <= s1;
					else
						state <= s0;
					end if;
				when s1=>
					if input = '1' then
						state <= s2;
					else
						state <= s1;
					end if;
			end case;
		end if;
	end process;

	-- Output depends solely on the current state
	process (state)
	begin
		case state is
			when s0 => -- PWM Waveform With Adjustable Duty Cycle
				output <= "00";
			when s1 => -- Sine Waveform
				output <= "01";
		end case;
	end process;

end rtl;
