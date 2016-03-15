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
	type state_t is (GREEN, ORANGE, RED, RED_ORANGE, OFF);
	signal state : state_t := ORANGE; 
begin
	fsm_process: process (clk)
	begin
		if rising_edge(clk) then
			if next_i='1' then
				case state is
					when GREEN =>
						state <= ORANGE;
					when ORANGE =>
						if mode_i='1' then
							state <= RED;
						else
							state <= OFF;
						end if;
					when RED =>
						if mode_i='1' then
							state <= RED_ORANGE;
						else
							state <= ORANGE;
						end if;
					when RED_ORANGE =>
						if mode_i='1' then
							state <= GREEN;
						else
							state <= ORANGE;
						end if;
					when others =>
						state <= ORANGE;
				end case;
			end if;
		end if;
	end process;
	
	with state select lights_o <=
		"001" when GREEN,
		"010" when ORANGE,
		"100" when RED,
		"110" when RED_ORANGE,
		"000" when others;

end architecture;
