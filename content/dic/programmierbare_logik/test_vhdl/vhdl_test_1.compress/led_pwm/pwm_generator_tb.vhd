library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity pwm_generator_tb is
end entity;

architecture behave of pwm_generator_tb is
		constant WIDTH : integer := 3;
		signal clk : std_ulogic := '0';
		signal level_i : std_ulogic_vector(WIDTH-1 downto 0) := (others => '0');
		signal pwm_o : std_ulogic;
begin
	dut: entity work.pwm_generator
	generic map (
		WIDTH => WIDTH
	)
	port map (
		clk => clk,
		level_i => level_i,
		pwm_o => pwm_o
	);

	clk <= not clk after 5 ns;

	-- Stimulus process
	stim_proc: process
	begin		
		report "testbench starting";
		
		for level in 0 to (2**WIDTH)-1 loop
			for i in 0 to (2**WIDTH)-1 loop
				level_i<=std_ulogic_vector(to_unsigned(level, WIDTH));
				wait for 10 ns;
				if i>=to_integer(unsigned(level_i)) then
					assert pwm_o='0' report "pwm_o should be '0' (level_i is "& integer'image(to_integer(unsigned(level_i)))&", internal counter is "&integer'image(i)&")";
				else
					assert pwm_o='1' report "pwm_o should be '1' (level_i is "& integer'image(to_integer(unsigned(level_i)))&", internal counter is "&integer'image(i)&")";
				end if;
			end loop;
		end loop;

		report "testbench finished";
		wait;
	 end process;
end architecture;

