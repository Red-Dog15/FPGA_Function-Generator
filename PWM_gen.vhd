library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PWM_gen is

    Port(
        clk        : in std_logic;
        reset      : in std_logic;
        pwm_out    : out STD_LOGIC_VECTOR(7 DOWNTO 0);
		  btn0_in	:  in std_logic;
		  btn1_in  :	in std_logic
    );
	 
end PWM_gen;

architecture Behavioral of PWM_gen is
    -- initiate signals
	 signal duty  : integer range 0 to 100 := 50;   -- duty % cycle
    signal cnt : integer range 0 to 99 := 0;
	 signal plus_pulse    : integer := 0; -- hold incrementer states
    signal minus_pulse   : integer := 0;
	 constant duty_incrementer   : integer := 10; -- how much each button press changes the duty cycle

begin

-- instantiate 2 instance of button incrementer, button plut (positive incrementer) & button minus (negative incrementer)
	Btn_plus : entity work.Button_Incrementer -- buton plus instationation
	
		Generic map (
        	CLK_FREQ_HZ => 50000000,
        	DEBOUNCE_MS => 20,
			btn_val	 =>	  duty_incrementer    -- set  output to duty incrementer singal
		)
		port map (
			clk     =>      clk,                          -- system clock
			reset    =>     reset,                     -- reset button
			btn_in    =>     btn0_in,                   -- push button input (prefer active-high), set to button 0
			output   =>   plus_pulse        -- incrementer state plus

		);
--			
	Btn_minus : entity work.Button_Incrementer -- buton minus instationation
		
		Generic map (
        		CLK_FREQ_HZ => 50000000,
        		DEBOUNCE_MS => 20,
				btn_val	 =>	 -duty_incrementer    -- set to -dutyincrementer signal for minus pulse
		)
		port map (
		
			clk     =>      clk,                          -- system clock
			reset    =>     reset,                     -- reset button
			btn_in    =>     btn1_in,                   -- set to button 1
			output   =>   minus_pulse         -- incrementer state minus

		);

			
    process(clk, reset)
    begin
		  duty <= duty + plus_pulse + minus_pulse; -- increment duty cycle by pulses
        if reset = '0' then
            cnt <= 0;
            pwm_out <= "00000000";
        elsif rising_edge(clk) then
            
            if cnt = 99 then --reset 
                cnt <= 0;
            else 
                cnt <= cnt + 1; -- increment count every clock cycle
            end if;
            
            if cnt < duty then 
                pwm_out <= "1111111"; --output 0 only when count surpasses set duty cycle 
            else
                pwm_out <= "00000000";
            end if;
        end if;
    end process;

end Behavioral;
