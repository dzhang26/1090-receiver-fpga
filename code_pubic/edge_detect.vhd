----------------------------------------------------------------------
-- This file is designed for the software part of ADS-B receiver.
-- Design and implement written by Dabin Zhang, all rights reserved.
----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;  -- DO NOT use "std_logic_signed"

entity edge_detect is port
(
	clk,reset,input: in std_logic;
	output: out std_logic
);
end edge_detect;

architecture behavioral of edge_detect is

component shift_reg_2_1 is port
(
	aclr: in std_logic;
	clock: in std_logic;
	shiftin: in std_logic;
	q: out std_logic_vector(1 downto 0)
);
end component;

-- signal for the test ROM
signal cache_2_output_signal: std_logic_vector(1 downto 0);

begin

edge_cache: shift_reg_2_1 port map
(
	aclr=>reset,
	clock=>clk,
	shiftin=>input,
	q=>cache_2_output_signal
);

data_rom: process(reset,cache_2_output_signal)
begin
	if(reset='1')then
		output<='0';
	elsif((cache_2_output_signal(1) and (not cache_2_output_signal(0)))='1')then
		output<='1';
	else
		output<='0';
	end if;
end process;

end behavioral;