----------------------------------------------------------------------
-- This file is designed for the software part of ADS-B receiver.
-- Design and implement written by Dabin Zhang, all rights reserved.
----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;  -- DO NOT use "std_logic_signed"

entity shift_reg_32_12 is port
(
	clk,reset: in std_logic;
	data_in: in std_logic_vector(11 downto 0);
	data_0,data_1,data_2,data_3,data_4,data_5,data_6,data_7,data_8,data_9,data_10,data_11,data_12,data_13,data_14,data_15,data_16,data_17,data_18,data_19,data_20,data_21,data_22,data_23,data_24,data_25,data_26,data_27,data_28,data_29,data_30,data_31: out std_logic_vector(11 downto 0)
);
end shift_reg_32_12;

architecture behavioral of shift_reg_32_12 is

signal reg_0_signal,reg_1_signal,reg_2_signal,reg_3_signal,reg_4_signal,reg_5_signal,reg_6_signal,reg_7_signal,reg_8_signal,reg_9_signal,reg_10_signal,reg_11_signal,reg_12_signal,reg_13_signal,reg_14_signal,reg_15_signal,reg_16_signal,reg_17_signal,reg_18_signal,reg_19_signal,reg_20_signal,reg_21_signal,reg_22_signal,reg_23_signal,reg_24_signal,reg_25_signal,reg_26_signal,reg_27_signal,reg_28_signal,reg_29_signal,reg_30_signal,reg_31_signal: std_logic_vector(11 downto 0);

component dff_12 is port
(
	aclr: in std_logic;
	clock: in std_logic;
	data: in std_logic_vector(11 downto 0);
	q: out std_logic_vector(11 downto 0)
);
end component;

begin

reg_31: dff_12 port map(aclr=>reset,clock=>clk,data=>data_in,q=>reg_31_signal); data_31<=reg_31_signal;
reg_30: dff_12 port map(aclr=>reset,clock=>clk,data=>reg_31_signal,q=>reg_30_signal); data_30<=reg_30_signal;
reg_29: dff_12 port map(aclr=>reset,clock=>clk,data=>reg_30_signal,q=>reg_29_signal); data_29<=reg_29_signal;
reg_28: dff_12 port map(aclr=>reset,clock=>clk,data=>reg_29_signal,q=>reg_28_signal); data_28<=reg_28_signal;
reg_27: dff_12 port map(aclr=>reset,clock=>clk,data=>reg_28_signal,q=>reg_27_signal); data_27<=reg_27_signal;
reg_26: dff_12 port map(aclr=>reset,clock=>clk,data=>reg_27_signal,q=>reg_26_signal); data_26<=reg_26_signal;
reg_25: dff_12 port map(aclr=>reset,clock=>clk,data=>reg_26_signal,q=>reg_25_signal); data_25<=reg_25_signal;
reg_24: dff_12 port map(aclr=>reset,clock=>clk,data=>reg_25_signal,q=>reg_24_signal); data_24<=reg_24_signal;
reg_23: dff_12 port map(aclr=>reset,clock=>clk,data=>reg_24_signal,q=>reg_23_signal); data_23<=reg_23_signal;
reg_22: dff_12 port map(aclr=>reset,clock=>clk,data=>reg_23_signal,q=>reg_22_signal); data_22<=reg_22_signal;
reg_21: dff_12 port map(aclr=>reset,clock=>clk,data=>reg_22_signal,q=>reg_21_signal); data_21<=reg_21_signal;
reg_20: dff_12 port map(aclr=>reset,clock=>clk,data=>reg_21_signal,q=>reg_20_signal); data_20<=reg_20_signal;
reg_19: dff_12 port map(aclr=>reset,clock=>clk,data=>reg_20_signal,q=>reg_19_signal); data_19<=reg_19_signal;
reg_18: dff_12 port map(aclr=>reset,clock=>clk,data=>reg_19_signal,q=>reg_18_signal); data_18<=reg_18_signal;
reg_17: dff_12 port map(aclr=>reset,clock=>clk,data=>reg_18_signal,q=>reg_17_signal); data_17<=reg_17_signal;
reg_16: dff_12 port map(aclr=>reset,clock=>clk,data=>reg_17_signal,q=>reg_16_signal); data_16<=reg_16_signal;
reg_15: dff_12 port map(aclr=>reset,clock=>clk,data=>reg_16_signal,q=>reg_15_signal); data_15<=reg_15_signal;
reg_14: dff_12 port map(aclr=>reset,clock=>clk,data=>reg_15_signal,q=>reg_14_signal); data_14<=reg_14_signal;
reg_13: dff_12 port map(aclr=>reset,clock=>clk,data=>reg_14_signal,q=>reg_13_signal); data_13<=reg_13_signal;
reg_12: dff_12 port map(aclr=>reset,clock=>clk,data=>reg_13_signal,q=>reg_12_signal); data_12<=reg_12_signal;
reg_11: dff_12 port map(aclr=>reset,clock=>clk,data=>reg_12_signal,q=>reg_11_signal); data_11<=reg_11_signal;
reg_10: dff_12 port map(aclr=>reset,clock=>clk,data=>reg_11_signal,q=>reg_10_signal); data_10<=reg_10_signal;
reg_9: dff_12 port map(aclr=>reset,clock=>clk,data=>reg_10_signal,q=>reg_9_signal); data_9<=reg_9_signal;
reg_8: dff_12 port map(aclr=>reset,clock=>clk,data=>reg_9_signal,q=>reg_8_signal); data_8<=reg_8_signal;
reg_7: dff_12 port map(aclr=>reset,clock=>clk,data=>reg_8_signal,q=>reg_7_signal); data_7<=reg_7_signal;
reg_6: dff_12 port map(aclr=>reset,clock=>clk,data=>reg_7_signal,q=>reg_6_signal); data_6<=reg_6_signal;
reg_5: dff_12 port map(aclr=>reset,clock=>clk,data=>reg_6_signal,q=>reg_5_signal); data_5<=reg_5_signal;
reg_4: dff_12 port map(aclr=>reset,clock=>clk,data=>reg_5_signal,q=>reg_4_signal); data_4<=reg_4_signal;
reg_3: dff_12 port map(aclr=>reset,clock=>clk,data=>reg_4_signal,q=>reg_3_signal); data_3<=reg_3_signal;
reg_2: dff_12 port map(aclr=>reset,clock=>clk,data=>reg_3_signal,q=>reg_2_signal); data_2<=reg_2_signal;
reg_1: dff_12 port map(aclr=>reset,clock=>clk,data=>reg_2_signal,q=>reg_1_signal); data_1<=reg_1_signal;
reg_0: dff_12 port map(aclr=>reset,clock=>clk,data=>reg_1_signal,q=>reg_0_signal); data_0<=reg_0_signal;

end behavioral;