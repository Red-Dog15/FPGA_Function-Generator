--	Test Bench for Wavelut

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity waveLUT_tb is
end waveLUT_tb;

architecture Behavioral of waveLUT_tb is
	signal clk	:	STD_LOGIC	:=	'0';
	signal wave_out	:	STD_LOGIC_VECTOR(7 DOWNTO 0);
	signal reset    : STD_LOGIC := '1';
    	signal btn0_in  : STD_LOGIC := '1';
    	signal btn1_in  : STD_LOGIC := '1';

begin
    -- instantiate DUT
    dut : entity work.waveLUT
        port map (
            clk      => clk,
            wave_out => wave_out,
            reset    => reset,
            btn0_in  => btn0_in,
            btn1_in  => btn1_in
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
	wait;
        
    end process;
end Behavioral;