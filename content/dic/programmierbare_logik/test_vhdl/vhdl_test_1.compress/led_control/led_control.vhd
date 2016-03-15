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

	-- TODO
end architecture;
