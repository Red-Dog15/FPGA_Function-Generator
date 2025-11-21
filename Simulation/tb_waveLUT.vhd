--	Test Bench for Wavelut

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity waveLUT_tb is
end waveLUT_tb;

architecture Behavioral of waveLUT_tb is
	signal clk	:	STD_LOGIC	:=	'0';
	signal wave_out	:	STD_LOGIC_VECTOR(7 DOWNTO 0);
	signal reset    : STD_LOGIC := '0';
    	signal btn0_in  : STD_LOGIC := '0';
    	signal btn1_in  : STD_LOGIC := '0';

	component waveLUT
		Port	(
		clk: in STD_LOGIC; 
		wave_out	: 	out	STD_LOGIC_VECTOR;
		reset   :      in	STD_LOGIC;                     -- reset button
		btn0_in    :     in	STD_LOGIC;                   -- push button input (prefer active-high)
		btn1_in    :     in	STD_LOGIC                   -- push button input (prefer active-high));
		);
	end component;	
begin
	--Instantiate DUT
	dut:	waveLUT	
	port map (
		clk => clk,	
		wave_out => wave_out,	
		reset => reset,	                    -- reset button
		btn0_in => btn0_in,	                   -- push button input (prefer active-high)
		btn1_in => btn1_in                    -- push button input (prefer active-high));
	)
	
        -- clock generation (20 ns period = 50 MHz)
	clk_process : process
	begin
	        wait for 500 ns;

        -- 1) Apply Reset
      
	        reset <= '1';
      		wait for 50 ns;
        	reset <= '0';
        	wait for 50 ns;

	-- 2) Let waveform run normally for a period

		for i in 0 to 200 loop -- 200 clock cycles
			clk <= '0';
			wait for 10 ns;
			clk <= '1'; 
			wait for 10 ns;
		end loop;
		


        -- 3) Push button 0 (increment speed)


		for i in 0 to 400 loop -- 200 clock cycles
		
			if count < 100;
				btn0_in <= 0;
				count <= count + 1;
				
				clk <= '0';
				wait for 10 ns;
				clk <= '1'; 
				wait for 10 ns;

        -- 3) Push button 1 (decrement speed)		
			else if count = 100 then
				btn1_in <= 1;
				clk <= '0';
				wait for 10 ns;
				clk <= '1'; 
				wait for 10 ns;
				
		end loop;
	
		wait;
	end process;
	
end Behavioral;