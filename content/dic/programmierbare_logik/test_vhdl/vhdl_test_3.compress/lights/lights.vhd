library ieee;
use ieee.std_logic_1164.all;

entity lights is
	generic (
		COUNTER_WIDTH : integer := 4; -- <<< TODO
		COUNTER_MAXIMUM : integer := 9 -- <<< TODO
	);
	port (
		clk : in std_ulogic; -- 50 MHz clock
		mode_i : in std_ulogic;
		leds_o : out std_ulogic_vector(2 downto 0)
	);
end entity;

architecture behave of lights is
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

	-- TODO
end architecture;
