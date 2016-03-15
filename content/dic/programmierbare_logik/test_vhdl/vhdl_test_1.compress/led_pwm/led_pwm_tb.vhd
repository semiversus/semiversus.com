library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity led_pwm_tb is
end entity;

architecture behave of led_pwm_tb is
	signal clk : std_ulogic := '0';
	signal button_up_i : std_ulogic := '0';
	signal button_down_i : std_ulogic := '0';
	signal led_o : std_ulogic;
	constant WIDTH : integer := 3;
begin
	dut: entity work.led_pwm
	generic map (
		PWM_WIDTH => WIDTH
	)
	port map (
		clk => clk,
		button_up_i => button_up_i,
		button_down_i => button_down_i,
		led_o => led_o
	);

	clk <= not clk after 5 ns;

	-- Stimulus process
	stim_proc: process
		variable count_ones : integer := 0;
	begin		
		report "testbench starting";
		
		button_down_i <= '1';
		wait for 10 ns;
		button_down_i <= '0';
		wait for 70 ns;
		
		for level in 0 to (2**WIDTH)-1 loop
			count_ones := 0;
			for i in 0 to (2**WIDTH)-1 loop
				wait for 10 ns;
				if led_o='1' then
					count_ones := count_ones + 1;
				end if;
			end loop;
			assert count_ones=level report "pwm should correspond to level "&integer'image(level)&", found "&integer'image(count_ones)&" '1's";
			
			button_up_i <= '1';
			wait for 10 ns;
			button_up_i <= '0';
			wait for 70 ns;
		end loop;
		
		button_up_i <= '1';
		wait for 10 ns;
		button_up_i <= '0';
		wait for 70 ns;
		
		for level in (2**WIDTH)-1 downto 0 loop
			count_ones := 0;
			for i in 0 to (2**WIDTH)-1 loop
				wait for 10 ns;
				if led_o='1' then
					count_ones := count_ones + 1;
				end if;
			end loop;
			assert count_ones=level report "pwm should correspond to level "&integer'image(level)&", found "&integer'image(count_ones)&" '1's";
			
			button_down_i <= '1';
			wait for 10 ns;
			button_down_i <= '0';
			wait for 70 ns;
		end loop;
		
		report "testbench finished";
		wait;
	 end process;
end architecture;

