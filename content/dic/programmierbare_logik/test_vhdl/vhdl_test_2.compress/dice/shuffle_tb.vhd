library ieee;
use ieee.std_logic_1164.all;
 
entity shuffle_tb is
end entity;

architecture behave of shuffle_tb is
		signal clk : std_ulogic := '0';
		signal enable_i : std_ulogic := '0';
		signal result_o : std_ulogic_vector(2 downto 0);
begin
	dut: entity work.shuffle
	port map (
		clk => clk,
		enable_i => enable_i,
		result_o => result_o
	);

	clk <= not clk after 5 ns;

	-- Stimulus process
	stim_proc: process
	begin		
		report "testbench starting";
		
		wait for 0 ns;
		assert result_o="000" report "result_o should be 000 after initialisation";

		wait for 10 ns;
		assert result_o="000" report "result_o should stay at 000 when enable_i='0'";

		enable_i <= '1';
		wait for 10 ns;
		assert result_o="000" report "result_o should stay at 000 even when enable_i changes to '1'";

		enable_i <= '0';
		wait for 10 ns;
		assert result_o="001" report "result_o should be 001 when enable_i changes to '0'";

		enable_i <= '1';
		wait for 60 ns;
		assert result_o="001" report "result_o should stay at 001 even when enable_i changes to '1'";

		enable_i <= '0';
		wait for 30 ns;
		assert result_o="001" report "result_o should be 001 after 6 clock cycles with enable_i='1'";

		enable_i <= '1';
		wait for 70 ns;
		assert result_o="001" report "result_o should stay at 001 even when enable_i changes to '1'";

		enable_i <= '0';
		wait for 30 ns;
		assert result_o="010" report "result_o should be 010 after 7 clock cycles with enable_i='1'";
		report "testbench finished";
		wait;
	 end process;
end architecture;
