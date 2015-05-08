----------------------------------------------------------------------
-- This file is designed for the software part of ADS-B receiver.
-- Design and implement written by Dabin Zhang, all rights reserved.
----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;  -- DO NOT use "std_logic_signed"

entity averager_4_12 is port
(
	clk,reset: in std_logic;
	data_0,data_1,data_2,data_3: in std_logic_vector(11 downto 0);
	average_out: out std_logic_vector(11  downto 0)
);
end averager_4_12;

architecture behavioral of averager_4_12 is

component adder_12 is port
(
	aclr: in std_logic;
	clock: in std_logic;
	dataa: in std_logic_vector(11 downto 0);
	datab: in std_logic_vector(11 downto 0);
	result: out std_logic_vector(11 downto 0)
);
end component;

signal adder_0_signal,adder_1_signal: std_logic_vector(11 downto 0);

begin

-- adder_0_signal=(data_0+data_1)/2
adder_0: adder_12 port map
(
	aclr=>reset,
	clock=>clk,
	dataa=>data_0(11)&data_0(11 downto 1),
	datab=>data_1(11)&data_1(11 downto 1),
	result=>adder_0_signal
);

-- adder_1_signal=(data_2+data_3)/2
adder_1: adder_12 port map
(
	aclr=>reset,
	clock=>clk,
	dataa=>data_2(11)&data_2(11 downto 1),
	datab=>data_3(11)&data_3(11 downto 1),
	result=>adder_1_signal
);

-- average_out=(adder_0_signal+adder_1_signal)/2=(data_0+data_1+data_2+data_3)/4
adder_2: adder_12 port map
(
	aclr=>reset,
	clock=>clk,
	dataa=>adder_0_signal(11)&adder_0_signal(11 downto 1),
	datab=>adder_1_signal(11)&adder_1_signal(11 downto 1),
	result=>average_out
);

end behavioral;