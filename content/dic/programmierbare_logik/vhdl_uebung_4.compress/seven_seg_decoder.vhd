library ieee;
use ieee.std_logic_1164.all;

entity seven_seg_decoder is
	port (
		digit_i : in std_ulogic_vector(3 downto 0);
		segments_o : out std_ulogic_vector(6 downto 0)
	);
end entity;

architecture behave of seven_seg_decoder is
begin
	with digit_i select segments_o <=
		"0000001" when "0000", -- display 0
		"1001111" when "0001", -- display 1
		"0010010" when "0010", -- display 2
		"0000110" when "0011", -- display 3
		"1001100" when "0100", -- display 4
		"0100100" when "0101", -- display 5
		"0100000" when "0110", -- display 6
		"0001111" when "0111", -- display 7
		"0000000" when "1000", -- display 8
		"0000100" when "1001", -- display 9
		"0001000" when "1010", -- display A
		"1100000" when "1011", -- display b
		"0110001" when "1100", -- display C
		"1000010" when "1101", -- display d
		"0110000" when "1110", -- display E
		"0111000" when "1111", -- display F
		"1111111" when others;
end architecture;
