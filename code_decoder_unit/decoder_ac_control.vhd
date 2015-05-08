----------------------------------------------------------------------
--  This file is part of the FPGA design of the 1.09 GHz Receiver.  --
--  Designed and implemented by Dabin Zhang, all rights reserved.   --
----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;  -- DO NOT use "std_logic_signed"

-- this entity is designed for 16M samples per second
entity decoder_ac_control is port
(
	clk, reset, mode_ac_en: in std_logic;
	mode_ac_detected: in std_logic;
	current_ac_value: in std_logic_vector(15 downto 0);
	time_in: in std_logic_vector(47 downto 0);
	-- control signal for FIFO
	fifo_data_raw: out std_logic_vector(179 downto 0);
	fifo_write: out std_logic;
	fifo_full: in std_logic
);
end decoder_ac_control;

architecture behavioral of decoder_ac_control is

signal frame_flip_signal: std_logic_vector(15 downto 0);

begin

frame_flip_signal(0)<=current_ac_value(15);
frame_flip_signal(1)<=current_ac_value(14);
frame_flip_signal(2)<=current_ac_value(13);
frame_flip_signal(3)<=current_ac_value(12);
frame_flip_signal(4)<=current_ac_value(11);
frame_flip_signal(5)<=current_ac_value(10);
frame_flip_signal(6)<=current_ac_value(9);
frame_flip_signal(7)<=current_ac_value(8);
frame_flip_signal(8)<=current_ac_value(7);
frame_flip_signal(9)<=current_ac_value(6);
frame_flip_signal(10)<=current_ac_value(5);
frame_flip_signal(11)<=current_ac_value(4);
frame_flip_signal(12)<=current_ac_value(3);
frame_flip_signal(13)<=current_ac_value(2);
frame_flip_signal(14)<=current_ac_value(1);
frame_flip_signal(15)<=current_ac_value(0);

-- output data has 180-bit,  48(time_stamp)+16(frame)+112(reserve)+4(type)
-- fifo_input_adapter will flip all the bits after time stamp,  it will flip [76:91] to [131:116]
fifo_data_raw <= time_in & CONV_STD_LOGIC_VECTOR(0, 40) & frame_flip_signal & CONV_STD_LOGIC_VECTOR(0, 72) & x"5";--x"5";
--time_in & current_ac_value
fifo_write <= mode_ac_detected and mode_ac_en and (not fifo_full);

end behavioral;