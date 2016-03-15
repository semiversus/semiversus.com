library ieee;
use ieee.std_logic_1164.all;
 
entity led_control_fsm_tb is
end entity;

architecture behave of led_control_fsm_tb is
	signal clk : std_ulogic := '0';
	signal toggle_i : std_ulogic := '0';
	signal off_i : std_ulogic := '0';
	signal timeout_i : std_ulogic := '0';
	signal led_o : std_ulogic;
	signal timer_enable_o : std_ulogic;
	signal timer_clear_o : std_ulogic;
begin
	dut: entity work.led_control_fsm
	port map (
		clk => clk,
		toggle_i => toggle_i,
		off_i => off_i,
		timeout_i => timeout_i,
		led_o => led_o,
		timer_enable_o => timer_enable_o,
		timer_clear_o => timer_clear_o
	);

	clk <= not clk after 5 ns;

	-- Stimulus process
	stim_proc: process
	begin		
		report "testbench starting";

		-- state OFF
		wait for 20 ns;
		assert led_o='0' report "led_o should be '0' as long state OFF is present";
		assert timer_enable_o='0' report "timer_enable_o should be '0' as long state OFF is present";
		assert timer_clear_o='0' report "timer_clear_o should be '0' as long state OFF is present";

		-- press button off_i (should stay in OFF)
		off_i <= '1';
		wait for 10 ns;
		assert led_o='0' report "led_o should be '0' as long state OFF is present";
		assert timer_enable_o='0' report "timer_enable_o should be '0' as long state OFF is present";
		assert timer_clear_o='0' report "timer_clear_o should be '0' as long state OFF is present";
		off_i <= '0';

		-- signalise timeout_i (should stay in OFF)
		timeout_i <= '1';
		wait for 10 ns;
		assert led_o='0' report "led_o should be '0' as long state OFF is present";
		assert timer_enable_o='0' report "timer_enable_o should be '0' as long state OFF is present";
		assert timer_clear_o='0' report "timer_clear_o should be '0' as long state OFF is present";
		timeout_i <= '0';

		-- press button toggle_i (change from OFF to ON)
		toggle_i <= '1';
		wait for 10 ns;
		assert led_o='1' report "led_o should be '1' as long state ON is present";
		assert timer_enable_o='0' report "timer_enable_o should be '0' as long state ON is present";
		assert timer_clear_o='1' report "timer_clear_o should be '0' as long state ON is present";
		toggle_i <= '0';

		-- signalise timeout_i (should stay in ON)
		timeout_i <= '1';
		wait for 10 ns;
		assert led_o='1' report "led_o should be '1' as long state ON is present";
		assert timer_enable_o='0' report "timer_enable_o should be '0' as long state ON is present";
		assert timer_clear_o='1' report "timer_clear_o should be '0' as long state ON is present";
		timeout_i <= '0';

		-- press button off_i (change from ON to WAIT)
		off_i <= '1';
		wait for 10 ns;
		assert led_o='1' report "led_o should be '1' as long state WAIT is present";
		assert timer_enable_o='1' report "timer_enable_o should be '1' as long state WAIT is present";
		assert timer_clear_o='0' report "timer_clear_o should be '0' as long state WAIT is present";
		off_i <= '0';

		-- don't press a button (should stay in WAIT)
		wait for 10 ns;
		assert led_o='1' report "led_o should be '1' as long state WAIT is present";
		assert timer_enable_o='1' report "timer_enable_o should be '1' as long state WAIT is present";
		assert timer_clear_o='0' report "timer_clear_o should be '0' as long state WAIT is present";

		-- press button off_i (should stay in WAIT)
		off_i <= '1';
		wait for 10 ns;
		assert led_o='1' report "led_o should be '1' as long state WAIT is present";
		assert timer_enable_o='1' report "timer_enable_o should be '1' as long state WAIT is present";
		assert timer_clear_o='0' report "timer_clear_o should be '0' as long state WAIT is present";
		off_i <= '0';

		-- signalise timeout_i (change from WAIT to OFF)
		timeout_i <= '1';
		wait for 10 ns;
		assert led_o='0' report "led_o should be '0' as long state OFF is present";
		assert timer_enable_o='0' report "timer_enable_o should be '0' as long state OFF is present";
		assert timer_clear_o='0' report "timer_clear_o should be '0' as long state OFF is present";
		timeout_i <= '0';

		-- press button toggle_i (change from OFF to ON)
		toggle_i <= '1';
		wait for 10 ns;
		toggle_i <= '0';

		-- press button toggle_i (change from ON to OFF)
		toggle_i <= '1';
		wait for 10 ns;
		assert led_o='0' report "led_o should be '0' as long state OFF is present";
		assert timer_enable_o='0' report "timer_enable_o should be '0' as long state OFF is present";
		assert timer_clear_o='0' report "timer_clear_o should be '0' as long state OFF is present";
		toggle_i <= '0';

		-- press button toggle_i (change from OFF to ON)
		toggle_i <= '1';
		wait for 10 ns;
		toggle_i <= '0';

		-- press button off_i (change from ON to WAIT)
		off_i <= '1';
		wait for 10 ns;
		off_i <= '0';

		-- press button toggle_i (change from ON to OFF)
		toggle_i <= '1';
		wait for 10 ns;
		assert led_o='0' report "led_o should be '0' as long state OFF is present";
		assert timer_enable_o='0' report "timer_enable_o should be '0' as long state OFF is present";
		assert timer_clear_o='0' report "timer_clear_o should be '0' as long state OFF is present";
		toggle_i <= '0';

		report "testbench finished";
		wait;
	 end process;
end architecture;
