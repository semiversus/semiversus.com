library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity uart_tx_tb is
end entity;

architecture behave of uart_tx_tb is
		signal clk : std_ulogic := '0';
		signal send_i : std_ulogic := '0';
		signal data_i : std_ulogic_vector(7 downto 0) := (others => '0');
		signal tx_o : std_ulogic;
		signal busy_o : std_ulogic;
		signal index : integer;
begin
	dut: entity work.uart_tx
	generic map (
		BAUDRATE_WIDTH => 4,
		BAUDRATE_DIVIDER => 2
	)
	port map (
		clk => clk,
		send_i => send_i,
		data_i => data_i,
		tx_o => tx_o,
		busy_o => busy_o
	);

	clk <= not clk after 5 ns;

	-- Stimulus process
	stim_proc: process
	begin		
		report "testbench starting";
		
		wait for 20 ns;
		
		assert tx_o='1' report "tx_o should be 1 in IDLE";
		assert busy_o='0' report "busy_o should be 0 in IDLE";
		
		wait for 10 ns;
		
		send_i <= '1';
		wait for 10 ns;
		
		send_i <= '0';
		wait for 40 ns;
		assert tx_o='0' report "tx_o should be 0 in START";
		assert busy_o='1' report "busy_o should be 1 in START";
		
		for index in 0 to 7 loop
			wait for 30 ns;
			assert tx_o='0' report "tx_o should be 0 when sending DATA for 0x00";
			assert busy_o='1' report "busy_o should be 1 while sending data";
		end loop;

		wait for 30 ns;
		assert tx_o='1' report "tx_o should be 0 in STOP";
		assert busy_o='1' report "busy_o should be 1 in STOP";
		
		wait for 30 ns;
		assert tx_o='1' report "tx_o should be 1 in IDLE";
		assert busy_o='0' report "busy_o should be 0 in IDLE";
		
		data_i <= "10101010";
		send_i <= '1';
		wait for 10 ns;
		
		send_i <= '0';
		wait for 40 ns;
		
		for index in 0 to 3 loop
			wait for 30 ns;
			assert tx_o='0' report "tx_o should be 0 when sending DATA for 0xAA";
			wait for 30 ns;
			assert tx_o='1' report "tx_o should be 1 when sending DATA for 0xAA";
		end loop;
		
		report "testbench finished";
		wait;
	 end process;
end architecture;

