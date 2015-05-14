----------------------------------------------------------------------
--  This file is part of the FPGA design of the 1.09 GHz Receiver.  --
--  Designed and implemented by Dabin Zhang, all rights reserved.   --
----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;  -- DO NOT use "std_logic_signed"

entity divider_10_34 is port
(
	di: in std_logic_vector(34 downto 0);
	do: out std_logic_vector(23 downto 0)
);
end divider_10_34;

architecture behavioral of divider_10_34 is

begin

do <= di(34)&di(32 downto 10);

end behavioral;