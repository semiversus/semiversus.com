library ieee;
use ieee.std_logic_1164.all;
 
entity lights_tb is
end entity;

architecture behave of lights_tb is
		signal clk : std_ulogic := '0';
		signal mode_i : std_ulogic := '0';
		signal leds_o : std_ulogic_vector(2 downto 0);
begin
	dut: entity work.lights
	generic map (
		COUNTER_WIDTH => 4,
		COUNTER_MAXIMUM => 1
	)
	port map (
		clk => clk,
		mode_i => mode_i,
		leds_o => leds_o
	);

	clk <= not clk after 5 ns;

	-- Stimulus process
	stim_proc: process
	begin		
		report "testbench starting";
		
		wait for 10 ns;
		assert leds_o="010" report "state should be ORANGE after initialisation";

		wait for 20 ns;
		assert leds_o="000" report "state should change to OFF after ORANGE when mode_i=0";

		wait for 20 ns;
		assert leds_o="010" report "state should change to ORANGE after OFF when mode_i=0";

		mode_i<='1';
		wait for 20 ns;
		assert leds_o="100" report "state should change to RED after ORANGE when mode_i=1";

		wait for 20 ns;
		assert leds_o="110" report "state should change to RED_ORANGE after RED when mode_i=1";

		wait for 20 ns;
		assert leds_o="001" report "state should change to GREEN after RED_ORANGE when mode_i=1";

		wait for 20 ns;
		assert leds_o="010" report "state should change to ORANGE after GREEN when mode_i=1";

		wait for 10 ns;
		assert leds_o="100" report "state should stay at RED when next_i=0";
		mode_i<='0';
		wait for 20 ns;
		assert leds_o="010" report "state should change to ORANGE after RED when mode_i=0";

		wait for 20 ns;
		assert leds_o="000" report "state should change to OFF after ORANGE when mode_i=0";

		mode_i<='1';
		wait for 20 ns;
		assert leds_o="010" report "state should change to ORANGE after OFF when mode_i=1";

		wait for 50 ns; -- change to RED_ORANGE
		assert leds_o="110" report "state should stay at RED_ORANGE when next_i=0";
		mode_i<='0';
		wait for 20 ns;
		assert leds_o="010" report "state should change to ORANGE after RED_ORANGE when mode_i=0";
		mode_i<='1';
		wait for 20 ns;
		assert leds_o="100" report "state should change to RED after ORANGE when mode_i=1";

		wait for 40 ns; -- change to GREEN
		assert leds_o="001" report "state should stay at GREEN when next_i=0";
		mode_i<='0';
		wait for 20 ns;
		assert leds_o="010" report "state should change to ORANGE after GREEN when mode_i=0";
		mode_i<='1';

		wait for 80 ns; -- change to ORANGE
		assert leds_o="010" report "state should stay at ORANGE when next_i=0";
		mode_i<='0';
		wait for 10 ns;
		assert leds_o="000" report "state should change to OFF after ORANGE when mode_i=0";
		wait for 10 ns;
		assert leds_o="000" report "state should stay at OFF when next_i=0";

		report "testbench finished";
		wait;
	 end process;
end architecture;
