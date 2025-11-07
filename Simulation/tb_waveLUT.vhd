--	Test Bench for Wavelut

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity waveLUT_tb is
end waveLUT_tb;

architecture Behavioral of waveLUT_tb is
	signal clk	:	STD_LOGIC	:=	'0';
	signal wave_out	:	INTEGER;
	
	component waveLUT
		Port (clk: in STD_LOGIC; wave_out	: 	out	INTEGER);
	end component;	
begin
	--Instantiate DUT
	dut:	waveLUT	port map (clk => clk,	wave_out => wave_out);
	
	--clock generation
	clk_process : process
	begin
		for i in 0 to 49 loop -- 50 clock cycles
			clk <= '0';
			wait for 10 ns;
			clk <= '1'; wait for 10 ns;
		end loop;
		wait;
	end process;
	
end Behavioral;