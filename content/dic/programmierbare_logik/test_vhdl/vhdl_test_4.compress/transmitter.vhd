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
  -- TODO: define signals
begin
  -- TODO: create instances
end architecture;
