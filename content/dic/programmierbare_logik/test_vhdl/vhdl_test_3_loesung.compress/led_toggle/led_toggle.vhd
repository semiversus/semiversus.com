library ieee;
use ieee.std_logic_1164.all;

entity led_toggle is
	port (
		clk : in std_ulogic; -- 50 MHz clock
		button_toggle_i : in std_ulogic;
		button_off_i : in std_ulogic;
		led_o : out std_ulogic
	);
end entity;

architecture behave of led_toggle is
	signal toggle_detect, on_detect : std_ulogic;
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
		button_i => button_on_i,
		detect_o => on_detect
	);

	led_toggle_fsm_component: entity work.led_toggle_fsm
	port map (
		clk => clk,
		toggle_i => toggle_detect,
		off_i => off_detect,
		led1_o => led1_o,
		led2_o => led2_o
	);
end architecture;