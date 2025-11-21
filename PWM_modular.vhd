library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- PWM_modular.vhd
-- Top-level module that wires Button_Incrementer to waveLUT and
-- provides an 8-bit PWM whose duty can be the LUT sample (sine)
-- or a manual duty (not implemented here). The Button_Incrementer
-- drives the `hold_count` input of `waveLUT` so button presses control
-- how many clock cycles the LUT holds each sample (i.e. slows/speeds waveform).

entity PWM_modular is
    port (
        clk       : in  std_logic;
        reset_n   : in  std_logic := '1';
        btn       : in  std_logic;                         -- push button
        mode_sw   : in  std_logic := '1';                  -- '1' = use LUT as PWM duty
        pwm_out   : out std_logic;                         -- PWM output
        lut_out   : out std_logic_vector(7 downto 0)       -- raw LUT output for DAC/debug
    );
end PWM_modular;

architecture Behavioral of PWM_modular is

    signal hold_count_sig : std_logic_vector(7 downto 0) := (others => '0');
    signal lut_sample     : std_logic_vector(7 downto 0);
    signal pwm_counter    : unsigned(7 downto 0) := (others => '0');
    signal duty           : unsigned(7 downto 0) := (others => '0');

    component Button_Incrementer
        generic (
            CLK_FREQ_HZ : integer := 50000000;
            DEBOUNCE_MS : integer := 20;
            STEP        : natural := 1
        );
        port (
            clk       : in  std_logic;
            reset_n   : in  std_logic;
            btn_in    : in  std_logic;
            count_out : out std_logic_vector(7 downto 0)
        );
    end component;

    component waveLUT
        port (
            clk        : in  std_logic;
            hold_count : in  std_logic_vector(7 downto 0);
            wave_out   : out std_logic_vector(7 downto 0)
        );
    end component;

begin

    -- Instantiate Button_Incrementer: button controls hold_count (how long LUT holds each sample)
    BI_inst : Button_Incrementer
        generic map (
            CLK_FREQ_HZ => 50000000,
            DEBOUNCE_MS => 20,
            STEP        => 1
        )
        port map (
            clk       => clk,
            reset_n   => reset_n,
            btn_in    => btn,
            count_out => hold_count_sig
        );

    -- Instantiate waveLUT with button-controlled hold_count
    LUT_inst : waveLUT
        port map (
            clk => clk,
            hold_count => hold_count_sig,
            wave_out => lut_sample
        );

    lut_out <= lut_sample;

    -- PWM generator: use LUT sample as duty when mode_sw='1'
    process(clk)
    begin
        if rising_edge(clk) then
            pwm_counter <= pwm_counter + 1;
            if mode_sw = '1' then
                duty <= unsigned(lut_sample);
            else
                duty <= unsigned(hold_count_sig); -- fallback: use hold_count as duty if not using LUT
            end if;

            if pwm_counter < duty then
                pwm_out <= '1';
            else
                pwm_out <= '0';
            end if;
        end if;
    end process;

end Behavioral;
