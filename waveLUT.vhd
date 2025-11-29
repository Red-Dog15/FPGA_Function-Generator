library IEEE;
use IEEE.STD_Logic_1164.ALL;
Use IEEE.NUMERIC_STD.ALL; 

entity waveLUT is

	port(
		clk 	:	in	STD_LOGIC;
		wave_out	:	out	STD_LOGIC_VECTOR(7 downto 0);
		
		reset   :      in	STD_LOGIC;                     -- reset button
		btn0_in    :     in	STD_LOGIC;                   -- push button input (prefer active-high)
		btn1_in    :     in	STD_LOGIC                   -- push button input (prefer active-high)
	);
	
end waveLUT;


		
architecture Behavioral of waveLUT is

	-- create 32 element 8 bit logic array type
	type wave_logic_array is array (0 to 31) of STD_LOGIC_VECTOR(7 downto 0);
	-- instantiate logic array
	constant wave : wave_logic_array := (
	"10000000", "10011000", "10110000", "11000110", "11011010", 
    "11101010", "11110101", "11111101", "11111111", "11111101", 
    "11110101", "11101010", "11011010", "11000110", "10110000", 
    "10011000", "10000000", "01100111", "01001111", "00111001", 
    "00100101", "00010101", "00001010", "00000010", "00000000", 
    "00000010", "00001010", "00010101", "00100101", "00111001", 
    "01001111", "01100111");
	 
	
	type state_type is (UPDATE_VALUE, HOLD);
	signal current_state	:	state_type	:=	UPDATE_VALUE;
	signal max_count : INTEGER range 0 to 200000 := 20;
	
	signal plus_pulse    : integer := 0; -- hold incrementer outputs
   signal minus_pulse   : integer := 0;
	
begin

	
-- instantiate 2 instance of button incrementer, button plut (positive incrementer) & button minus (negative incrementer)
	
	Btn_plus : entity work.Button_Incrementer -- buton plus instationation
	
		Generic map (
        	CLK_FREQ_HZ => 50000000,
        	DEBOUNCE_MS => 20,
			btn_val	 =>	  1000    -- set count incrementation to 1
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
			btn_val	 =>	  -1000    -- set count incrementation to 1
		)
		port map (
		
			clk     =>      clk,                          -- system clock
			reset    =>     reset,                     -- reset button
			btn_in    =>     btn1_in,                   -- set to button 1
			output   =>   minus_pulse         -- incrementer state minus

		);

			
		
		
	process(clk)
		variable i : INTEGER range 0 to 31 := 0;
		variable count : INTEGER range 0 to 200000 := 0;
		--variable frequency : INTEGER range 20 to 100000 := (500000000 / (32 * max_count));
			
	begin 
		
		if rising_edge(clk)	then
		
		 -- Adjust max_count based on button pulses
        max_count <= max_count + plus_pulse + minus_pulse;

        -- keep max_count to valid range
        if max_count < 156 then
            max_count <= 156;
        elsif max_count > 156250 then
            max_count <= 156250;
        end if;
		  

			case	current_state	is
				when	UPDATE_VALUE => 
					wave_out <=	wave(i);
					if i = 31 then
						i:= 0;
					else
						i :=	i + 1; -- iterate index
					end if;
					count := 0;
					current_state	<=	HOLD;
					
				when	HOLD	=>
					if count >=	max_count then
						current_state <= UPDATE_VALUE;
						count := 0; -- set count back to zero
						
					else
						count := count + 1; -- iterate count
						current_state <= HOLD;
					end if;
			end case;
			-- adjust for button presses
			max_count <= max_count + plus_pulse + minus_pulse;
		
		end if;	
	end process;
end Behavioral;	