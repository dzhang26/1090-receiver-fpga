---------------------------------------------------------------------------------------------------
-- Raw code written by Dabin Zhang, revised by Dabin Zhang and Yunye Gong, all rights reserved. --
---------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity hex_driver_16 is port
(
	h_in: in std_logic_vector(3 downto 0);
	c_out: out std_logic_vector(6 downto 0)
);
end hex_driver_16;

architecture behavioral of hex_driver_16 is
begin

process(h_in)
begin
	case h_in is
		when "0000"=> c_out<="1000000";
		when "0001"=> c_out<="1111001";
		when "0010"=> c_out<="0100100";
		when "0011"=> c_out<="0110000";
		when "0100"=> c_out<="0011001";
		when "0101"=> c_out<="0010010";
		when "0110"=> c_out<="0000010";
		when "0111"=> c_out<="1111000";
		when "1000"=> c_out<="0000000";
		when "1001"=> c_out<="0010000";
		when "1010"=> c_out<="0001000";
		when "1011"=> c_out<="0000011";
		when "1100"=> c_out<="1000110";
		when "1101"=> c_out<="0100001";
		when "1110"=> c_out<="0000110";
		when "1111"=> c_out<="0001110";
		when others=> c_out<="0000000";
	end case;
end process;

end behavioral;