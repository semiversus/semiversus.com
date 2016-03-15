library ieee;
use ieee.std_logic_1164.all;

entity testbench is
	port (
		clk : in std_ulogic; -- 50 MHz clock
		button_up_i : in std_ulogic;
		button_down_i : in std_ulogic;
		button_reset_i : in std_ulogic;
		leds_o : out std_ulogic_vector(3 downto 0)
	);
end entity;

architecture behave of testbench is
	signal up_detect, down_detect : std_ulogic;
begin
	up_component: entity button_detect
	port map (
		clk => clk,
		button_i => button_up_i,
		detect_o => up_detect
	);

	down_component: entity button_detect
	port map (
		clk => clk,
		button_i => button_down_i,
		detect_o => down_detect
	);

	shifter_component: entity shifter(behave1)
	port map (
		clk => clk,
		reset_i => button_reset_i,
		up_i => up_detect,
		down_i => down_detect,
		leds_o => leds_o
	);
end architecture;
