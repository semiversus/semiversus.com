library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity level_adjust is
	generic (
		WIDTH : integer := 3
	);
	port (
		clk : in std_ulogic;
		up_i : in std_ulogic;
		down_i : in std_ulogic;
		level_o : out std_ulogic_vector(WIDTH-1 downto 0)
	);
end entity;

architecture behave of level_adjust is
	signal level_reg : unsigned(WIDTH-1 downto 0) := (others => '0');
	constant level_min : unsigned(WIDTH-1 downto 0) := (others => '0');
	constant level_max : unsigned(WIDTH-1 downto 0) := (others => '1');
begin
	level_adjust_process: process (clk)
	begin
		if rising_edge(clk) then
			if up_i='1' and level_reg/=level_max then
				level_reg <= level_reg + 1;
			elsif down_i='1' and level_reg/=level_min then
				level_reg <= level_reg - 1;
			end if;
		end if;
	end process;
	
	level_o <= std_ulogic_vector(level_reg);
end architecture;
