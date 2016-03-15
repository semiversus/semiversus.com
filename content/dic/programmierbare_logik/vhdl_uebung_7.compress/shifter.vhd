library ieee;
use ieee.std_logic_1164.all;

entity shifter is
	port (
		clk : in std_ulogic;
		reset_i : in std_ulogic;
		up_i : in std_ulogic;
		down_i : in std_ulogic;
		leds_o : out std_ulogic_vector(3 downto 0)
	);
end entity;

architecture behave1 of shifter is
	signal i : std_ulogic_vector(3 downto 0);
	signal s, s_n : std_ulogic_vector(1 downto 0) := "00";
begin
	i <= (3 => s(1), 2 => s(0), 1 => up_i, 0 => down_i);

	process(clk, reset_i)
	begin
		if reset_i='1' then
			s <= "00";
		elsif rising_edge(clk) then
			s <= s_n;
		end if;
	end process;

	with i select s_n <=
		"00" when "0000",
		"00" when "0001",
		"01" when "0010",
		"01" when "0011",
		"01" when "0100",
		"01" when "0101",
		"10" when "0110",
		"10" when "0111",
		"10" when "1000",
		"10" when "1001",
		"11" when "1010",
		"11" when "1011",
		"11" when "1100",
		"11" when "1101",
		"00" when "1110",
		"00" when others;

	with s select leds_o <=
		"0010" when "01",
		"0100" when "10",
		"1000" when "11",
		"0001" when others;
end architecture;

architecture behave2 of shifter is
	signal i : std_ulogic_vector(3 downto 0);
	signal s, s_n : std_ulogic_vector(1 downto 0) := "00";
begin
	i <= (3 => s(1), 2 => s(0), 1 => up_i, 0 => down_i);

	process(clk, reset_i)
	begin
		if reset_i='1' then
			s <= "00";
		elsif rising_edge(clk) then
			s <= s_n;
		end if;
	end process;

	with i select s_n <=
		"00" when "0000",
		"11" when "0001",
		"01" when "0010",
		"11" when "0011",
		"01" when "0100",
		"00" when "0101",
		"10" when "0110",
		"00" when "0111",
		"10" when "1000",
		"01" when "1001",
		"11" when "1010",
		"01" when "1011",
		"11" when "1100",
		"10" when "1101",
		"00" when "1110",
		"10" when others;

	with s select leds_o <=
		"0010" when "01",
		"0100" when "10",
		"1000" when "11",
		"0001" when others;
end architecture;

architecture behave3 of shifter is
	signal i : std_ulogic_vector(3 downto 0);
	signal s, s_n : std_ulogic_vector(1 downto 0) := "00";
begin
	i <= (3 => s(1), 2 => s(0), 1 => up_i, 0 => down_i);

	process(clk, reset_i)
	begin
		if rising_edge(clk) then
			if reset_i='1' then
				s <= "00";
			else
				s <= s_n;
			end if;
		end if;
	end process;

	with i select s_n <=
		"00" when "0000",
		"11" when "0001",
		"01" when "0010",
		"11" when "0011",
		"01" when "0100",
		"00" when "0101",
		"10" when "0110",
		"00" when "0111",
		"10" when "1000",
		"01" when "1001",
		"11" when "1010",
		"01" when "1011",
		"11" when "1100",
		"10" when "1101",
		"00" when "1110",
		"10" when others;

	with s select leds_o <=
		"0010" when "01",
		"0100" when "10",
		"1000" when "11",
		"0001" when others;
end architecture;

architecture behave4 of shifter is
	signal i : std_ulogic_vector(3 downto 0);
	signal s, s_n : std_ulogic_vector(1 downto 0) := "00";
begin
	i <= (3 => s(1), 2 => s(0), 1 => up_i, 0 => down_i);

	process(clk, reset_i)
	begin
		if reset_i='1' then
			s <= "00";
		elsif rising_edge(clk) then
			s <= s_n;
		end if;
	end process;

	with i select s_n <=
		"01" when "0000",
		"11" when "0001",
		"01" when "0010",
		"11" when "0011",
		"10" when "0100",
		"00" when "0101",
		"10" when "0110",
		"00" when "0111",
		"11" when "1000",
		"01" when "1001",
		"11" when "1010",
		"01" when "1011",
		"00" when "1100",
		"10" when "1101",
		"00" when "1110",
		"10" when others;

	with s select leds_o <=
		"0010" when "01",
		"0100" when "10",
		"1000" when "11",
		"0001" when others;
end architecture;
