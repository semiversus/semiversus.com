library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pwm_generator is
	generic (
		WIDTH : integer := 3
	);
	port (
		clk : in std_ulogic;
		level_i : in std_ulogic_vector(WIDTH-1 downto 0);
		pwm_o : out std_ulogic
	);
end entity;

architecture behave of pwm_generator is
	signal counter_reg : unsigned(WIDTH-1 downto 0) := (others => '0');
	signal pwm_reg : std_ulogic := '0';
begin
	pwm_process: process (clk)
	begin
		if rising_edge(clk) then
			counter_reg <= counter_reg + 1;

			if counter_reg=unsigned(level_i) then
				pwm_reg <= '0';
			elsif counter_reg=to_unsigned(0, WIDTH) then
				pwm_reg <= '1';
			end if;
		end if;
	end process;
	
	pwm_o <= pwm_reg;
end architecture;
