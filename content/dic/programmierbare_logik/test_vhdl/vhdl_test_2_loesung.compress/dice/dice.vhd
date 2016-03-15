library ieee;
use ieee.std_logic_1164.all;

entity dice is
	port (
		clk : in std_ulogic; -- 50 MHz clock
		button_enable_i : in std_ulogic;
		leds_o : out std_ulogic_vector(6 downto 0)
	);
end entity;

architecture behave of dice is
	signal value : std_ulogic_vector(2 downto 0);
begin
	shuffle_component: entity work.shuffle
	port map (
		clk => clk,
		enable_i => button_enable_i,
		result_o => value
	);

	decoder_component: entity work.decoder
	port map (
		value_i => value,
		leds_o => leds_o
	);
end architecture;