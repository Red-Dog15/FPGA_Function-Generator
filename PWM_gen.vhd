library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PWM_gen is

    Port(
        clk        : in std_logic;
        reset      : in std_logic;
        duty       : in integer range 0 to 100;   -- duty % 
        pwm_out    : out std_logic
    );
	 
end PWM_gen;

architecture Behavioral of PWM_gen is

    signal cnt : integer range 0 to 99 := 0;

begin
    process(clk, reset)
    begin
        if reset = '0' then
            cnt <= 0;
            pwm_out <= '0';
        elsif rising_edge(clk) then
            
            if cnt = 99 then
                cnt <= 0;
            else 
                cnt <= cnt + 1;
            end if;
            
            if cnt < duty then
                pwm_out <= '1';
            else
                pwm_out <= '0';
            end if;
        end if;
    end process;

end Behavioral;
