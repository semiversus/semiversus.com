library ieee;
use ieee.std_logic_1164.all;

entity clicker_fsm is
	port (
		clk : in std_ulogic;
		timeout_i : in std_ulogic;
		tap_i : in std_ulogic;
		reset_i : in std_ulogic;
		clear_o : out std_ulogic;
		enable_o : out std_ulogic
	);
end entity;

architecture behave of clicker_fsm is
	type state_t is (CLEARED, RUNNING, STOPPED);
	signal state : state_t := CLEARED; 
begin
	fsm_process: process (clk)
	begin
		if rising_edge(clk) then
			case state is
				when CLEARED =>
					-- TODO
				when RUNNING =>
					-- TODO
				when others => -- includes STOPPED
					-- TODO
			end case;
		end if;
	end process;
	
	clear_o <= '0'; -- <<< TODO
	enable_o <= '0'; -- <<< TODO
end architecture;
