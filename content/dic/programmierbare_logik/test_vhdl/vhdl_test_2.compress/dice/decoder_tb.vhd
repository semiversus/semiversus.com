library ieee;
use ieee.std_logic_1164.all;
 
entity decoder_tb is
end entity;

architecture behave of decoder_tb is
		signal value_i : std_ulogic_vector (2 downto 0) := "000";
		signal leds_o : std_ulogic_vector (6 downto 0) := "0000000";
begin
	dut: entity work.decoder(behave4)
	port map (
		value_i => value_i,
		leds_o => leds_o
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

