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
		
		value_i<="000";
		wait for 10 ns;
		assert leds_o="0001000";

		value_i<="001";
		wait for 10ns;
		assert leds_o="0010100";

		value_i<="010";
		wait for 10ns;
		assert leds_o="0101010";

		value_i<="011";
		wait for 10ns;
		assert leds_o="1010101";

		value_i<="100";
		wait for 10ns;
		assert leds_o="1101011";

		value_i<="101";
		wait for 10ns;
		assert leds_o="1110111";

		value_i<="110";
		wait for 10ns;
		assert leds_o="0000000";

		value_i<="111";
		wait for 10ns;
		assert leds_o="0000000";

		report "testbench finished";
		wait;
	 end process;
end architecture;

