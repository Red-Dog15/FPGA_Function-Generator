-- Wave Multiplexer
library IEEE;
use IEEE.STD_Logic_1164.ALL;
Use IEEE.NUMERIC_STD.ALL; 

entity Wave_mux is

	port(
		clk 	:	in	STD_LOGIC;
		wave_out	:	out	STD_LOGIC_VECTOR(7 downto 0);
		
		reset   :      in	STD_LOGIC;                     -- reset button
		btn0_in    :     in	STD_LOGIC;                   -- push button input (prefer active-high)
		btn1_in    :     in	STD_LOGIC                   -- push button input (prefer active-high)
	);
	
end Wave_mux;

		
architecture Behavioral of Wave_mux is


begin


PWM0 : entity work.PWM_gen
port map(
    clk => clk,
    reset => reset,
    duty => 50,   -- TEMP constant
    pwm_out => pwm_wave(7)
);



-- tie remaining bits
pwm_wave(6 downto 0) <= (others => pwm_wave(7));

end Behavoiral
