library ieee;
use ieee.std_logic_1164.all;

entity transmitter is
	generic (
		BAUDRATE_WIDTH : integer := 16;
		BAUDRATE_DIVIDER : integer := 50000
	);
	port (
		clk : in std_ulogic; -- 50 MHz clock
		button_send_i : in std_ulogic;
		switches_data_i : in std_ulogic_vector(7 downto 0);
		led_busy_o : out std_ulogic;
		led_tx_o : out std_ulogic
	);
end entity;

architecture behave of transmitter is
	signal send_detect : std_ulogic;
begin
	send_detect_component: entity work.button_detect
	port map (
		clk => clk,
		button_i => button_send_i,
		detect_o => send_detect
	);

	uart_tx_component: entity work.uart_tx
	generic map (
		BAUDRATE_WIDTH => BAUDRATE_WIDTH,
		BAUDRATE_DIVIDER => BAUDRATE_DIVIDER
	)
	port map (
		clk => clk,
		send_i => send_detect,
		data_i => switches_data_i,
		tx_o => led_tx_o,
		busy_o => led_busy_o
	);
end architecture;