----------------------------------------------------------------------
-- This file is designed for the software part of ADS-B receiver.
-- Design and implement written by Dabin Zhang, all rights reserved.
----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;  -- DO NOT use "std_logic_signed"

entity test_counter is port
(
	input,reset: in std_logic;
	result: out std_logic_vector(15 downto 0)
);
end test_counter;

architecture behavioral of test_counter is

signal result_signal: std_logic_vector(15 downto 0);

begin

duty_counter: process(reset,input)
begin
	if(reset='1')then
		result_signal<=x"0000";
	elsif(input'event and input='1')then
		result_signal<=result_signal+'1';
	end if;
end process;
result<=result_signal;

end behavioral;