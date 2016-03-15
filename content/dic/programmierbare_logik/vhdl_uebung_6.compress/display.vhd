library ieee;
use ieee.std_logic_1164.all;

entity display is
	generic (
		CLK_DIVIDER : integer := 5000
	);
	port (
		clk : in std_ulogic;
		digit0_i : in std_ulogic_vector(3 downto 0); -- right most
		digit1_i : in std_ulogic_vector(3 downto 0); -- 
		digit2_i : in std_ulogic_vector(3 downto 0); --
		digit3_i : in std_ulogic_vector(3 downto 0); -- left most
		dots_i : in std_ulogic_vector(3 downto 0);
		segments_o : out std_ulogic_vector(7 downto 0); -- segments ".ABCDEFG"
		an_o : out std_ulogic_vector(3 downto 0)
	);
end entity;

architecture Behavioral of display is
	signal divider_counter_reg : integer range 0 to CLK_DIVIDER := 0;
	signal digit_counter_reg : integer range 0 to 3 := 0;
	signal digit : std_ulogic_vector(3 downto 0);
begin
	seven_seg_decoder_component: entity work.seven_seg_decoder
		port map (
			digit_i => digit,
			segments_o => segments_o(6 downto 0)
	);
	
	counter_proc: process (clk)
	begin
		if rising_edge(clk) then
			if divider_counter_reg=0 then
				divider_counter_reg <= CLK_DIVIDER;
			else
				divider_counter_reg <= divider_counter_reg - 1;
			end if;
		end if;
	end process;
	
	reg_proc: process (clk)
	begin
		if rising_edge(clk) then
			if divider_counter_reg = 0 then
				if digit_counter_reg=3 then
					digit_counter_reg <= 0;
				else
					digit_counter_reg <= digit_counter_reg + 1;
				end if;
			end if;
		end if;
	end process;
	
	with digit_counter_reg select an_o <=
		"1110" when 0,
		"1101" when 1,
		"1011" when 2,
		"0111" when others;
	
	with digit_counter_reg select digit <=
		digit0_i when 0,
		digit1_i when 1,
		digit2_i when 2,
		digit3_i when others;
		
	segments_o(7) <= not dots_i(digit_counter_reg);
end architecture;
