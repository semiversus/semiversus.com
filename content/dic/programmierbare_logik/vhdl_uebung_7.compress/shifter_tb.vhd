library ieee;
use ieee.std_logic_1164.all;
 
entity shifter_tb is
end entity;

architecture behave of shifter_tb is
		signal clk : std_ulogic := '0';
		signal reset_i : std_ulogic := '0';
		signal up_i : std_ulogic := '0';
		signal down_i : std_ulogic := '0';
		signal leds_o : std_ulogic_vector(3 downto 0);
begin
	dut: entity work.shifter(behave1)
	port map (
		clk => clk,
		reset_i => reset_i,
		up_i => up_i,
		down_i => down_i,
		leds_o => leds_o
	);

	clk <= not clk after 5 ns;

	-- Stimulus process
	stim_proc: process
	begin		
		report "testbench starting";
		
		wait for 0 ns;
		-- TODO

		report "testbench finished";
		wait;
	 end process;
end architecture;

