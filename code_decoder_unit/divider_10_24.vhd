----------------------------------------------------------------------
--  This file is part of the FPGA design of the 1.09 GHz Receiver.  --
--  Designed and implemented by Dabin Zhang, all rights reserved.   --
----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;  -- DO NOT use "std_logic_signed"

entity divider_10_24 is port
(
	di: in std_logic_vector(23 downto 0);
	do: out std_logic_vector(13 downto 0)
);
end divider_10_24;

architecture behavioral of divider_10_24 is

begin

do <= di(23 downto 10);

end behavioral;