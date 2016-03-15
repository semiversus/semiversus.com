library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shuffle is
	port (
		clk : in std_ulogic;
		enable_i : in std_ulogic;
		result_o : out std_ulogic_vector(2 downto 0)
	);
end entity;

architecture behave of shuffle is
	signal counter_reg, result_reg : unsigned(2 downto 0) := (others => '0');
begin
	shuffle_process: process (clk)
	begin
		if rising_edge(clk) then
			if enable_i='1' then
				if counter_reg="101" then
					counter_reg<="000";
				else
					counter_reg<=counter_reg+1;
				end if;
			else
				result_reg<=counter_reg;
			end if;
		end if;
	end process;
	
	result_o <= std_ulogic_vector(result_reg);
end architecture;

