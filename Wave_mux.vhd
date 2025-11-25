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
		--output waves
		pwm_wave	:	out	STD_LOGIC_VECTOR(7 downto 0);
		sin_wave :	out	STD_LOGIC_VECTOR(7 downto 0)
	);
	
end Wave_mux;

		
architecture Behavioral of Wave_mux is

	-- Build an enumerated type for the state machine
	type state_type is (s0, s1);

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
	
-- Quartus Prime VHDL Template
-- Safe State Machine

library ieee;
use ieee.std_logic_1164.all;

entity safe_state_machine is

	port(
		clk		 : in	std_logic;
		input	 : in	std_logic;
		reset	 : in	std_logic;
		output	 : out	std_logic_vector(1 downto 0)
	);


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


	-- Logic to determine output
	process (state)
	begin
		case state is
			when s0 =>
				output <= "00";
			when s1 =>
				output <= "01";
			when s2 =>
				output <= "10";
		end case;
	end process;



end Behavioral;
