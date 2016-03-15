library ieee;
use ieee.std_logic_1164.all;
 
entity led_toggle_fsm_tb is
end entity;

architecture behave of led_toggle_fsm_tb is
	signal clk : std_ulogic := '0';
	signal toggle_i : std_ulogic := '0';
	signal off_i : std_ulogic := '0';
	signal led1_o : std_ulogic;
	signal led2_o : std_ulogic;
begin
	dut: entity work.led_toggle_fsm
	port map (
		clk => clk,
		toggle_i => toggle_i,
		off_i => off_i,
		led1_o => led1_o,
		led2_o => led2_o
	);

	clk <= not clk after 5 ns;

	-- Stimulus process
	stim_proc: process
	begin		
		report "testbench starting";

		-- state OFF
		wait for 20 ns;
		assert led1_o='0' report "led1_o should be '0' as long state OFF is present";
		assert led2_o='0' report "led2_o should be '0' as long state OFF is present";

		-- press button toggle_i (change from OFF to LED1)
		toggle_i <= '1';
		wait for 10 ns;
		assert led1_o='1' report "led1_o should be '1' as long state LED1 is present";
		assert led2_o='0' report "led2_o should be '0' as long state LED1 is present";
		toggle_i <= '0';

		-- don't press a button (should stay in LED1)
		wait for 10 ns;
		assert led1_o='1' report "led1_o should be '1' as long state LED1 is present";
		assert led2_o='0' report "led2_o should be '0' as long state LED1 is present";

		-- press button toggle_i (change from LED1 to LED2)
		toggle_i <= '1';
		wait for 10 ns;
		assert led1_o='0' report "led1_o should be '0' as long state LED2 is present";
		assert led2_o='1' report "led2_o should be '1' as long state LED2 is present";
		toggle_i <= '0';

		-- don't press a button (should stay in LED2)
		wait for 10 ns;
		assert led1_o='0' report "led1_o should be '0' as long state LED2 is present";
		assert led2_o='1' report "led2_o should be '1' as long state LED2 is present";

		-- press button off_i (change from LED2 to OFF)
		off_i <= '1';
		wait for 10 ns;
		assert led1_o='0' report "led1_o should be '0' as long state OFF is present";
		assert led2_o='0' report "led2_o should be '0' as long state OFF is present";
		off_i <= '0';

		-- don't press a button (should stay in OFF)
		wait for 10 ns;
		assert led1_o='0' report "led1_o should be '0' as long state OFF is present";
		assert led2_o='0' report "led2_o should be '0' as long state OFF is present";

		-- press button toggle_i (change from OFF to LED1)
		toggle_i <= '1';
		wait for 10 ns;
		toggle_i <= '0';

		-- press button toggle_i (change from LED1 to LED2)
		toggle_i <= '1';
		wait for 10 ns;
		toggle_i <= '0';
		
		-- press button toggle_i (change from LED2 to LED1)
		toggle_i <= '1';
		wait for 10 ns;
		assert led1_o='1' report "led1_o should be '1' as long state LED1 is present";
		assert led2_o='0' report "led2_o should be '0' as long state LED1 is present";
		toggle_i <= '0';
		
		-- press button off_i (change from LED1 to OFF)
		off_i <= '1';
		wait for 10 ns;
		assert led1_o='0' report "led1_o should be '0' as long state OFF is present";
		assert led2_o='0' report "led2_o should be '0' as long state OFF is present";
		off_i <= '0';

		-- press button toggle_i and off_i (should stay in OFF)
		toggle_i <= '1';
		off_i <= '1';
		wait for 10 ns;
		assert led1_o='0' report "led1_o should be '0' cause off_i has priority";
		assert led2_o='0' report "led2_o should be '0' cause off_i has priority";
		off_i <= '0';
		
		-- press button toggle_i (change from OFF to LED1)
		wait for 10 ns;
		
		-- press button toggle_i and off_i (should change to OFF)
		off_i <= '1';
		wait for 10 ns;
		assert led1_o='0' report "led1_o should be '0' cause off_i has priority";
		assert led2_o='0' report "led2_o should be '0' cause off_i has priority";
		off_i <= '0';
		
		-- press button toggle_i (change from OFF to LED1 and then to LED2)
		wait for 20 ns;
		
		-- press button toggle_i and off_i (should change to OFF)
		off_i <= '1';
		wait for 10 ns;
		assert led1_o='0' report "led1_o should be '0' cause off_i has priority";
		assert led2_o='0' report "led2_o should be '0' cause off_i has priority";
		off_i <= '0';
		
		report "testbench finished";

		wait;
	 end process;
end architecture;
