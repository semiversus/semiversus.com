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
	type state_t is (OFF, LED1, LED2);
	signal state : state_t := OFF; 
begin
	fsm_process: process (clk)
	begin
		if rising_edge(clk) then
			case state is
				when OFF =>
					if off_i='1' then
						state <= OFF;
					elsif toggle_i='1' then
						state <= LED1;
					end if;
				when LED1 =>
					if off_i='1' then
						state <= OFF;
					elsif toggle_i='1' then
						state <= LED2;
					end if;
				when others =>
					if off_i='1' then
						state <= OFF;
					elsif toggle_i='1' then
						state <= LED1;
					end if;
			end case;
		end if;
	end process;
	
	led1_o <= '1' when state=LED1 else '0';
	led2_o <= '1' when state=LED2 else '0';
end architecture;
