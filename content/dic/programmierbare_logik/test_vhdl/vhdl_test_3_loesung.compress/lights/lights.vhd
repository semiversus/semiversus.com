library ieee;
use ieee.std_logic_1164.all;

entity lights is
	generic (
		COUNTER_WIDTH : integer := 26;
		COUNTER_MAXIMuM : integer := 35000000
	);
	port (
		clk : in std_ulogic; -- 50 MHz clock
		mode_i : in std_ulogic;
		leds_o : out std_ulogic_vector(2 downto 0)
	);
end entity;

architecture behave of lights is
	signal next_state : std_ulogic;
	signal lights : std_ulogic_vector(2 downto 0);
begin
	counter_component: entity work.counter
	generic map (
		WIDTH => COUNTER_WIDTH,
		MAXIMUM => COUNTER_MAXIMUM
	)
	port map (
		clk => clk,
		enable_i => '1',
		reset_i => '0',
		value_o => open,
		overflow_o => next_state
	);

	lights_fsm_component: entity work.lights_fsm
	port map (
		clk => clk,
		next_i => next_state,
		mode_i => mode_i,
		lights_o => lights
	);

	supervisor_component: entity work.supervisor
	port map (
		monitor_i => lights,
		result_o => leds_o
	);
end architecture;
