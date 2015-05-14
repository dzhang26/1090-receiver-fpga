----------------------------------------------------------------------
-- This file is designed for the software part of ADS-B receiver.
-- Design and implement written by Dabin Zhang, all rights reserved.
----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;  -- DO NOT use "std_logic_signed"

entity clock_divider is port
(
	clk_in,reset: in std_logic;
	clk_out: out std_logic
);
end clock_divider;

architecture behavioral of clock_divider is

signal clk_out_signal: std_logic;

begin

clock_generator: process(reset,clk_in)
begin
	if(reset='1')then
		clk_out_signal<='0';
	elsif(rising_edge(clk_in))then
		clk_out_signal<=not clk_out_signal;
	end if;
end process;
clk_out<=clk_out_signal;

end behavioral;