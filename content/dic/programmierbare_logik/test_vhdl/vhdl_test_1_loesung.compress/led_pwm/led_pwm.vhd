library ieee;
use ieee.std_logic_1164.all;

entity led_pwm is
	generic (
		PWM_WIDTH : integer := 3
	);
	port (
		clk : in std_ulogic; -- 50 MHz clock
		button_up_i : in std_ulogic;
		button_down_i : in std_ulogic;
		led_o : out std_ulogic
	);
end entity;

architecture behave of led_pwm is
	signal up_detect, down_detect : std_ulogic;
	signal level : std_ulogic_vector(PWM_WIDTH-1 downto 0);
begin
	up_detect_component: entity work.button_detect
	port map (
		clk => clk,
		button_i => button_up_i,
		detect_o => up_detect
	);

	down_detect_component: entity work.button_detect
	port map (
		clk => clk,
		button_i => button_down_i,
		detect_o => down_detect
	);
	
	level_adjust_component: entity work.level_adjust
	generic map (
		WIDTH => PWM_WIDTH
	)
	port map (
		clk => clk,
		up_i => up_detect,
		down_i => down_detect,
		level_o => level
	);
	
	pwm_generator_component: entity work.pwm_generator
	generic map (
		WIDTH => PWM_WIDTH
	)
	port map (
		clk => clk,
		level_i => level,
		pwm_o => led_o
	);
end architecture;
