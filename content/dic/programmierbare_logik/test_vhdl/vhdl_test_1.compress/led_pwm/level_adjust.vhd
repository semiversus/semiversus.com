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
begin
	level_adjust_process: process (clk)
	begin
		if rising_edge(clk) then
			-- TODO
		end if;
	end process;
	
	level_o <= (others => '0'); -- TODO
end architecture;
