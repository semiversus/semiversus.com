library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity blink is
	port (
		clk : in std_ulogic; -- 50 MHz clock
		led_o : out std_ulogic
	);
end entity;

architecture behave of blink is
begin
	led_o <= '1'; -- damit leuchtet die LED
end architecture;
