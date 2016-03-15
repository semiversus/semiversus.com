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

		-- TODO		

		report "testbench finished";
		wait;
	 end process;
end architecture;
