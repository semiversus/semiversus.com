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
	-- TODO
end architecture;
