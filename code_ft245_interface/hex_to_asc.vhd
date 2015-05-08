----------------------------------------------------------------------
--  This file is part of the FPGA design of the 1.09 GHz Receiver.  --
--  Designed and implemented by Dabin Zhang, all rights reserved.   --
----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity hex_to_asc is port
(
	mode: in std_logic;
	hex_input: in std_logic_vector(3 downto 0);
	output_z: in std_logic;  -- tri-state output control
	asc_output: out std_logic_vector(7 downto 0)
);
end hex_to_asc;

architecture behavioral of hex_to_asc is

begin

convert: process(hex_input,mode,output_z)
begin
	if(output_z = '0')then  -- normal output
		case "000"&mode&hex_input is
			-- translate HEX into ACSII code
			when x"00"=> asc_output<=x"30";  -- "0"
			when x"01"=> asc_output<=x"31";
			when x"02"=> asc_output<=x"32";
			when x"03"=> asc_output<=x"33";
			when x"04"=> asc_output<=x"34";
			when x"05"=> asc_output<=x"35";
			when x"06"=> asc_output<=x"36";
			when x"07"=> asc_output<=x"37";
			when x"08"=> asc_output<=x"38";
			when x"09"=> asc_output<=x"39";
			when x"0A"=> asc_output<=x"41";  -- "A"
			when x"0B"=> asc_output<=x"42";
			when x"0C"=> asc_output<=x"43";
			when x"0D"=> asc_output<=x"44";
			when x"0E"=> asc_output<=x"45";
			when x"0F"=> asc_output<=x"46";
			-- translate non-number charactors into ASCII codes
			-- supported symbol: * @ , ; CR LF
			-- not supported symbol: + - < > . | ! = * # $
			when x"10"=> asc_output<=x"2A";  -- "*"
			when x"11"=> asc_output<=x"40";  -- "@"
			when x"12"=> asc_output<=x"2C";  -- ","
			when x"13"=> asc_output<=x"3B";  -- ";"
			when x"14"=> asc_output<=x"0D";  -- "<CR>"
			when x"15"=> asc_output<=x"0A";  -- "<LF>"
			-- reserved for other symbols
	--		when x"16"=> asc_output<=x"";  -- ""
	--		when x"17"=> asc_output<=x"";  -- ""
	--		when x"18"=> asc_output<=x"";  -- ""
	--		when x"19"=> asc_output<=x"";  -- ""
	--		when x"1A"=> asc_output<=x"";  -- ""
	--		when x"1B"=> asc_output<=x"";  -- ""
	--		when x"1C"=> asc_output<=x"";  -- ""
	--		when x"1D"=> asc_output<=x"";  -- ""
	--		when x"1E"=> asc_output<=x"";  -- ""
			when x"1F"=> asc_output<=x"58";  -- "X"
			-- default output
			when others=> asc_output<=x"78";  -- letter "x"
		end case;
	else
		asc_output <= "ZZZZZZZZ";  -- output high impedance
	end if;
end process;

end behavioral;