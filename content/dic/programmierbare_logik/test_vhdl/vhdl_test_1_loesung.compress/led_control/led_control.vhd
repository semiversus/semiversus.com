library ieee;
use ieee.std_logic_1164.all;

entity led_control is
	generic (
		CLK_TIMEOUT_DIVIDER : integer := 50000000*5 -- 50Mhz*5s
	);
	port (
		clk : in std_ulogic; -- 50 MHz clock
		button_toggle_i : in std_ulogic;
		button_off_i : in std_ulogic;
		led_o : out std_ulogic
	);
end entity;

architecture behave of led_control is
	signal toggle_detect, off_detect : std_ulogic;
	signal timeout, timer_enable, timer_clear : std_ulogic;
begin
	toggle_detect_component: entity work.button_detect
	port map (
		clk => clk,
		button_i => button_toggle_i,
		detect_o => toggle_detect
	);

	off_detect_component: entity work.button_detect
	port map (
		clk => clk,
		button_i => button_off_i,
		detect_o => off_detect
	);

	led_control_fsm_component: entity work.led_control_fsm
	port map (
		clk => clk,
		toggle_i => toggle_detect,
		off_i => off_detect,
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
