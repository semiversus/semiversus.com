library ieee;
use ieee.std_logic_1164.all;

entity led_pwm is
	generic (
		PWM_WIDTH : integer := 3
	);
	port (
		clk : in std_ulogic; -- 50 MHz clock
		button_up_i : in std_ulogic;
		button_down_i : in std_ulogic;
		led_o : out std_ulogic
	);
end entity;

architecture behave of led_pwm is
	signal up_detect, down_detect : std_ulogic;
	signal level : std_ulogic_vector(PWM_WIDTH-1 downto 0);
begin
	-- TODO
end architecture;
