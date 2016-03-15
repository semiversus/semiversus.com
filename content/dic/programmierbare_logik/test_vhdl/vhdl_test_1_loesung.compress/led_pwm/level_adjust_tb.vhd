library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity level_adjust_tb is
end entity;

architecture behave of level_adjust_tb is
	constant WIDTH : integer := 4;
	signal clk : std_ulogic := '0';
	signal up_i, down_i : std_ulogic := '0';
	signal level_o : std_ulogic_vector(WIDTH-1 downto 0);
	constant level_min : std_ulogic_vector(WIDTH-1 downto 0) := (others => '0');
	constant level_max : std_ulogic_vector(WIDTH-1 downto 0) := (others => '1');
begin
	dut: entity work.level_adjust
	generic map (
		WIDTH => WIDTH
	)
	port map (
		clk => clk,
		up_i => up_i,
		down_i => down_i,
		level_o => level_o
	);

	clk <= not clk after 5 ns;

	-- Stimulus process
	stim_proc: process
	begin		
		report "testbench starting";
		
		wait for 50 ns;
		assert level_o=std_ulogic_vector(to_unsigned(0, WIDTH)) report "level_o should be 0 after reset and whether up_i or down_i was activated";

		up_i<='1';
		for i in 1 to (2**WIDTH)-1 loop
			wait for 10 ns;
			assert level_o=std_ulogic_vector(to_unsigned(i, WIDTH)) report "level_o is "&integer'image(to_integer(unsigned(level_o)))&" but should correspond to "& integer'image(i) & " (up_i is activated)";
		end loop;

		wait for 30 ns;
		assert level_o=level_max report "level_o is " & integer'image(to_integer(unsigned(level_o))) & " but should correspond to maximum (no overflow should happen)";

		up_i<='0';
		down_i<='1';
		for i in (2**WIDTH)-2 downto 0 loop
			wait for 10 ns;
			assert level_o=std_ulogic_vector(to_unsigned(i, WIDTH)) report "level_o is "&integer'image(to_integer(unsigned(level_o)))&" but should correspond to "& integer'image(i) & " (down_i is activated)";
		end loop;

		wait for 30 ns;
		assert level_o=level_min report "level_o is "&integer'image(to_integer(unsigned(level_o)))&" but should correspond to 0 (no overflow should happen)";

		report "testbench finished";
		wait;
	 end process;
end architecture;


