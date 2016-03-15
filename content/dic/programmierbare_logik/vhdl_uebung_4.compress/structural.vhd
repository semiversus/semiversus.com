library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity structural is
	port (
		clk : in std_ulogic; -- 50 MHz clock
		button_i : in std_ulogic;
		segments_o : out std_ulogic_vector(6 downto 0); -- segments "ABCDEFG"
		an_o : out std_ulogic_vector(3 downto 0)
	);
end entity;

architecture behave of structural is
begin
	display_component: entity work.display
		port map (
			clk => clk,
			digit0_i => "0011",
			digit1_i => "0010",
			digit2_i => "0001",
			digit3_i => "0000",
			segments_o => segments_o,
			an_o => an_o
		);
end architecture;
