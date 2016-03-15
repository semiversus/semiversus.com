library ieee;
use ieee.std_logic_1164.all;
 
entity supervisor_tb is
end entity;

architecture behave of supervisor_tb is
		signal monitor_i : std_ulogic_vector (2 downto 0) := "000";
		signal result_o : std_ulogic_vector (2 downto 0) := "000";
begin
	dut: entity work.supervisor(behave1)
	port map (
		monitor_i => monitor_i,
		result_o => result_o
	);

	-- Stimulus process
	stim_proc: process
	begin		
		report "testbench starting";
		
		monitor_i<="000";
		wait for 10 ns;
		assert result_o="000";

		monitor_i<="001";
		wait for 10ns;
		assert result_o="001";

		monitor_i<="010";
		wait for 10ns;
		assert result_o="010";

		monitor_i<="011";
		wait for 10ns;
		assert result_o="100";

		monitor_i<="100";
		wait for 10ns;
		assert result_o="100";

		monitor_i<="101";
		wait for 10ns;
		assert result_o="100";

		monitor_i<="110";
		wait for 10ns;
		assert result_o="110";

		monitor_i<="111";
		wait for 10ns;
		assert result_o="100";

		report "testbench finished";
		wait;
	 end process;
end architecture;
