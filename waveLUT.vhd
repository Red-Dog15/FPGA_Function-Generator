library IEEE;
use IEEE.STD_Logic_1164.ALL;
Use IEEE.NUMERIC_STD.ALL; 

entity waveLUT is
	port(
		clk 	:	in	STD_LOGIC;
		wave_out	:	out	INTEGER	:=	0
	);
end waveLUT;

architecture Behavioral of waveLUT is

	type wave_array is array (0 to 7) of INTEGER;
	constant wave	:	wave_array	:=	(0,1,2,1,0,-1,-2,-1);
	
	type state_type is (UPDATE_VALUE, HOLD);
	signal current_state	:	state_type	:=	UPDATE_VALUE;
		
begin

	process(clk)
	
		variable i : INTEGER range 0 to 7 := 0;
		variable count: INTEGER range 0 to 2 := 0;
			
		
	begin 
		
		if rising_edge(clk)	then
			case	current_state	is
				when	UPDATE_VALUE => 
					wave_out <=	wave(i);
					if i = 7 then
						i:= 0;
					else
						i :=	i + 1; -- iterate index
					end if;
					count := 0;
					current_state	<=	HOLD;
					
				when	HOLD	=>
					if count =	2 then
						current_state <= UPDATE_VALUE;
						
					else
						count := count + 1; -- iterate count
						current_state <= HOLD;
					end if;
			end case;
		end if;	
	end process;
end Behavioral;	