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
	
begin

	process(clk)
	
		variable i : INTEGER range 0 to 7 := 0;
		variable vount: INTEGER range 0 to 2 := 0;
			
		type state_type is (UPDATE_VALUE, HOLD);
		signal current_state	:	state_tyoe	:=	UPDATE_VALUE;
	begin 
		
		if rising_edge(clk)	then
			case	current_state	is
				when	UPDATE_VALUE => 
					