library ieee;
use ieee.std_logic_1164.all;
 
entity led_delay_tb is
end entity;

architecture behave of led_delay_tb is
	signal clk : std_ulogic := '0';
	signal button_toggle_i : std_ulogic := '0';
	signal button_on_i : std_ulogic := '0';
	signal led_o : std_ulogic;
begin
	dut: entity work.led_delay
	generic map (
		CLK_TIMEOUT_DIVIDER => 5
	)
	port map (
		clk => clk,
		button_toggle_i => button_toggle_i,
		button_on_i => button_on_i,
		led_o => led_o
	);

	clk <= not clk after 5 ns;

	-- Stimulus process
	stim_proc: process
	begin		
		report "testbench starting";

		-- state OFF
		wait for 100 ns;
		assert led_o='0' report "led_o should be '0' as long state OFF is present";
		

		-- press button toggle_i (change from OFF to LIGHT)
		button_toggle_i <= '1';
		wait for 30 ns;
		assert led_o='1' report "led_o should be '1' as long state LIGHT is present";
		button_toggle_i <= '0';

		-- signalise timeout_i (should stay in LIGHT)
		wait for 100 ns;
		assert led_o='1' report "led_o should be '1' as long state LIGHT is present";
		
		-- press button on_i (should stay in LIGHT)
		button_on_i <= '1';
		wait for 30 ns;
		assert led_o='1' report "led_o should be '1' as long state LIGHT is present";
		button_on_i <= '0';
		
		-- press button toggle_i (change from LIGHT to OFF)
		button_toggle_i <= '1';
		wait for 30 ns;
		assert led_o='0' report "led_o should be '0' as long state OFF is present";
		button_toggle_i <= '0';
		
		-- press button on_i (change from OFF to DELAY)
		button_on_i <= '1';
		wait for 10 ns;
		assert led_o='0' report "led_o should be '0' as long state DELAY is present";
		button_on_i <= '0';

		-- don't press a button (should stay in DELAY)
		wait for 10 ns;
		assert led_o='0' report "led_o should be '0' as long state DELAY is present";
		
		-- press button on_i (should stay in DELAY)
		button_on_i <= '1';
		wait for 10 ns;
		assert led_o='0' report "led_o should be '0' as long state DELAY is present";
		button_on_i <= '0';

		-- signalise timeout_i (change from DELAY to LIGHT)
		wait for 50 ns;
		assert led_o='1' report "led_o should be '1' as long state LIGHT is present";

		-- press button toggle_i (change from LIGHT to OFF)
		button_toggle_i <= '1';
		wait for 10 ns;
		button_toggle_i <= '0';

		-- press button on_i (change from OFF to DELAY)
		wait for 30 ns;
		button_on_i <= '1';
		wait for 10 ns;
		button_on_i <= '0';

		-- press button toggle_i (change from DELAY to LIGHT)
		button_toggle_i <= '1';
		wait for 30 ns;
		assert led_o='1' report "led_o should be '1' as long state LIGHT is present";
		button_toggle_i <= '0';

		report "testbench finished";
		wait;
	 end process;
end architecture;

