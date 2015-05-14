-------------------------------------------------------------------
-- This file is designed for the firmware part of 1.09GHz receiver.
-- Design and implement by Dabin Zhang, all rights reserved.
-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;  -- DO NOT use "std_logic_signed"

entity averager_8_12 is port
(
	clk, reset: in std_logic;
	data_0, data_1, data_2, data_3, data_4, data_5, data_6, data_7: in std_logic_vector(11 downto 0);
	average_out: out std_logic_vector(11 downto 0)
);
end averager_8_12;

architecture behavioral of averager_8_12 is

component adder_12 is port
(
	aclr: in std_logic;
	clock: in std_logic;
	dataa: in std_logic_vector(11 downto 0);
	datab: in std_logic_vector(11 downto 0);
	result: out std_logic_vector(11 downto 0)
);
end component;

signal adder_00_signal, adder_01_signal, adder_02_signal, adder_03_signal: std_logic_vector(11 downto 0);
signal adder_10_signal, adder_11_signal: std_logic_vector(11 downto 0);

begin

-- adder_00_signal=(data_0+data_1)/2
adder_00: adder_12 port map
(aclr=>reset, clock=>clk, 
dataa=>data_0(11)&data_0(11 downto 1), datab=>data_1(11)&data_1(11 downto 1), result=>adder_00_signal);

-- adder_01_signal=(data_2+data_3)/2
adder_01: adder_12 port map
(aclr=>reset, clock=>clk, 
dataa=>data_2(11)&data_2(11 downto 1), datab=>data_3(11)&data_3(11 downto 1), result=>adder_01_signal);

-- adder_02_signal=(data_4+data_5)/2
adder_02: adder_12 port map
(aclr=>reset, clock=>clk, 
dataa=>data_4(11)&data_4(11 downto 1), datab=>data_5(11)&data_5(11 downto 1), result=>adder_02_signal);

-- adder_03_signal=(data_6+data_7)/2
adder_03: adder_12 port map
(aclr=>reset, clock=>clk, 
dataa=>data_6(11)&data_6(11 downto 1), datab=>data_7(11)&data_7(11 downto 1), result=>adder_03_signal);

-- adder_10_signal=(data_0+data_1+data_2+data_3)/4
adder_10: adder_12 port map
(aclr=>reset, clock=>clk, 
dataa=>adder_00_signal(11)&adder_00_signal(11 downto 1), datab=>adder_01_signal(11)&adder_01_signal(11 downto 1), result=>adder_10_signal);

-- adder_11_signal=(data_4+data_5+data_6+data_7)/4
adder_11: adder_12 port map
(aclr=>reset, clock=>clk, 
dataa=>adder_02_signal(11)&adder_02_signal(11 downto 1), datab=>adder_03_signal(11)&adder_03_signal(11 downto 1), result=>adder_11_signal);

-- average_out=(data_0+...+data_7)/8
adder_20: adder_12 port map
(aclr=>reset, clock=>clk, 
dataa=>adder_10_signal(11)&adder_10_signal(11 downto 1), datab=>adder_11_signal(11)&adder_11_signal(11 downto 1), result=>average_out);

end behavioral;