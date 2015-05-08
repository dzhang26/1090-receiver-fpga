----------------------------------------------------------------------
--  This file is part of the FPGA design of the 1.09 GHz Receiver.  --
--  Designed and implemented by Dabin Zhang, all rights reserved.   --
----------------------------------------------------------------------
-- replace this part later by change state machine in ft245 interface

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;  -- DO NOT use "std_logic_signed"

entity fifo_input_adapter is port
(
	clk,reset: in std_logic;
	raw_data: in std_logic_vector(179 downto 0);
	fifo_data: out std_logic_vector(179 downto 0)
);
end fifo_input_adapter;

architecture behavioral of fifo_input_adapter is

signal mux_data_0_signal,mux_data_1_signal: std_logic_vector(179 downto 0);

component mux_21_180 is port
(
--	aclr: in std_logic:= '0';
--	clock: in std_logic;
	data0x: in std_logic_vector(179 downto 0);
	data1x: in std_logic_vector(179 downto 0);
	sel: in std_logic;
	result: out std_logic_vector(179 downto 0)
);
end component;

begin

mux_data_0_signal(179 downto 132)<=raw_data(179 downto 132);
mux_data_0_signal(19 downto 0)<=raw_data(19 downto 0);
mux_data_0_signal(20)<=raw_data(131);
mux_data_0_signal(21)<=raw_data(130);
mux_data_0_signal(22)<=raw_data(129);
mux_data_0_signal(23)<=raw_data(128);
mux_data_0_signal(24)<=raw_data(127);
mux_data_0_signal(25)<=raw_data(126);
mux_data_0_signal(26)<=raw_data(125);
mux_data_0_signal(27)<=raw_data(124);
mux_data_0_signal(28)<=raw_data(123);
mux_data_0_signal(29)<=raw_data(122);
mux_data_0_signal(30)<=raw_data(121);
mux_data_0_signal(31)<=raw_data(120);
mux_data_0_signal(32)<=raw_data(119);
mux_data_0_signal(33)<=raw_data(118);
mux_data_0_signal(34)<=raw_data(117);
mux_data_0_signal(35)<=raw_data(116);
mux_data_0_signal(36)<=raw_data(115);
mux_data_0_signal(37)<=raw_data(114);
mux_data_0_signal(38)<=raw_data(113);
mux_data_0_signal(39)<=raw_data(112);
mux_data_0_signal(40)<=raw_data(111);
mux_data_0_signal(41)<=raw_data(110);
mux_data_0_signal(42)<=raw_data(109);
mux_data_0_signal(43)<=raw_data(108);
mux_data_0_signal(44)<=raw_data(107);
mux_data_0_signal(45)<=raw_data(106);
mux_data_0_signal(46)<=raw_data(105);
mux_data_0_signal(47)<=raw_data(104);
mux_data_0_signal(48)<=raw_data(103);
mux_data_0_signal(49)<=raw_data(102);
mux_data_0_signal(50)<=raw_data(101);
mux_data_0_signal(51)<=raw_data(100);
mux_data_0_signal(52)<=raw_data(99);
mux_data_0_signal(53)<=raw_data(98);
mux_data_0_signal(54)<=raw_data(97);
mux_data_0_signal(55)<=raw_data(96);
mux_data_0_signal(56)<=raw_data(95);
mux_data_0_signal(57)<=raw_data(94);
mux_data_0_signal(58)<=raw_data(93);
mux_data_0_signal(59)<=raw_data(92);
mux_data_0_signal(60)<=raw_data(91);
mux_data_0_signal(61)<=raw_data(90);
mux_data_0_signal(62)<=raw_data(89);
mux_data_0_signal(63)<=raw_data(88);
mux_data_0_signal(64)<=raw_data(87);
mux_data_0_signal(65)<=raw_data(86);
mux_data_0_signal(66)<=raw_data(85);
mux_data_0_signal(67)<=raw_data(84);
mux_data_0_signal(68)<=raw_data(83);
mux_data_0_signal(69)<=raw_data(82);
mux_data_0_signal(70)<=raw_data(81);
mux_data_0_signal(71)<=raw_data(80);
mux_data_0_signal(72)<=raw_data(79);
mux_data_0_signal(73)<=raw_data(78);
mux_data_0_signal(74)<=raw_data(77);
mux_data_0_signal(75)<=raw_data(76);
mux_data_0_signal(76)<=raw_data(75);
mux_data_0_signal(77)<=raw_data(74);
mux_data_0_signal(78)<=raw_data(73);
mux_data_0_signal(79)<=raw_data(72);
mux_data_0_signal(80)<=raw_data(71);
mux_data_0_signal(81)<=raw_data(70);
mux_data_0_signal(82)<=raw_data(69);
mux_data_0_signal(83)<=raw_data(68);
mux_data_0_signal(84)<=raw_data(67);
mux_data_0_signal(85)<=raw_data(66);
mux_data_0_signal(86)<=raw_data(65);
mux_data_0_signal(87)<=raw_data(64);
mux_data_0_signal(88)<=raw_data(63);
mux_data_0_signal(89)<=raw_data(62);
mux_data_0_signal(90)<=raw_data(61);
mux_data_0_signal(91)<=raw_data(60);
mux_data_0_signal(92)<=raw_data(59);
mux_data_0_signal(93)<=raw_data(58);
mux_data_0_signal(94)<=raw_data(57);
mux_data_0_signal(95)<=raw_data(56);
mux_data_0_signal(96)<=raw_data(55);
mux_data_0_signal(97)<=raw_data(54);
mux_data_0_signal(98)<=raw_data(53);
mux_data_0_signal(99)<=raw_data(52);
mux_data_0_signal(100)<=raw_data(51);
mux_data_0_signal(101)<=raw_data(50);
mux_data_0_signal(102)<=raw_data(49);
mux_data_0_signal(103)<=raw_data(48);
mux_data_0_signal(104)<=raw_data(47);
mux_data_0_signal(105)<=raw_data(46);
mux_data_0_signal(106)<=raw_data(45);
mux_data_0_signal(107)<=raw_data(44);
mux_data_0_signal(108)<=raw_data(43);
mux_data_0_signal(109)<=raw_data(42);
mux_data_0_signal(110)<=raw_data(41);
mux_data_0_signal(111)<=raw_data(40);
mux_data_0_signal(112)<=raw_data(39);
mux_data_0_signal(113)<=raw_data(38);
mux_data_0_signal(114)<=raw_data(37);
mux_data_0_signal(115)<=raw_data(36);
mux_data_0_signal(116)<=raw_data(35);
mux_data_0_signal(117)<=raw_data(34);
mux_data_0_signal(118)<=raw_data(33);
mux_data_0_signal(119)<=raw_data(32);
mux_data_0_signal(120)<=raw_data(31);
mux_data_0_signal(121)<=raw_data(30);
mux_data_0_signal(122)<=raw_data(29);
mux_data_0_signal(123)<=raw_data(28);
mux_data_0_signal(124)<=raw_data(27);
mux_data_0_signal(125)<=raw_data(26);
mux_data_0_signal(126)<=raw_data(25);
mux_data_0_signal(127)<=raw_data(24);
mux_data_0_signal(128)<=raw_data(23);
mux_data_0_signal(129)<=raw_data(22);
mux_data_0_signal(130)<=raw_data(21);
mux_data_0_signal(131)<=raw_data(20);

