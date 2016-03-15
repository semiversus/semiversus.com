library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uart_tx is
	generic (
		BAUDRATE_WIDTH : integer := 1;
		BAUDRATE_DIVIDER : integer := 1
	);
	port (
		clk : in std_ulogic;
		send_i : in std_ulogic;
		data_i : in std_ulogic_vector(7 downto 0);
		tx_o : out std_ulogic;
		busy_o : out std_ulogic
	);
end entity;

architecture behave of uart_tx is
	type state_t is (IDLE, START, DATA, STOP);
	signal state : state_t := IDLE;
	signal baudrate_reset : std_ulogic;
	signal baudrate_overflow : std_ulogic;
	signal bit_counter_value : std_ulogic_vector(2 downto 0);
	signal bit_counter_reset : std_ulogic;
begin
	baudrate_component: entity work.counter
	generic map (
		WIDTH => BAUDRATE_WIDTH,
		MAXIMUM => BAUDRATE_DIVIDER
	)
	port map (
		clk => clk,
		reset_i => baudrate_reset,
		enable_i => '1',
		value_o => open,
		overflow_o => baudrate_overflow
	);
	
	bit_counter_component: entity work.counter
	generic map (
		WIDTH => 3,
		MAXIMUM => 7
	)
	port map (
		clk => clk,
		reset_i => bit_counter_reset,
		enable_i => baudrate_overflow,
		value_o => bit_counter_value,
		overflow_o => open
	);
	
	shift_process: process (clk)
	begin
		if rising_edge(clk) then
			case state is
				when IDLE =>
					busy_o <= '0';
					tx_o <= '1';
					baudrate_reset <= '1';
					bit_counter_reset <= '1';
					if send_i='1' then
						state <= START;
					end if;
				when START =>
					busy_o <= '1';
					tx_o <= '0';
					baudrate_reset <= '0';
					bit_counter_reset <= '1';
					if baudrate_overflow='1' then
						state <= DATA;
					end if;
				when DATA =>
					busy_o <= '1';
					tx_o <= data_i(to_integer(unsigned(bit_counter_value)));
					baudrate_reset <= '0';
					bit_counter_reset <= '0';
					if bit_counter_value="111" and baudrate_overflow='1' then
						state <= STOP;
					end if;
				when STOP =>
					busy_o <= '1';
					tx_o <= '1';
					baudrate_reset <= '0';
					bit_counter_reset <= '1';
					if baudrate_overflow='1' then
						state <= IDLE;
					end if;
			end case;
		end if;
	end process;
end architecture;