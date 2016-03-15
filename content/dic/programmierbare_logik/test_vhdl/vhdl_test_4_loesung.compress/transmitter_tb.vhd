library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity transmitter_tb is
end entity;

architecture behave of transmitter_tb is
		signal clk : std_ulogic := '0';
		signal button_send_i : std_ulogic := '0';
		signal switches_data_i : std_ulogic_vector(7 downto 0) := (others => '0');
		signal led_tx_o : std_ulogic;
		signal led_busy_o : std_ulogic;
		signal index : integer;
begin
	dut: entity work.transmitter
	generic map (
		BAUDRATE_WIDTH => 4,
		BAUDRATE_DIVIDER => 2
	)
	port map (
		clk => clk,
		button_send_i => button_send_i,
		switches_data_i => switches_data_i,
		led_tx_o => led_tx_o,
		led_busy_o => led_busy_o
	);

	clk <= not clk after 5 ns;

	-- Stimulus process
	stim_proc: process
	begin		
		report "testbench starting";
		
		wait for 20 ns;
		
		assert led_tx_o='1' report "tx_o should be 1 in IDLE";
		assert led_busy_o='0' report "busy_o should be 0 in IDLE";
		
		wait for 10 ns;
		
		button_send_i <= '1';
		wait for 10 ns;
		
		button_send_i <= '0';
		wait for 50 ns;
		
		assert led_tx_o='0' report "tx_o should be 0 in START";
		assert led_busy_o='1' report "busy_o should be 1 in START";
		
		for index in 0 to 7 loop
			wait for 30 ns;
			assert led_tx_o='0' report "tx_o should be 0 when sending DATA for 0x00";
			assert led_busy_o='1' report "busy_o should be 1 while sending data";
		end loop;

		wait for 30 ns;
		assert led_tx_o='1' report "tx_o should be 0 in STOP";
		assert led_busy_o='1' report "busy_o should be 1 in STOP";
		
		wait for 30 ns;
		assert led_tx_o='1' report "tx_o should be 1 in IDLE";
		assert led_busy_o='0' report "busy_o should be 0 in IDLE";
		
		switches_data_i <= "10101010";
		button_send_i <= '1';
		wait for 10 ns;
		
		button_send_i <= '0';
		wait for 40 ns;
		
		for index in 0 to 3 loop
			wait for 30 ns;
			assert led_tx_o='0' report "tx_o should be 0 when sending DATA for 0xAA";
			wait for 30 ns;
			assert led_tx_o='1' report "tx_o should be 1 when sending DATA for 0xAA";
		end loop;
		
		report "testbench finished";
		wait;
	 end process;
end architecture;

