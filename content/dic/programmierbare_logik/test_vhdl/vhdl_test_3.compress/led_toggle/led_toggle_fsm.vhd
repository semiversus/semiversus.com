library ieee;
use ieee.std_logic_1164.all;

entity led_toggle_fsm is
	port (
		clk : in std_ulogic;
		toggle_i : in std_ulogic;
		off_i : in std_ulogic;
		led1_o : out std_ulogic;
		led2_o : out std_ulogic
	);
end entity;

architecture behave of led_toggle_fsm is
	type state_t is (OFF);
	signal state : state_t := OFF; 
begin
	fsm_process: process (clk)
	begin
		if rising_edge(clk) then
			case state is
				when OFF =>
					-- TODO
			end case;
		end if;
	end process;
	
	led1_o <= '0'; -- <<< TODO
	led2_o <= '0'; -- <<< TODO
end architecture;