mux_data_1_signal(179 downto 132)<=raw_data(179 downto 132); -- change 133 to 132 @ 20130601
mux_data_1_signal(75 downto 0)<=raw_data(75 downto 0);
mux_data_1_signal(76)<=raw_data(131);
mux_data_1_signal(77)<=raw_data(130);
mux_data_1_signal(78)<=raw_data(129);
mux_data_1_signal(79)<=raw_data(128);
mux_data_1_signal(80)<=raw_data(127);
mux_data_1_signal(81)<=raw_data(126);
mux_data_1_signal(82)<=raw_data(125);
mux_data_1_signal(83)<=raw_data(124);
mux_data_1_signal(84)<=raw_data(123);
mux_data_1_signal(85)<=raw_data(122);
mux_data_1_signal(86)<=raw_data(121);
mux_data_1_signal(87)<=raw_data(120);
mux_data_1_signal(88)<=raw_data(119);
mux_data_1_signal(89)<=raw_data(118);
mux_data_1_signal(90)<=raw_data(117);
mux_data_1_signal(91)<=raw_data(116);
mux_data_1_signal(92)<=raw_data(115);
mux_data_1_signal(93)<=raw_data(114);
mux_data_1_signal(94)<=raw_data(113);
mux_data_1_signal(95)<=raw_data(112);
mux_data_1_signal(96)<=raw_data(111);
mux_data_1_signal(97)<=raw_data(110);
mux_data_1_signal(98)<=raw_data(109);
mux_data_1_signal(99)<=raw_data(108);
mux_data_1_signal(100)<=raw_data(107);
mux_data_1_signal(101)<=raw_data(106);
mux_data_1_signal(102)<=raw_data(105);
mux_data_1_signal(103)<=raw_data(104);
mux_data_1_signal(104)<=raw_data(103);
mux_data_1_signal(105)<=raw_data(102);
mux_data_1_signal(106)<=raw_data(101);
mux_data_1_signal(107)<=raw_data(100);
mux_data_1_signal(108)<=raw_data(99);
mux_data_1_signal(109)<=raw_data(98);
mux_data_1_signal(110)<=raw_data(97);
mux_data_1_signal(111)<=raw_data(96);
mux_data_1_signal(112)<=raw_data(95);
mux_data_1_signal(113)<=raw_data(94);
mux_data_1_signal(114)<=raw_data(93);
mux_data_1_signal(115)<=raw_data(92);
mux_data_1_signal(116)<=raw_data(91);
mux_data_1_signal(117)<=raw_data(90);
mux_data_1_signal(118)<=raw_data(89);
mux_data_1_signal(119)<=raw_data(88);
mux_data_1_signal(120)<=raw_data(87);
mux_data_1_signal(121)<=raw_data(86);
mux_data_1_signal(122)<=raw_data(85);
mux_data_1_signal(123)<=raw_data(84);
mux_data_1_signal(124)<=raw_data(83);
mux_data_1_signal(125)<=raw_data(82);
mux_data_1_signal(126)<=raw_data(81);
mux_data_1_signal(127)<=raw_data(80);
mux_data_1_signal(128)<=raw_data(79);
mux_data_1_signal(129)<=raw_data(78);
mux_data_1_signal(130)<=raw_data(77);
mux_data_1_signal(131)<=raw_data(76);

data_select: mux_21_180 port map
(
--	aclr=>reset,
--	clock=>clk,
	data0x=>mux_data_0_signal,  -- 112-bit
	data1x=>mux_data_1_signal,  -- 56-bit
	sel=>raw_data(0),--data_type(0),  -- test @ 201306011947
	result=>fifo_data
);

end behavioral;