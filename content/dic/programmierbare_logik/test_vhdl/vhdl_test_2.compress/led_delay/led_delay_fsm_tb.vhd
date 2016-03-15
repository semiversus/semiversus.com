library ieee;
use ieee.std_logic_1164.all;
 
entity led_delay_fsm_tb is
end entity;

architecture behave of led_delay_fsm_tb is
	signal clk : std_ulogic := '0';
	signal toggle_i : std_ulogic := '0';
	signal on_i : std_ulogic := '0';
	signal timeout_i : std_ulogic := '0';
	signal led_o : std_ulogic;
	signal timer_enable_o : std_ulogic;
	signal timer_clear_o : std_ulogic;
begin
	dut: entity work.led_delay_fsm
	port map (
		clk => clk,
		toggle_i => toggle_i,
		on_i => on_i,
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
		assert timer_clear_o='1' report "timer_clear_o should be '1' as long state OFF is present";

		-- signalise timeout_i (should stay in OFF)
		timeout_i <= '1';
		wait for 10 ns;
		assert led_o='0' report "led_o should be '0' as long state OFF is present";
		assert timer_enable_o='0' report "timer_enable_o should be '0' as long state OFF is present";
		assert timer_clear_o='1' report "timer_clear_o should be '1' as long state OFF is present";
		timeout_i <= '0';

		-- press button toggle_i (change from OFF to LIGHT)
		toggle_i <= '1';
		wait for 10 ns;
		assert led_o='1' report "led_o should be '1' as long state LIGHT is present";
		assert timer_enable_o='0' report "timer_enable_o should be '0' as long state LIGHT is present";
		assert timer_clear_o='0' report "timer_clear_o should be '0' as long state LIGHT is present";
		toggle_i <= '0';

		-- signalise timeout_i (should stay in LIGHT)
		timeout_i <= '1';
		wait for 10 ns;
		assert led_o='1' report "led_o should be '1' as long state LIGHT is present";
		assert timer_enable_o='0' report "timer_enable_o should be '0' as long state LIGHT is present";
		assert timer_clear_o='0' report "timer_clear_o should be '0' as long stateLIGHT is present";
		timeout_i <= '0';
		
		-- press button on_i (should stay in LIGHT)
		on_i <= '1';
		wait for 10 ns;
		assert led_o='1' report "led_o should be '1' as long state LIGHT is present";
		assert timer_enable_o='0' report "timer_enable_o should be '0' as long state LIGHT is present";
		assert timer_clear_o='0' report "timer_clear_o should be '0' as long state LIGHT is present";
		on_i <= '0';
		
		-- press button toggle_i (change from LIGHT to OFF)
		toggle_i <= '1';
		wait for 10 ns;
		assert led_o='0' report "led_o should be '0' as long state OFF is present";
		assert timer_enable_o='0' report "timer_enable_o should be '0' as long state OFF is present";
		assert timer_clear_o='1' report "timer_clear_o should be '1' as long state OFF is present";
		toggle_i <= '0';
		
		-- press button on_i (change from OFF to DELAY)
		on_i <= '1';
		wait for 10 ns;
		assert led_o='0' report "led_o should be '0' as long state DELAY is present";
		assert timer_enable_o='1' report "timer_enable_o should be '1' as long state DELAY is present";
		assert timer_clear_o='0' report "timer_clear_o should be '0' as long state DELAY is present";
		on_i <= '0';

		-- don't press a button (should stay in DELAY)
		wait for 10 ns;
		assert led_o='0' report "led_o should be '0' as long state DELAY is present";
		assert timer_enable_o='1' report "timer_enable_o should be '1' as long state DELAY is present";
		assert timer_clear_o='0' report "timer_clear_o should be '0' as long state DELAY is present";

		-- press button on_i (should stay in DELAY)
		on_i <= '1';
		wait for 10 ns;
		assert led_o='0' report "led_o should be '0' as long state DELAY is present";
		assert timer_enable_o='1' report "timer_enable_o should be '1' as long state DELAY is present";
		assert timer_clear_o='0' report "timer_clear_o should be '0' as long state DELAY is present";
		on_i <= '0';

		-- signalise timeout_i (change from DELAY to LIGHT)
		timeout_i <= '1';
		wait for 10 ns;
		assert led_o='1' report "led_o should be '1' as long state LIGHT is present";
		assert timer_enable_o='0' report "timer_enable_o should be '0' as long state LIGHT is present";
		assert timer_clear_o='0' report "timer_clear_o should be '0' as long state LIGHT is present";
		timeout_i <= '0';

		-- press button toggle_i (change from LIGHT to OFF)
		toggle_i <= '1';
		wait for 10 ns;
		toggle_i <= '0';

		-- press button on_i (change from OFF to DELAY)
		on_i <= '1';
		wait for 10 ns;
		on_i <= '0';

		-- press button toggle_i (change from DELAY to LIGHT)
		toggle_i <= '1';
		wait for 10 ns;
		assert led_o='1' report "led_o should be '1' as long state LIGHT is present";
		assert timer_enable_o='0' report "timer_enable_o should be '0' as long state LIGHT is present";
		assert timer_clear_o='0' report "timer_clear_o should be '0' as long state LIGHT is present";
		toggle_i <= '0';

		report "testbench finished";
		wait;
	 end process;
end architecture;
