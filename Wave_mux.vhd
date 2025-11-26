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
		sw0 :  in	STD_LOGIC;                   -- switch to change between sin and square wave
		LEDs : out std_logic_vector(2 downto 0);		-- leds tied to 3 bit Standerd logic vector
		SSEG0, SSEG1 : out std_logic_vector(6 downto 0); 			-- state LEDS

		--wave_out waves
		wave_out	:	out	STD_LOGIC_VECTOR(7 downto 0)	
	);
	
end Wave_mux;

architecture Behavioral of Wave_mux is

	-- Build an enumerated type for the state machine
	type state_type is (state_pwm, state_wave, state_reset);

	-- Register to hold the current state
	signal state   : state_type := state_wave;
	signal sin_wave : STD_LOGIC_VECTOR(7 downto 0);
	signal pwm_wave :	STD_LOGIC_VECTOR(7 downto 0);
	signal sseg_tens : Integer range 0 to 9 := 0;
	signal sseg_ones : Integer range 0 to 9 := 0;

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
	process(clk, reset)
	begin
		if reset = '0' then
			state <=  state_reset;
		elsif rising_edge(clk) then
			case state is -- state machine for wave multiplexer
				when state_pwm=> -- describe pwm wave state condtions
					if (sw0 = '0')  then --checks for sw0 logic
						state <= state_wave;
					else
						state <= state_pwm;
					end if;
					
				when state_wave=> -- describe sin wave state conditions
					if (sw0 = '1')  then --checks for sw0 logic
						state <= state_pwm;
					else
						state <= state_wave;
					end if;	
				when state_reset=> -- describe sin wave state conditions
					if reset = '1' then
						state <= state_pwm;
					else
						state <= state_reset;
					end if;
			end case;
		end if;
	end process;
	-- State Descriptions
	process (state)
	begin
		case state is
			when state_pwm =>
				wave_out <= pwm_wave; --set wave_out wave based on state
				LEDs <= "110"; --set leds based on state

			when state_wave  =>
				wave_out <= sin_wave;
				LEDs <= "101"; 
				
			when state_reset  =>
				LEDs <= "111"; 
		end case;
	end process;

end Behavioral;
