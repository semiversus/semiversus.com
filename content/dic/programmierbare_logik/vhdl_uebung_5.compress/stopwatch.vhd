library ieee;
use ieee.std_logic_1164.all;

entity stopwatch is
	port (
		clk : in std_ulogic; -- 50 MHz clock
		button_ss_i : in std_ulogic;
		button_rl_i : in std_ulogic;
		segments_o : out std_ulogic_vector(7 downto 0); -- segments ".ABCDEFG"
		an_o : out std_ulogic_vector(3 downto 0)
	);
end entity;

architecture behave of stopwatch is
	signal digit0, digit0_reg : std_ulogic_vector(3 downto 0); -- Zehntelsekunden
	signal digit1, digit1_reg : std_ulogic_vector(3 downto 0); -- Sekunden Einerstelle
	signal digit2, digit2_reg : std_ulogic_vector(3 downto 0); -- Sekunden Zehnerstelle
	signal digit3, digit3_reg : std_ulogic_vector(3 downto 0); -- Minuten
	signal tenth_second_enable, second_enable, ten_second_enable, minute_enable : std_ulogic;
	signal enable, clear, mode : std_ulogic;
	signal button_ss_detect, button_rl_detect : std_ulogic;
begin
	-- TODO
end architecture;
