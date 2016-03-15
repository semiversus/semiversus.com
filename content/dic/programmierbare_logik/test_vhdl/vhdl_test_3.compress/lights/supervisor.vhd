library ieee;
use ieee.std_logic_1164.all;

entity supervisor is
	port (
		monitor_i : in std_ulogic_vector(2 downto 0);
		result_o : out std_ulogic_vector(2 downto 0)
	);
end entity;

architecture behave1 of supervisor is
	signal i : std_ulogic_vector(2 downto 0);
	signal o : std_ulogic_vector(2 downto 0);
begin
	i <= (0=>monitor_i(1), 1=>monitor_i(2), 2=>monitor_i(0));

	with i select o <=
		"101" when "000", 
		"100" when "100",
		"111" when "001",
		"001" when "101",
		"101" when "010",
		"001" when "110",
		"011" when "011",
		"001" when others;

	result_o <= o xor "101";
end architecture;

architecture behave2 of supervisor is
	signal i : std_ulogic_vector(2 downto 0);
	signal o : std_ulogic_vector(2 downto 0);
begin
	i <= (0=>monitor_i(1), 1=>monitor_i(2), 2=>monitor_i(0));

	with i select o <=
		"101" when "000", 
		"100" when "100",
		"111" when "001",
		"001" when "101",
		"001" when "010",
		"001" when "110",
		"011" when "011",
		"001" when others;

	result_o <= o xor "101";
end architecture;

architecture behave3 of supervisor is
	signal i : std_ulogic_vector(2 downto 0);
	signal o : std_ulogic_vector(2 downto 0);
begin
	i <= (0=>monitor_i(1), 1=>monitor_i(2), 2=>monitor_i(0));

	with i select o <=
		"111" when "000", 
		"100" when "100",
		"111" when "001",
		"001" when "101",
		"001" when "010",
		"001" when "110",
		"011" when "011",
		"001" when others;

	result_o <= o xor "101";
end architecture;

architecture behave4 of supervisor is
	signal i : std_ulogic_vector(2 downto 0);
	signal o : std_ulogic_vector(2 downto 0);
begin
	i <= (0=>monitor_i(1), 1=>monitor_i(2), 2=>monitor_i(0));

	with i select o <=
		"101" when "000", 
		"100" when "100",
		"111" when "001",
		"001" when "101",
		"001" when "010",
		"001" when "110",
		"011" when "011",
		"011" when others;

	result_o <= o xor "101";
end architecture;
