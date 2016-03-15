library ieee;
use ieee.std_logic_1164.all;

entity decoder is
	port (
		value_i : in std_ulogic_vector(2 downto 0);
		leds_o : out std_ulogic_vector(6 downto 0)
	);
end entity;

architecture behave1 of decoder is
	signal i : std_ulogic_vector(2 downto 0);
	signal o : std_ulogic_vector(6 downto 0);
begin
	i <= (0=>value_i(1), 1=>value_i(2), 2=>value_i(0));

	with i select o <=
		"1011101" when "000", 
		"1000001" when "100", 
		"1111111" when "001", 
		"0000000" when "101", 
		"0111110" when "010", 
		"0100010" when "110", 
		"0101010" when "111", 
		"1010101" when others;

	leds_o <= o xor "1010101";
end architecture;

architecture behave2 of decoder is
	signal i : std_ulogic_vector(2 downto 0);
	signal o : std_ulogic_vector(6 downto 0);
begin
	i <= (0=>value_i(1), 1=>value_i(2), 2=>value_i(0));

	with i select o <=
		"1011101" when "000", 
		"1000001" when "100", 
		"1111111" when "001", 
		"1000000" when "101", 
		"1111110" when "010", 
		"1100010" when "110", 
		"1010101" when others;

	leds_o <= o xor "1010101";
end architecture;

architecture behave3 of decoder is
	signal i : std_ulogic_vector(2 downto 0);
	signal o : std_ulogic_vector(6 downto 0);
begin
	i <= (0=>value_i(1), 1=>value_i(2), 2=>value_i(0));

	with i select o <=
		"1011101" when "000", 
		"1000001" when "100", 
		"1111111" when "001", 
		"0000000" when "101", 
		"0111110" when "010", 
		"0101010" when "110", 
		"1010101" when others;

	leds_o <= o xor "1010101";
end architecture;

architecture behave4 of decoder is
	signal i : std_ulogic_vector(2 downto 0);
	signal o : std_ulogic_vector(6 downto 0);
begin
	i <= (0=>value_i(1), 1=>value_i(2), 2=>value_i(0));

	with i select o <=
		"1011101" when "000", 
		"1000001" when "100", 
		"1111111" when "001", 
		"0000000" when "101", 
		"0111110" when "010", 
		"0100010" when "110", 
		"1010101" when others;

	leds_o <= o xor "1010101";
end architecture;
