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


begin
	
	-- instantiate PWM wave
	PWM0 : entity work.PWM_gen
	port map(
		 clk => clk,
		 reset => reset,
		 pwm_out => pwm_wave(7),
		 btn0_in	=> btn0_in,
		 btn1_in => btn1_in
	);

		-- tie remaining bits
	pwm_wave(6 downto 0) <= (others => pwm_wave(7));
	
	-- instantiate SIN wave
	sin_wave : entity work.waveLUT
	port map(
		 clk => clk,
		 reset => reset,
		 
		 btn0_in => btn0_in,
		 btn1_in => btn1_in,
		 wave_out => sin_wave
	);
	


end Behavioral;
