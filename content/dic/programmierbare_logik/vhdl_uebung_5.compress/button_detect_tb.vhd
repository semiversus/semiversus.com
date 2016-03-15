library ieee;
use ieee.std_logic_1164.all;
 
entity button_detect_tb is
end entity;

architecture behave of button_detect_tb is
		signal clk : std_ulogic := '0';
		signal button_i : std_ulogic := '0';
		signal detect_o : std_ulogic;
begin
	dut: entity work.button_detect
	port map (
		clk => clk,
		button_i => button_i,
		detect_o => detect_o
	);

	clk <= not clk after 5 ns;

	-- Stimulus process
	stim_proc: process
		variable counter : integer := 0;
	begin		
		report "testbench starting";
		
		for i in 0 to 10 loop
			wait for 10 ns;
			assert detect_o='0' report "detect_o should be '0' as no button was pressed";
		end loop;

		button_i <= '1';
		for i in 0 to 100000 loop
			wait for 10 ns;
			if detect_o='1' then
				counter := counter + 1;
			end if;
		end loop;

		assert detect_o='0' report "detect_o should be '0' as button was pressed 10 cycles ago";
		assert counter/=0 report "detect_o should be '1' for one clock cycle, but it was never the case";
		assert counter<2 report "detect_o should be '1' for one clock cycle, but it was '1' for " & integer'image(counter) & " cycles";

		button_i <= '0';
		for i in 0 to 100000 loop
			wait for 10 ns;
			assert detect_o='0' report "detect_o should be '0' as button is not pressed anymore";
		end loop;

		report "testbench finished";
		wait;
	 end process;
end architecture;

