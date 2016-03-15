library ieee;
use ieee.std_logic_1164.all;
 
entity seven_segment_tb is
end entity;

architecture behave of seven_segment_tb is
	 signal switches_i : std_ulogic_vector(3 downto 0) := (others => '0');
	 signal an_o : std_ulogic_vector(3 downto 0);
	 signal segments_o : std_ulogic_vector(6 downto 0);
begin
	dut: entity work.seven_segment
	port map (
		switches_i => switches_i,
		an_o => an_o,
		segments_o => segments_o
	);

	-- Stimulus process
	stim_proc: process
	begin		
		report "testbench starting";
		
		switches_i <= "0000";
		wait for 10 ns;
		assert segments_o="0000001" report "digit 0 is wrong";

		switches_i <= "0001";
		wait for 10 ns;
		assert segments_o="1001111" report "digit 1 is wrong";
		
		switches_i <= "0010";
		wait for 10 ns;
		assert segments_o="0010010" report "digit 2 is wrong";
		
		switches_i <= "0011";
		wait for 10 ns;
		assert segments_o="0000110" report "digit 3 is wrong";
		
		switches_i <= "0100";
		wait for 10 ns;
		assert segments_o="1001100" report "digit 4 is wrong";
		
		switches_i <= "0101";
		wait for 10 ns;
		assert segments_o="0100100" report "digit 5 is wrong";
		
		switches_i <= "0110";
		wait for 10 ns;
		assert segments_o="0100000" report "digit 6 is wrong";
		
		switches_i <= "0111";
		wait for 10 ns;
		assert segments_o="0001111" report "digit 7 is wrong";
		
		switches_i <= "1000";
		wait for 10 ns;
		assert segments_o="0000000" report "digit 8 is wrong";
		
		switches_i <= "1001";
		wait for 10 ns;
		assert segments_o="0000100" report "digit 9 is wrong";
		
		switches_i <= "1010";
		wait for 10 ns;
		assert segments_o="0001000" report "digit A is wrong";
		
		switches_i <= "1011";
		wait for 10 ns;
		assert segments_o="1100000" report "digit B is wrong";
		
		switches_i <= "1100";
		wait for 10 ns;
		assert segments_o="0110001" report "digit C is wrong";
		
		switches_i <= "1101";
		wait for 10 ns;
		assert segments_o="1000010" report "digit D is wrong";
		
		switches_i <= "1110";
		wait for 10 ns;
		assert segments_o="0110000" report "digit E is wrong";
		
		switches_i <= "1111";
		wait for 10 ns;
		assert segments_o="0111000" report "digit F is wrong";
		
		report "testbench finished";
		wait;
	 end process;

end architecture;
