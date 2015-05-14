----------------------------------------------------------------------
--  This file is part of the FPGA design of the 1.09 GHz Receiver.  --
--  Designed and implemented by Dabin Zhang, all rights reserved.   --
----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;  -- DO NOT use "std_logic_signed"

-- this entity is designed for 16M samples per second
entity decoder_data_control is port
(
	clk,reset: in std_logic;
	threshold: out std_logic_vector(13 downto 0);
	-- compare_max_0,compare_max_1 --remove @ 201307272105
	compare_data: in std_logic;
	compare_preamble_0,compare_preamble_1,compare_preamble_2,compare_preamble_3: in std_logic;
	compare_preamble_4,compare_preamble_5,compare_preamble_6,compare_preamble_7: in std_logic;
	control: in std_logic_vector(15 downto 0);
	mode_s_detected: out std_logic;  -- indicades half of the preamble is detected
	current_bit_value: out std_logic_vector(1 downto 0)
);
end decoder_data_control;

architecture behavioral of decoder_data_control is

begin

-- threshold value for the comparetor
threshold<="00000011100000";  -- require SNR=1.75dB
-- x011 for 12-bit 8-point averager
-- sensitivity is ~124.5/dB
-- 00000010000000 for 1dB, lot of noise ~250 frame/sec
-- 00000011000000 for 1.5dB, lot of noise ~32 frame/sec
-- 00000100000000 for 2dB, nearly no noise frame ~.3 frame/sec

-- this process detects the proamble of mode-S frames by checking the data in the 128-bit shift register
-- preambles should have logic-1 during 0~0.5us, 1~1.5us, 3.5~5us and 4.5~5us
-- preambles should have logic-1 during 1~7, 17~23, 57~63 and 73~79 sample points
preamble_detect: process(reset,compare_preamble_0,compare_preamble_1,compare_preamble_2,compare_preamble_3)  -- compare_max_0,compare_max_1 -- remove @ 201307272057
begin
	if(reset='1')then
		mode_s_detected<='0';
	-- check if all the criterias for determining preamble are meet
	-- condition (compare_max_0='1' or compare_max_1='1') should be connected by AND instead of OR
	elsif(compare_preamble_0='1' and compare_preamble_1='1' and
		compare_preamble_2='1' and compare_preamble_3='1' and
		compare_preamble_4='1' and compare_preamble_5='1' and
		compare_preamble_6='1' and compare_preamble_7='1' and control(0)='1'
		-- and (compare_max_0='1' or compare_max_1='1')
		)then  -- tried to change from OR to AND @ 201305191700 but data rate drops really sevre
		mode_s_detected<='1';
	elsif(compare_preamble_4='1' and compare_preamble_5='1' and
		compare_preamble_6='1' and compare_preamble_7='1' and control(0)='0'
		-- and (compare_max_0='1' or compare_max_1='1')
		)then  -- tried to change from OR to AND @ 201305191700 but data rate drops really sevre
		mode_s_detected<='1';
	else
		mode_s_detected<='0';
	end if;
end process;

-- this process determines the value of the corresponding data bit (1, 0 or error)
-- the result is represent by two bits, result[1] describes the status of data, result[0] describes the value of data
-- 00 is 0, 01 is 1, 10 is both 0 (invalid data except for preamble detection), 11 is both 1 (invalid data)
determine_value: process(reset,compare_data)
begin
	if(reset='1')then
		current_bit_value<="11";
	elsif(compare_data='1')then
		current_bit_value<="01";
	else
		current_bit_value<="00";
	end if;
end process;

end behavioral;