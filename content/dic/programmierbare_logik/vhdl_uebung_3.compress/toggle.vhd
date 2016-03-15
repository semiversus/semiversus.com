library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity toggle is
	port (
		clk : in std_ulogic; -- 50 MHz clock
		button_i : in std_ulogic;
		led_o : out std_ulogic
	);
end entity;

architecture behave of toggle is
begin
	led_o <= '1'; -- damit leuchtet die LED
end architecture;
