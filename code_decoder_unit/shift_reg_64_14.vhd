----------------------------------------------------------------------
--  This file is part of the FPGA design of the 1.09 GHz Receiver.  --
--  Designed and implemented by Dabin Zhang, all rights reserved.   --
----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;  -- DO NOT use "std_logic_signed"

-- 14-bit 64-word shift register, designed to replace the old 400-word register
entity shift_reg_64_14 is port
(
	clk, reset: in std_logic;
	data_in: in std_logic_vector(13 downto 0);
	-- ,data_376,data_374  -- removed @ 201307272122
	data_0, data_8, data_16, data_24, data_32, data_40: out std_logic_vector(13 downto 0)
);
end shift_reg_64_14;

architecture behavioral of shift_reg_64_14 is

signal reg_63_signal,reg_62_signal,reg_61_signal,reg_60_signal,reg_59_signal,reg_58_signal,reg_57_signal,reg_56_signal,reg_55_signal,reg_54_signal,reg_53_signal,reg_52_signal,reg_51_signal,reg_50_signal,reg_49_signal,reg_48_signal,reg_47_signal,reg_46_signal,reg_45_signal,reg_44_signal,reg_43_signal,reg_42_signal,reg_41_signal,reg_40_signal,reg_39_signal,reg_38_signal,reg_37_signal,reg_36_signal,reg_35_signal,reg_34_signal,reg_33_signal,reg_32_signal,reg_31_signal,reg_30_signal,reg_29_signal,reg_28_signal,reg_27_signal,reg_26_signal,reg_25_signal,reg_24_signal,reg_23_signal,reg_22_signal,reg_21_signal,reg_20_signal,reg_19_signal,reg_18_signal,reg_17_signal,reg_16_signal,reg_15_signal,reg_14_signal,reg_13_signal,reg_12_signal,reg_11_signal,reg_10_signal,reg_9_signal,reg_8_signal,reg_7_signal,reg_6_signal,reg_5_signal,reg_4_signal,reg_3_signal,reg_2_signal,reg_1_signal,reg_0_signal: std_logic_vector(13 downto 0);

component dff_14 is port
(
	aclr: in std_logic;
	clock: in std_logic;
	data: in std_logic_vector(13 downto 0);
	q: out std_logic_vector(13 downto 0)
);
end component;

begin

reg_0: dff_14 port map(aclr=>reset,clock=>clk,data=>data_in,q=>reg_0_signal);
reg_1: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_0_signal,q=>reg_1_signal);
reg_2: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_1_signal,q=>reg_2_signal);
reg_3: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_2_signal,q=>reg_3_signal);
reg_4: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_3_signal,q=>reg_4_signal);
reg_5: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_4_signal,q=>reg_5_signal);
reg_6: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_5_signal,q=>reg_6_signal);
reg_7: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_6_signal,q=>reg_7_signal);
reg_8: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_7_signal,q=>reg_8_signal);
reg_9: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_8_signal,q=>reg_9_signal);
reg_10: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_9_signal,q=>reg_10_signal);
reg_11: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_10_signal,q=>reg_11_signal);
reg_12: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_11_signal,q=>reg_12_signal);
reg_13: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_12_signal,q=>reg_13_signal);
reg_14: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_13_signal,q=>reg_14_signal);
reg_15: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_14_signal,q=>reg_15_signal);
reg_16: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_15_signal,q=>reg_16_signal);
reg_17: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_16_signal,q=>reg_17_signal);
reg_18: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_17_signal,q=>reg_18_signal);
reg_19: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_18_signal,q=>reg_19_signal);
reg_20: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_19_signal,q=>reg_20_signal);
reg_21: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_20_signal,q=>reg_21_signal);
reg_22: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_21_signal,q=>reg_22_signal);
reg_23: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_22_signal,q=>reg_23_signal);
reg_24: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_23_signal,q=>reg_24_signal);
reg_25: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_24_signal,q=>reg_25_signal);
reg_26: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_25_signal,q=>reg_26_signal);
reg_27: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_26_signal,q=>reg_27_signal);
reg_28: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_27_signal,q=>reg_28_signal);
reg_29: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_28_signal,q=>reg_29_signal);
reg_30: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_29_signal,q=>reg_30_signal);
reg_31: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_30_signal,q=>reg_31_signal);
reg_32: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_31_signal,q=>reg_32_signal);
reg_33: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_32_signal,q=>reg_33_signal);
reg_34: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_33_signal,q=>reg_34_signal);
reg_35: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_34_signal,q=>reg_35_signal);
reg_36: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_35_signal,q=>reg_36_signal);
reg_37: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_36_signal,q=>reg_37_signal);
reg_38: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_37_signal,q=>reg_38_signal);
reg_39: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_38_signal,q=>reg_39_signal);
reg_40: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_39_signal,q=>reg_40_signal);
reg_41: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_40_signal,q=>reg_41_signal);
reg_42: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_41_signal,q=>reg_42_signal);
reg_43: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_42_signal,q=>reg_43_signal);
reg_44: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_43_signal,q=>reg_44_signal);
reg_45: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_44_signal,q=>reg_45_signal);
reg_46: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_45_signal,q=>reg_46_signal);
reg_47: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_46_signal,q=>reg_47_signal);
reg_48: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_47_signal,q=>reg_48_signal);
reg_49: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_48_signal,q=>reg_49_signal);
reg_50: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_49_signal,q=>reg_50_signal);
reg_51: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_50_signal,q=>reg_51_signal);
reg_52: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_51_signal,q=>reg_52_signal);
reg_53: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_52_signal,q=>reg_53_signal);
reg_54: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_53_signal,q=>reg_54_signal);
reg_55: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_54_signal,q=>reg_55_signal);
reg_56: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_55_signal,q=>reg_56_signal);
reg_57: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_56_signal,q=>reg_57_signal);
reg_58: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_57_signal,q=>reg_58_signal);
reg_59: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_58_signal,q=>reg_59_signal);
reg_60: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_59_signal,q=>reg_60_signal);
reg_61: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_60_signal,q=>reg_61_signal);
reg_62: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_61_signal,q=>reg_62_signal);
reg_63: dff_14 port map(aclr=>reset,clock=>clk,data=>reg_62_signal,q=>reg_63_signal);

data_0<=reg_0_signal;
data_8<=reg_8_signal;
data_16<=reg_16_signal;
data_24<=reg_24_signal;
data_32<=reg_32_signal;
data_40<=reg_40_signal;

end behavioral;