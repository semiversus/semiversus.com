library ieee;
use ieee.std_logic_1164.all;

entity led_delay is
	generic (
		CLK_TIMEOUT_DIVIDER : integer := 50000000*3 -- 50Mhz*3s
	);
	port (
		clk : in std_ulogic; -- 50 MHz clock
		button_toggle_i : in std_ulogic;
		button_on_i : in std_ulogic;
		led_o : out std_ulogic
	);
end entity;

architecture behave of led_delay is
	signal toggle_detect, on_detect : std_ulogic;
	signal timeout, timer_enable, timer_clear : std_ulogic;
begin
	toggle_detect_component: entity work.button_detect
	port map (
		clk => clk,
		button_i => button_toggle_i,
		detect_o => toggle_detect
	);

	on_detect_component: entity work.button_detect
	port map (
		clk => clk,
		button_i => button_on_i,
		detect_o => on_detect
	);

	led_delay_fsm_component: entity work.led_delay_fsm
	port map (
		clk => clk,
		toggle_i => toggle_detect,
		on_i => on_detect,
		timeout_i => timeout,
		led_o => led_o,
		timer_enable_o => timer_enable,
		timer_clear_o => timer_clear
	);

	timeout_componet: entity work.counter
	generic map (
		WIDTH => 28,
		MAXIMUM => CLK_TIMEOUT_DIVIDER
	)
	port map (
		clk => clk,
		enable_i => timer_enable,
		reset_i => timer_clear,
		value_o => open,
		overflow_o => timeout
	);
end architecture;
