-------------------------------------------------------------------
-- This file is designed for the firmware part of 1.09GHz receiver.
-- Design and implement by Dabin Zhang, all rights reserved.
-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;  -- DO NOT use "std_logic_signed"

-- this entity control 4 sub-decoder entity
entity tmp_const_14 is port
(
	const: out std_logic_vector(13 downto 0)
);
end tmp_const_14;

architecture behavioral of tmp_const_14 is

begin

const <= "00000001000000";

end behavioral;