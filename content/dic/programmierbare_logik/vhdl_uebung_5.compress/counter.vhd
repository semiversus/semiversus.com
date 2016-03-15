library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
	generic (
		WIDTH : integer := 4;
		MAXIMUM : integer := 9
	);
	port (
		clk : in std_ulogic;
		reset_i : in std_ulogic;
		enable_i : in std_ulogic;
		value_o : out std_ulogic_vector(WIDTH-1 downto 0);
		overflow_o : out std_ulogic
	);
end entity;

architecture behave of counter is
	signal counter_reg : unsigned(WIDTH-1 downto 0) := (others => '0');
begin
	counter_process: process (clk)
	begin
		if rising_edge(clk) then
			-- TODO
		end if;
	end process;
	
	value_o <= std_ulogic_vector(counter_reg);
	overflow_o <= enable_i when counter_reg=to_unsigned(MAXIMUM, WIDTH) else '0';
end architecture;
