library ieee;
use ieee.std_logic_1164.all;

entity stopwatch_fsm is
	port (
		clk : in std_ulogic;
		ss_i : in std_ulogic;
		rl_i : in std_ulogic;
		mode_o : out std_ulogic;
		clear_o : out std_ulogic;
		enable_o : out std_ulogic
	);
end entity;

architecture behave of stopwatch_fsm is
	type state_t is (CLEARED, RUNNING, STOPPED);
	signal state : state_t := CLEARED; 
begin
	fsm_process: process (clk)
	begin
		if rising_edge(clk) then
			case state is
				when CLEARED =>
					if ss_i='1' then
						state <= RUNNING;
					end if;
				when RUNNING =>
					-- TODO
				when others => -- includes STOPPED
					-- TODO
			end case;
		end if;
	end process;
	
	clear_o <= '1' when state=CLEARED else '0';
	enable_o <= '0'; -- <<< TODO
	mode_o <= '0'; 
end architecture;
