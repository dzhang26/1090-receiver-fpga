-------------------------------------------------------------------
-- This file is designed for the firmware part of 1.09GHz receiver.
-- Design and implement by Dabin Zhang,  all rights reserved.
-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity led_flash is port
(
	clk, reset: in std_logic;
	brightness: in std_logic_vector(3 downto 0);
	led_output: out std_logic
);
end led_flash;

architecture behavioral of led_flash is

signal led_output_signal: std_logic;

begin

flash_clock_generater: process(clk, reset)
	variable counter: std_logic_vector(3 downto 0);
begin
	if(reset = '1')then
		counter := x"0";
		led_output <= '0';
	elsif(clk'event and clk = '1')then
		if(counter=x"F")then
			led_output <= '1';
			counter:=x"0";
		else
			counter := counter + '1';
		end if;
		if(counter = brightness)then
			led_output <= '0';
		end if;
	end if;
end process;

end behavioral;