library ieee;
use ieee.std_logic_1164.all;

entity led_delay_fsm is
	port (
		clk : in std_ulogic;
		toggle_i : in std_ulogic;
		on_i : in std_ulogic;
		timeout_i : in std_ulogic;
		led_o : out std_ulogic;
		timer_enable_o : out std_ulogic;
		timer_clear_o : out std_ulogic
	);
end entity;

architecture behave of led_delay_fsm is
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
	
	led_o <= '0'; -- <<< TODO
	timer_enable_o <= '0'; -- <<< TODO
	timer_clear_o <= '0'; -- <<< TODO
end architecture;
