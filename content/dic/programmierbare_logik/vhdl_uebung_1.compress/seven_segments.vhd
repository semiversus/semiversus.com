library ieee;
use ieee.std_logic_1164.all;

entity seven_segment is
	port (
		switches_i : in std_ulogic_vector(3 downto 0);
		an_o : out std_ulogic_vector(3 downto 0);
		segments_o : out std_ulogic_vector(6 downto 0) -- segments "ABCDEFG"
	);
end entity;

architecture behave of seven_segment is
begin
	with switches_i select segments_o <=
		"0000001" when "0000", -- digit 0
		"1001111" when "0001", -- digit 1
		-- ...
		"1111111" when others;

	an_o <= "0111";
end architecture;
