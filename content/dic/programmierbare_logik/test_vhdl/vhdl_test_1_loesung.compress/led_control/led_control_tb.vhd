library ieee;
use ieee.std_logic_1164.all;
 
entity led_control_tb is
end entity;

architecture behave of led_control_tb is
	signal clk : std_ulogic := '0';
	signal button_toggle_i : std_ulogic := '0';
	signal button_off_i : std_ulogic := '0';
	signal led_o : std_ulogic;
begin
	dut: entity work.led_control
	generic map (
		CLK_TIMEOUT_DIVIDER => 5
	)
	port map (
		clk => clk,
		button_toggle_i => button_toggle_i,
		button_off_i => button_off_i,
		led_o => led_o
	);

	clk <= not clk after 5 ns;

	-- Stimulus process
	stim_proc: process
	begin		
		report "testbench starting";

		-- state OFF 
		wait for 100 ns; -- test for timeout
		assert led_o='0' report "led_o should be '0' as long state OFF is present";

		-- press button off_i (should stay in OFF)
		button_off_i <= '1';
		wait for 100 ns;
		assert led_o='0' report "led_o should be '0' as long state OFF is present";
		button_off_i <= '0';

		-- press button toggle_i (change from OFF to ON)
		button_toggle_i <= '1';
		wait for 100 ns;
		assert led_o='1' report "led_o should be '1' as long state ON is present";
		button_toggle_i <= '0';

		-- press button off_i (change from ON to WAIT)
		button_off_i <= '1';
		wait for 50 ns;
		assert led_o='1' report "led_o should be '1' as long state WAIT is present";
		button_off_i <= '0';

		-- wait for timeout (change from WAIT to ON)
		wait for 50 ns;
		assert led_o='0' report "led_o should be '0' as long state OFF is present";

		-- press button toggle_i (change from OFF to ON)
		button_toggle_i <= '1';
		wait for 100 ns;
		button_toggle_i <= '0';

		wait for 20 ns;

		-- press button toggle_i (change from ON to OFF)
		button_toggle_i <= '1';
		wait for 100 ns;
		assert led_o='0' report "led_o should be '0' as long state OFF is present";
		button_toggle_i <= '0';

		wait for 20 ns;

		-- press button toggle_i (change from OFF to ON)
		button_toggle_i <= '1';
		wait for 100 ns;
		button_toggle_i <= '0';

		-- press button off_i (change from ON to WAIT)
		button_off_i <= '1';
		wait for 20 ns;
		button_off_i <= '0';

		-- press button toggle_i (change from ON to OFF)
		button_toggle_i <= '1';
		wait for 20 ns;
		assert led_o='0' report "led_o should be '0' as long state OFF is present";

		report "testbench finished";
		wait;
	 end process;
end architecture;

