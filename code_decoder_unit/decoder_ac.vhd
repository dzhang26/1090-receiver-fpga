----------------------------------------------------------------------
--  This file is part of the FPGA design of the 1.09 GHz Receiver.  --
--  Designed and implemented by Dabin Zhang, all rights reserved.   --
----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;  -- DO NOT use "std_logic_signed"

entity decoder_ac is port
(
	clk,reset: in std_logic;
	din: in std_logic_vector(89 downto 0);
	frame_out: out std_logic_vector(15 downto 0);
	detected: out std_logic
);
end decoder_ac;

architecture behavioral of decoder_ac is

signal cndt_1_sig, cndt_0_sig, cndt_sig, cndt_null_sig: std_logic;
signal dff_0_sig, dff_1_sig: std_logic;
signal frame_value_sig: std_logic_vector(15 downto 0);

component reg_1_1 port
(
	aclr: IN STD_LOGIC;
	clock: IN STD_LOGIC;
	data: IN STD_LOGIC;
	q: OUT STD_LOGIC
);
end component;

begin

-- actual mode-A/C frame has 4 3-bit word, add a 0 to each word, make it as 4 4-bit word
frame_value_sig <= "0" & ( din(38) or din(37) ) & ( din(26) or din(27) ) & ( din(15) or din(14) ) &
	"0" & ( din(73) or din(72) ) & din(61) & ( din(49) or din(50) ) &
	"0" & din(32) & ( din(20) or din(21) ) & ( din(9) or din(8) ) &
	"0" & ( din(78) or din(79) ) & ( din(67) or din(66) ) & ( din(55) or din(56) );
frame_out <= frame_value_sig;

-- check F1 and F2 bit, both of them have to be 1
cndt_1_sig <= din(3) and din(84);--or din(85) );

-- check X bit and space between data bit, both of them must be 0
cndt_0_sig <= din(1) or din(2) or din(5) or din(6) or din(7) or din(11) or din(12) or din(13) or din(17) or
	din(18) or din(22) or din(23) or din(24) or din(28) or din(29) or din(30) or din(34) or din(35) or
	din(36) or din(40) or din(41) or din(42) or din(43) or din(44) or din(45) or din(46) or din(47) or
	din(51) or din(52) or din(53) or din(57) or din(58) or din(59) or din(63) or din(64) or din(65) or
	din(69) or din(70) or din(71) or din(75) or din(76) or din(80) or din(81) or din(82) or din(86) or din(87) or
	din(19) or din(25) or din(48) or din(54) or din(77) or din(83);

cndt_null_sig <= frame_value_sig(14) or frame_value_sig(13) or frame_value_sig(12) or
	frame_value_sig(10) or frame_value_sig(9) or frame_value_sig(8) or
	frame_value_sig(6) or frame_value_sig(5) or frame_value_sig(4) or 
	frame_value_sig(2) or frame_value_sig(1) or frame_value_sig(0);

cndt_sig <= cndt_1_sig and (not cndt_0_sig) and cndt_null_sig;

dff_0: reg_1_1 port map(aclr=>reset, clock=>clk, data=>cndt_sig, q=>dff_0_sig);
dff_1: reg_1_1 port map(aclr=>reset, clock=>clk, data=>dff_0_sig, q=>dff_1_sig);

frame_detect_signal: process(reset, clk)
begin
	if(reset='1')then
		detected <= '0';
	elsif( rising_edge(clk) )then
		if( dff_0_sig = '1' and dff_1_sig = '0' )then
			detected <= '1';
		else
			detected <= '0';
		end if;
	end if;
end process;

end behavioral;