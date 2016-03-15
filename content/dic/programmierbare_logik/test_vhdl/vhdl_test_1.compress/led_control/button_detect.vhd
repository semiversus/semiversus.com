library ieee;
use ieee.std_logic_1164.all;

entity button_detect is
	port (
		clk : in std_ulogic;
		button_i : in std_ulogic;
		detect_o : out std_ulogic
	);
end entity;

architecture behave of button_detect is
	signal button_reg1, button_reg2 : std_ulogic := '0';
begin
	button_reg_process: process (clk)
	begin
		if rising_edge(clk) then
			button_reg1 <= button_i;
			button_reg2 <= button_reg1;
		end if;
	end process;

	detect_o <= '1' when button_reg1='1' and button_reg2='0' else '0';
end architecture;

