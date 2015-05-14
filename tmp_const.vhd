-------------------------------------------------------------------
-- This file is designed for the firmware part of 1.09GHz receiver.
-- Design and implement by Dabin Zhang, all rights reserved.
-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;  -- DO NOT use "std_logic_signed"

-- this entity control 4 sub-decoder entity
entity tmp_const is port
(
	const: out std_logic_vector(179 downto 0)
);
end tmp_const;

architecture behavioral of tmp_const is

begin

const <= x"1234" & x"FEFEFEFEFEFE" & CONV_STD_LOGIC_VECTOR(0,112) & x"5";--x"5";

end behavioral;