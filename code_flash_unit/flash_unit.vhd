----------------------------------------------------------------------
--  This file is part of the FPGA design of the 1.09 GHz Receiver.  --
--  Designed and implemented by Dabin Zhang, all rights reserved.   --
----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;  -- DO NOT use "std_logic_signed"

entity flash_unit is port
(
	clk,reset: in std_logic;
	control_word_in: in std_logic_vector(15 downto 0);
	control_word: out std_logic_vector(15 downto 0);
	-- I/O of SST25 flash
	flash_so: in std_logic;
	flash_sck,flash_si,flash_ce_not,flash_hold_not: out std_logic	
);
end flash_unit;

architecture behavioral of flash_unit is

--type control_state is
--(
--	S_idle,S_read_0,S_read_1,S_read_2,S_load,S_check,S_save,  -- check if this frame is same as previous one
--	S_send_head,S_send_body,S_send_foot  -- send HEADER, BODY, END of each frame
--);
--signal current_state,next_state: control_state;

begin

-- address range is 0x0000 to oxFFFF
-- one M9K can implement a 8x1024 RAM, the address range is 0x0000 to 0x0400
flash_sck<='1';
flash_si<='1';
flash_ce_not<='1';
flash_hold_not<='1';

end behavioral;