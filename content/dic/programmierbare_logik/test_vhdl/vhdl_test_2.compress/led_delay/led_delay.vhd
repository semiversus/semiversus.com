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

	-- TODO

end architecture;
