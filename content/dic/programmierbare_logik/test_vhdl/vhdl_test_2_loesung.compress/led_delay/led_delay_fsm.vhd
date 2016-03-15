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
	type state_t is (OFF, LIGHT, DELAY);
	signal state : state_t := OFF; 
begin
	fsm_process: process (clk)
	begin
		if rising_edge(clk) then
			case state is
				when OFF =>
					if toggle_i='1' then
						state <= LIGHT;
					elsif on_i='1' then
						state <= DELAY;
					end if;
				when LIGHT =>
					if toggle_i='1' then
						state <= OFF;
					end if;
				when others =>
					if toggle_i='1' or timeout_i='1' then
						state <= LIGHT;
					end if;
			end case;
		end if;
	end process;
	
	led_o <= '1' when state=LIGHT else '0';
	timer_enable_o <= '1' when state=DELAY else '0';
	timer_clear_o <= '1' when state=OFF else '0';
end architecture;
