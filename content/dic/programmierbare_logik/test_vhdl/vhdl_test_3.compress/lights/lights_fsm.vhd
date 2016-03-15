library ieee;
use ieee.std_logic_1164.all;

entity lights_fsm is
	port (
		clk : in std_ulogic;
		next_i : in std_ulogic;
		mode_i : in std_ulogic;
		lights_o : out std_ulogic_vector(2 downto 0)
	);
end entity;

architecture behave of lights_fsm is
	type state_t is (OFF);
	signal state : state_t := OFF; 
begin
	fsm_process: process (clk)
	begin
		if rising_edge(clk) then
			-- TODO
		end if;
	end process;
	
	with state select lights_o <=
		"001" when GREEN,
		-- TODO
		"000" when others;

end architecture;
