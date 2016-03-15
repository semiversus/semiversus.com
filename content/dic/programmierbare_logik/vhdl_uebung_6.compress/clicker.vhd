library ieee;
use ieee.std_logic_1164.all;

entity clicker is
	port (
		clk : in std_ulogic; -- 50 MHz clock
		button_tap_i : in std_ulogic;
		button_reset_i : in std_ulogic;
		segments_o : out std_ulogic_vector(7 downto 0); -- segments ".ABCDEFG"
		an_o : out std_ulogic_vector(3 downto 0)
	);
end entity;

architecture behave of clicker is
begin
	-- TODO
end architecture;