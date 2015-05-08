-------------------------------------------------------------------
-- This file is designed for the firmware part of 1.09GHz receiver.
-- Design and implement by Dabin Zhang, all rights reserved.
-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;  -- DO NOT use "std_logic_signed"

entity shift_reg_8_12 is port
(
	clk,reset: in std_logic;
	data_in: in std_logic_vector(11 downto 0);
	data_0,data_1,data_2,data_3,data_4,data_5,data_6,data_7: out std_logic_vector(11 downto 0)
);
end shift_reg_8_12;

architecture behavioral of shift_reg_8_12 is

signal reg_0_signal,reg_1_signal,reg_2_signal,reg_3_signal,reg_4_signal,reg_5_signal,reg_6_signal,reg_7_signal: std_logic_vector(11 downto 0);

component dff_12 is port
(
	aclr: in std_logic;
	clock: in std_logic;
	data: in std_logic_vector(11 downto 0);
	q: out std_logic_vector(11 downto 0)
);
end component;

begin

reg_7: dff_12 port map(aclr=>reset,clock=>clk,data=>data_in,q=>reg_7_signal); data_7<=reg_7_signal;
reg_6: dff_12 port map(aclr=>reset,clock=>clk,data=>reg_7_signal,q=>reg_6_signal); data_6<=reg_6_signal;
reg_5: dff_12 port map(aclr=>reset,clock=>clk,data=>reg_6_signal,q=>reg_5_signal); data_5<=reg_5_signal;
reg_4: dff_12 port map(aclr=>reset,clock=>clk,data=>reg_5_signal,q=>reg_4_signal); data_4<=reg_4_signal;
reg_3: dff_12 port map(aclr=>reset,clock=>clk,data=>reg_4_signal,q=>reg_3_signal); data_3<=reg_3_signal;
reg_2: dff_12 port map(aclr=>reset,clock=>clk,data=>reg_3_signal,q=>reg_2_signal); data_2<=reg_2_signal;
reg_1: dff_12 port map(aclr=>reset,clock=>clk,data=>reg_2_signal,q=>reg_1_signal); data_1<=reg_1_signal;
reg_0: dff_12 port map(aclr=>reset,clock=>clk,data=>reg_1_signal,q=>reg_0_signal); data_0<=reg_0_signal;

end behavioral;