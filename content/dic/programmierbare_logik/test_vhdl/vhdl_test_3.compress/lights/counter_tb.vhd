library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity counter_tb is
end entity;

architecture behave of counter_tb is
		constant WIDTH : integer := 4;
		constant MAXIMUM : integer := 9;
		signal clk : std_ulogic := '0';
		signal reset_i : std_ulogic := '0';
		signal enable_i : std_ulogic := '0';
		signal value_o : std_ulogic_vector(WIDTH-1 downto 0);
		signal overflow_o : std_ulogic;
begin
	dut: entity work.counter
	generic map (
		WIDTH => WIDTH,
		MAXIMUM => MAXIMUM
	)
	port map (
		clk => clk,
		reset_i => reset_i,
		enable_i => enable_i,
		value_o => value_o,
		overflow_o => overflow_o
	);

	clk <= not clk after 5 ns;

	-- Stimulus process
	stim_proc: process
	begin		
		report "testbench starting";
		
		wait for 100 ns;
		assert value_o=std_ulogic_vector(to_unsigned(0, WIDTH)) report "counter should not count if enable_i='0'";

		enable_i <= '1'; -- enable counting

		for i in 1 to MAXIMUM loop
			wait for 10 ns;
			assert value_o=std_ulogic_vector(to_unsigned(i, WIDTH)) report "value_o should correspond to " & integer'image(i);
			if i=MAXIMUM then
				assert overflow_o='1' report "overflow_o should be '1' (last possible value of counter)";
			else
				assert overflow_o='0' report "overflow_o should be '0'";
			end if;
		end loop;

		wait for 10 ns;
		assert value_o=(others=>'0') report "value_o should correspond to 0 (overflow happened)";
		assert overflow_o='0' report "overflow_o should be '0'";

		wait for 10 ns;

		enable_i <= '0'; -- disable counting
		wait for 30 ns;
		assert value_o=(0=>'1', others=>'0') report "value_o should correspond to 1, because enable is not set";
		assert overflow_o='0' report "overflow_o should be '0'";

		reset_i <= '1'; -- clear the counter
		wait for 10 ns;
		assert value_o=(others=>'0') report "value_o should correspond to 0 (reset happened)";
		assert overflow_o='0' report "overflow_o should be '0'";
		
		enable_i <= '1'; -- enable counting (but reset is still active)
		wait for 10 ns;
		assert value_o=(others=>'0') report "value_o should correspond to 0 (reset active)";
		assert overflow_o='0' report "overflow_o should be '0'";

		reset_i <= '0'; -- deactivate reset
		for i in 1 to MAXIMUM loop
			wait for 10 ns;
		end loop;
		
		assert value_o=std_ulogic_vector(to_unsigned(MAXIMUM, WIDTH)) report "value_o should correspond to MAXIMUM";
		assert overflow_o='1' report "overflow_o should be '1'";

		enable_i <= '0'; -- disable counting
		wait for 10 ns;
		assert value_o=std_ulogic_vector(to_unsigned(MAXIMUM, WIDTH)) report "value_o should correspond to MAXIMUM";
		assert overflow_o='0' report "overflow_o should be '0'";

		enable_i <= '1'; -- enable counting
		wait for 1 ns;
		assert overflow_o='1' report "overflow_o should be '1'";
		wait for 9 ns;
		assert value_o=(others=>'0') report "value_o should correspond to 0 (overflow happened)";
		assert overflow_o='0' report "overflow_o should be '0'";

		report "testbench finished";
		wait;
	 end process;
end architecture;
