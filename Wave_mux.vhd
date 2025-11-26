-- Wave Multiplexer
library IEEE;
use IEEE.STD_Logic_1164.ALL;
Use IEEE.NUMERIC_STD.ALL; 

entity Wave_mux is

	port(
		clk 	:	in	STD_LOGIC;
		reset   :      in	STD_LOGIC;                     -- reset button
		btn0_in    :     in	STD_LOGIC;                   -- push button input (prefer active-high)
		btn1_in    :     in	STD_LOGIC;                -- push button input (prefer active-high)
		sw0, sw1 :  in	STD_LOGIC;                   -- switch to change between sin and square wave
		LED0, LED1, LED3 : in std_logic;				-- state LEDS
		SSEG0, SSEG1 : in std_logic_vector(7 downto 0); 				-- state LEDS

		--output waves
		pwm_wave	:	out	STD_LOGIC_VECTOR(7 downto 0);
		sin_wave :	out	STD_LOGIC_VECTOR(7 downto 0)
		
	);
	
end Wave_mux;

		
architecture Behavioral of Wave_mux is

	-- Build an enumerated type for the state machine
	type state_type is (state_pwm, state_wave, state_null);

	-- Register to hold the current state
	signal state   : state_type;


begin
	
	-- instantiate PWM wave
	PWM0 : entity work.PWM_gen
	port map(
		 clk => clk,
		 reset => reset,
		 pwm_out => pwm_wave,
		 btn0_in	=> btn0_in,
		 btn1_in => btn1_in
	);

	-- instantiate SIN wave
	SIN0 : entity work.waveLUT
	port map(
		 clk => clk,
		 reset => reset,
		 
		 btn0_in => btn0_in,
		 btn1_in => btn1_in,
		 wave_out => sin_wave
	);

	-- Logic to advance to the next state
	process (clk, reset)
	begin
		if reset = '1' then
			state <= state_pwm;
		elsif (rising_edge(clk)) then
			case state is -- state machine for wave multiplexer
				when state_pwm=> -- describe pwm wave state condtions
					if (sw0 = '0') & (sw1 = '1') then --checks for sw0 logic
						state <= state_wave;
					else if (sw0 = '1') & (sw1 = '1') then --checks for null state requirements
						state <= state_null;
					else
						state <= state_pwm;
					end if;
					
				when state_wave=> -- describe sin wave state conditions
					if (sw0 = '1') & (sw1 = '0') then --checks for sw0 logic
						state <= state_pwm;
					else if (sw0 = '1') & (sw1 = '1') then --checks for null state requirements
						state <= state_null;
					else
						state <= state_wave;
					end if;
					
				when state_null =>  -- describe null state conditions (neither gate is open)
					if (sw0 = '1') & (sw1 = '0') then --checks for sw0 logic
						state <= state_pwm;
					else if (sw0 = '0') & sw1 = '1') then --checks for null state requirements
						state <= state_wave;
					else
						state <= state_null;
					end if;
			end case
			
	-- State Descriptions
	process (state)
	begin
		case state is
			when state_pwm =>
				output <= pwm_wave;
			when state_wave  =>
				output <= sin_wave;
			when state_null  =>
				output <= "00000000";

		end case;
	end process;

end Behavioral;
