library ieee;
use ieee.std_logic_1164.all;
 
entity dice_tb is
end entity;

architecture behave of dice_tb is
		signal clk : std_ulogic := '0';
		signal button_enable_i : std_ulogic := '0';
		signal leds_o : std_ulogic_vector(6 downto 0);
begin
	dut: entity work.dice
	port map (
		clk => clk,
		button_enable_i => button_enable_i,
		leds_o => leds_o
	);

	clk <= not clk after 5 ns;

	-- Stimulus process
	stim_proc: process
	begin		
		report "testbench starting";
		
		wait for 10 ns;
		assert leds_o="0001000" report "leds_o should stay at 0001000 when enable_i='0'";

		button_enable_i <= '1';
		wait for 10 ns;
		assert leds_o="0001000" report "leds_o should stay at 0001000 even when button_enable_i changes to '1'";

		button_enable_i <= '0';
		wait for 10 ns;
		assert leds_o="0010100" report "leds_o should be 0010100 when button_enable_i changes to '0'";

		button_enable_i <= '1';
		wait for 60 ns;
		assert leds_o="0010100" report "leds_o should stay at 0010100 even when button_enable_i changes to '1'";

		button_enable_i <= '0';
		wait for 30 ns;
		assert leds_o="0010100" report "leds_o should be 0010100 after 6 clock cycles with button_enable_i='1'";

		button_enable_i <= '1';
		wait for 70 ns;
		assert leds_o="0010100" report "leds_o should stay at 0010100 even when button_enable_i changes to '1'";

		button_enable_i <= '0';
		wait for 30 ns;
		assert leds_o="0101010" report "leds_o should be 0101010 after 7 clock cycles with button_enable_i='1'";
		report "testbench finished";
		wait;
	 end process;
end architecture;
