library ieee;
use ieee.std_logic_1164.all;
 
entity stopwatch_fsm_simple_tb is
end entity;

architecture behave of stopwatch_fsm_simple_tb is
		signal clk : std_ulogic := '0';
		signal button_ss_i : std_ulogic := '0';
		signal button_rl_i : std_ulogic := '0';
		signal mode_o : std_ulogic;
		signal enable_o : std_ulogic;
		signal clear_o : std_ulogic;
begin
	dut: entity work.stopwatch_fsm
	port map (
		clk => clk,
		ss_i => button_ss_i,
		rl_i => button_rl_i,
		mode_o => mode_o,
		enable_o => enable_o,
		clear_o => clear_o
	);

	clk <= not clk after 5 ns;

	-- Stimulus process
	stim_proc: process
	begin		
		report "testbench starting";

		-- state CLEARED
		wait for 20 ns;
		assert clear_o='1' report "clear_o should be '1' as long state CLEARED is present";

		-- press button RL (should stay in CLEARED)
		button_rl_i <= '1';
		wait for 10 ns;
		assert clear_o='1' report "clear_o should be '1' as long state CLEARED is present";
		button_rl_i <= '0';

		-- don't press a button (should stay in CLEARED)
		wait for 10 ns;
		assert clear_o='1' report "clear_o should be '1' as long state CLEARED is present";

		-- press button SS (change from CLEARED to RUNNING)
		button_ss_i <= '1';
		wait for 10 ns;
		assert enable_o='1' report "enable_o should be '1' as long state RUNNING is present";
		assert clear_o='0' report "clear_o should be '0' as long state RUNNING is present";
		button_ss_i <= '0';
		
		-- don't press a button (should stay in RUNNING)
		wait for 10 ns;
		assert enable_o='1' report "enable_o should be '1' as long state RUNNING is present";
		assert clear_o='0' report "clear_o should be '0' as long state RUNNING is present";
		
		-- press button SS (change from RUNNING to STOPPED)
		button_ss_i <= '1';
		wait for 10 ns;
		assert enable_o='0' report "enable_o should be '0' as long state STOPPED is present";
		assert clear_o='0' report "clear_o should be '0' as long state STOPPED is present";
		button_ss_i <= '0';

		-- don't press a button (should stay in STOPPED)
		wait for 10 ns;
		assert enable_o='0' report "enable_o should be '0' as long state STOPPED is present";
		assert clear_o='0' report "clear_o should be '0' as long state STOPPED is present";

		-- press button SS (change from STOPPED to RUNNING)
		button_ss_i <= '1';
		wait for 10 ns;
		assert enable_o='1' report "enable_o should be '1' as long state RUNNING is present";
		assert clear_o='0' report "clear_o should be '0' as long state RUNNING is present";
		button_ss_i <= '0';

		-- press button SS (change from RUNNING to STOPPED)
		button_ss_i <= '1';
		wait for 10 ns;
		assert enable_o='0' report "enable_o should be '0' as long state STOPPED is present";
		assert clear_o='0' report "clear_o should be '0' as long state STOPPED is present";
		button_ss_i <= '0';

		-- press button RL (change from STOPPED to CLEARED)
		button_rl_i <= '1';
		wait for 10 ns;
		assert clear_o='1' report "clear_o should be '1' as long state CLEARED is present";
		button_rl_i <= '0';


		report "testbench finished";
		wait;
	 end process;
end architecture;


