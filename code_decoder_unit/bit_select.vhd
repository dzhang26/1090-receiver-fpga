----------------------------------------------------------------------
--  This file is part of the FPGA design of the 1.09 GHz Receiver.  --
--  Designed and implemented by Dabin Zhang, all rights reserved.   --
----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_arith.all;
--use ieee.std_logic_unsigned.all;  -- DO NOT use "std_logic_signed"

entity bit_select is port
(
	input: in std_logic_vector(23 downto 0);
	output: out std_logic_vector(13 downto 0)
);
end bit_select;

architecture behavioral of bit_select is

begin

output <= input(23) & input(19 downto 7);

end behavioral;