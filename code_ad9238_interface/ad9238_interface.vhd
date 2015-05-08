----------------------------------------------------------------------
--  This file is part of the FPGA design of the 1.09 GHz Receiver.  --
--  Designed and implemented by Dabin Zhang, all rights reserved.   --
----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;  -- DO NOT use "std_logic_signed"

entity ad9238_interface is port
(
	clk_16,reset,channel_enable: in std_logic;  -- ,channel_select
	data_output: out std_logic_vector(11 downto 0);
	status_output: out std_logic;
	-- I/O port of AD9238, DO NOT change
	ad9238_dcs,ad9238_dfs,ad9238_mux_share,ad9238_oeb: out std_logic;
	ad9238_a_clk,ad9238_a_pwdn: out std_logic;
	ad9238_a_d: in std_logic_vector(11 downto 0);
	ad9238_a_otr: in std_logic;
	ad9238_b_clk,ad9238_b_pwdn: out std_logic;
	ad9238_b_d: in std_logic_vector(11 downto 0);
	ad9238_b_otr: in std_logic
	-- end of AD9238 I/O
);
end ad9238_interface;

architecture behavioral of ad9238_interface is

signal clk_25_signal: std_logic;
signal selected_signal: std_logic_vector(11 downto 0);

begin

-- AD9238's configuration signal
ad9238_dcs<='1';  -- Enable Duty Cycle Stabilizer (DCS) Mode (Tie High to Enable)
ad9238_dfs<='1';  -- Data Output Format Select Bit (Low for Offset Binary, High for Twos Complement)
-- OEB: Output Enable Bit (Logic 0 enables Data Bus, Logic 1 sets outputs to Z)
ad9238_oeb<='0';  -- There should be two pins for channel a and b but we tied them together on PCB to reduce layout difficulty
-- MUX: Data Multiplexed Mode (Low for channel data is reversed)
-- SHARE: Shared Reference Control Bit (Low for Independent Reference Mode, High for Shared Reference Mode)
ad9238_mux_share<='1';  -- MUX and SHARE have been tied on PCB to reduce layout difficulty
--ad9238_a_pwdn<='1';  -- Power-Down Function Selection (Logic 0 enables Channel A, Logic 1 outputs static (not Z))
--ad9238_b_pwdn<='0';  -- Power-Down Function Selection (Logic 0 enables Channel B, Logic 1 outputs static (not Z))
-- shoule be 0
ad9238_a_clk<=clk_16;
ad9238_b_clk<=clk_16;

channel_control: process(channel_enable, ad9238_a_d, ad9238_b_d)
begin
	if(channel_enable='1')then  -- internal RF frontend, CH B
		ad9238_a_pwdn<='1';
		ad9238_b_pwdn<='0';
		data_output<=ad9238_b_d;  -- shoule use b
	else  -- CH A
		ad9238_a_pwdn<='0';
		ad9238_b_pwdn<='1';
		data_output<=ad9238_a_d;
	end if;
end process;
status_output <= not channel_enable;
--ad9238_a_pwdn<='1';  -- should be 1
--data_output<=ad9238_b_d;--ad9238_b_d;  -- shoule use b

end behavioral;