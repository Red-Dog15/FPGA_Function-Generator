-- Testbench for Wave Multiplexer (Wave_mux)

--	Test Bench for Wave_mux

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Wave_mux_tb is
end Wave_mux_tb;

architecture Behavioral of Wave_mux_tb is
        signal clk        :  STD_LOGIC	:=	'0';
        signal reset      : STD_LOGIC := '1';
		  signal btn0_in	:  STD_LOGIC := '1';
		  signal btn1_in  :	 STD_LOGIC := '1';
		  signal sw0, sw1 :  	STD_LOGIC; 
		  signal wave_out	:		STD_LOGIC_VECTOR(7 downto 0);
		  signal LEDs	:	 std_logic_vector(2 downto 0);	
		  signal SSEG0, SSEG1 :  std_logic_vector(7 downto 0);
		  -- state LEDS
 
begin

    -- instantiate DUT
    dut : entity work.Wave_mux
        port map (
            clk      => clk,
            wave_out => wave_out,
            reset    => reset,
            btn0_in  => btn0_in,
            btn1_in  => btn1_in,
				LEDs	=> LEDs,
				sw0 => sw0,
				SSEG0	=> SSEG0,
				SSEG1	=> SSEG1
        );

	
        -- clock generation (20 ns period = 50 MHz)
    -- CLOCK PROCESS  (runs forever)

    clk_process : process
    begin
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
    end process;



    -- STIMULUS

    stim_proc : process
    begin
        -- Switches = pwm state
	sw0 <= '1';


		  
        -- global reset pulse
        reset <= '0';
        wait for 100 ns;
        reset <= '1';
        wait for 200 ns;
        
        

        -- let waveform run freely for a bit
        wait for 3 us;
        

        -- press BTN0 once (increase speed)
        btn0_in <= '0';
        wait for 21 ms; -- wait longer than 20 to activate debouncer
        btn0_in <= '1';
        wait for 200 ns;
	btn0_in <= '0';
        wait for 21 ms;
        btn0_in <= '1';
        wait for 200 ns;

        -- press BTN1 once (decrease speed)
        btn1_in <= '0';
        wait for 21 ms;
        btn1_in <= '1';
        wait for 200 ns;
    	  btn1_in <= '0';
        wait for 21 ms;
        btn1_in <= '1';
        wait for 200 ns;      
        
        

        -- let waveform run freely for a bit
        wait for 3 us;
		  
        -- Switches = wave state
	sw0 <= '0';

        -- press BTN0 once (increase speed)
        btn0_in <= '0';
        wait for 21 ms; -- wait longer than 20 to activate debouncer
        btn0_in <= '1';
        wait for 200 ns;
		  btn0_in <= '0';
        wait for 21 ms;
        btn0_in <= '1';
        wait for 200 ns;

        -- press BTN1 once (decrease speed)
        btn1_in <= '0';
        wait for 21 ms;
        btn1_in <= '1';
        wait for 200 ns;
    	  btn1_in <= '0';
        wait for 21 ms;
        btn1_in <= '1';
        wait for 200 ns;   

		  
        -- Switches = null state
		  sw0 <= '1';
		  sw1 <= '1';

        -- press BTN0 once (increase speed)
        btn0_in <= '0';
        wait for 21 ms; -- wait longer than 20 to activate debouncer
        btn0_in <= '1';
        wait for 200 ns;
		  btn0_in <= '0';
        wait for 21 ms;
        btn0_in <= '1';
        wait for 200 ns;

        -- press BTN1 once (decrease speed)
        btn1_in <= '0';
        wait for 21 ms;
        btn1_in <= '1';
        wait for 200 ns;
    	  btn1_in <= '0';
        wait for 21 ms;
        btn1_in <= '1';
        wait for 200 ns;    
		  
	wait;
        
    end process;
end Behavioral;