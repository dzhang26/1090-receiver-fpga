-- megafunction wizard: %PARALLEL_ADD%
-- GENERATION: STANDARD
-- VERSION: WM1.0
-- MODULE: parallel_add 

-- ============================================================
-- File Name: adder_parallel_fir.vhd
-- Megafunction Name(s):
-- 			parallel_add
--
-- Simulation Library Files(s):
-- 			altera_mf
-- ============================================================
-- ************************************************************
-- THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
--
-- 9.1 Build 350 03/24/2010 SP 2 SJ Web Edition
-- ************************************************************


--Copyright (C) 1991-2010 Altera Corporation
--Your use of Altera Corporation's design tools, logic functions 
--and other software and tools, and its AMPP partner logic 
--functions, and any output files from any of the foregoing 
--(including device programming or simulation files), and any 
--associated documentation or information are expressly subject 
--to the terms and conditions of the Altera Program License 
--Subscription Agreement, Altera MegaCore Function License 
--Agreement, or other applicable license agreement, including, 
--without limitation, that your use is for the sole purpose of 
--programming logic devices manufactured by Altera and sold by 
--Altera or its authorized distributors.  Please refer to the 
--applicable agreement for further details.


LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;

ENTITY adder_parallel_fir IS
	PORT
	(
		aclr		: IN STD_LOGIC  := '0';
		clock		: IN STD_LOGIC  := '0';
		data0x		: IN STD_LOGIC_VECTOR (19 DOWNTO 0);
		data10x		: IN STD_LOGIC_VECTOR (19 DOWNTO 0);
		data11x		: IN STD_LOGIC_VECTOR (19 DOWNTO 0);
		data1x		: IN STD_LOGIC_VECTOR (19 DOWNTO 0);
		data2x		: IN STD_LOGIC_VECTOR (19 DOWNTO 0);
		data3x		: IN STD_LOGIC_VECTOR (19 DOWNTO 0);
		data4x		: IN STD_LOGIC_VECTOR (19 DOWNTO 0);
		data5x		: IN STD_LOGIC_VECTOR (19 DOWNTO 0);
		data6x		: IN STD_LOGIC_VECTOR (19 DOWNTO 0);
		data7x		: IN STD_LOGIC_VECTOR (19 DOWNTO 0);
		data8x		: IN STD_LOGIC_VECTOR (19 DOWNTO 0);
		data9x		: IN STD_LOGIC_VECTOR (19 DOWNTO 0);
		result		: OUT STD_LOGIC_VECTOR (23 DOWNTO 0)
	);
END adder_parallel_fir;


ARCHITECTURE SYN OF adder_parallel_fir IS

--	type ALTERA_MF_LOGIC_2D is array (NATURAL RANGE <>, NATURAL RANGE <>) of STD_LOGIC;

	SIGNAL sub_wire0	: STD_LOGIC_VECTOR (23 DOWNTO 0);
	SIGNAL sub_wire1	: STD_LOGIC_VECTOR (19 DOWNTO 0);
	SIGNAL sub_wire2	: ALTERA_MF_LOGIC_2D (11 DOWNTO 0, 19 DOWNTO 0);
	SIGNAL sub_wire3	: STD_LOGIC_VECTOR (19 DOWNTO 0);
	SIGNAL sub_wire4	: STD_LOGIC_VECTOR (19 DOWNTO 0);
	SIGNAL sub_wire5	: STD_LOGIC_VECTOR (19 DOWNTO 0);
	SIGNAL sub_wire6	: STD_LOGIC_VECTOR (19 DOWNTO 0);
	SIGNAL sub_wire7	: STD_LOGIC_VECTOR (19 DOWNTO 0);
	SIGNAL sub_wire8	: STD_LOGIC_VECTOR (19 DOWNTO 0);
	SIGNAL sub_wire9	: STD_LOGIC_VECTOR (19 DOWNTO 0);
	SIGNAL sub_wire10	: STD_LOGIC_VECTOR (19 DOWNTO 0);
	SIGNAL sub_wire11	: STD_LOGIC_VECTOR (19 DOWNTO 0);
	SIGNAL sub_wire12	: STD_LOGIC_VECTOR (19 DOWNTO 0);
	SIGNAL sub_wire13	: STD_LOGIC_VECTOR (19 DOWNTO 0);

BEGIN
	sub_wire13    <= data0x(19 DOWNTO 0);
	sub_wire12    <= data1x(19 DOWNTO 0);
	sub_wire11    <= data2x(19 DOWNTO 0);
	sub_wire10    <= data3x(19 DOWNTO 0);
	sub_wire9    <= data4x(19 DOWNTO 0);
	sub_wire8    <= data5x(19 DOWNTO 0);
	sub_wire7    <= data6x(19 DOWNTO 0);
	sub_wire6    <= data7x(19 DOWNTO 0);
	sub_wire5    <= data8x(19 DOWNTO 0);
	sub_wire4    <= data9x(19 DOWNTO 0);
	sub_wire3    <= data10x(19 DOWNTO 0);
	result    <= sub_wire0(23 DOWNTO 0);
	sub_wire1    <= data11x(19 DOWNTO 0);
	sub_wire2(11, 0)    <= sub_wire1(0);
	sub_wire2(11, 1)    <= sub_wire1(1);
	sub_wire2(11, 2)    <= sub_wire1(2);
	sub_wire2(11, 3)    <= sub_wire1(3);
	sub_wire2(11, 4)    <= sub_wire1(4);
	sub_wire2(11, 5)    <= sub_wire1(5);
	sub_wire2(11, 6)    <= sub_wire1(6);
	sub_wire2(11, 7)    <= sub_wire1(7);
	sub_wire2(11, 8)    <= sub_wire1(8);
	sub_wire2(11, 9)    <= sub_wire1(9);
	sub_wire2(11, 10)    <= sub_wire1(10);
	sub_wire2(11, 11)    <= sub_wire1(11);
	sub_wire2(11, 12)    <= sub_wire1(12);
	sub_wire2(11, 13)    <= sub_wire1(13);
	sub_wire2(11, 14)    <= sub_wire1(14);
	sub_wire2(11, 15)    <= sub_wire1(15);
	sub_wire2(11, 16)    <= sub_wire1(16);
	sub_wire2(11, 17)    <= sub_wire1(17);
	sub_wire2(11, 18)    <= sub_wire1(18);
	sub_wire2(11, 19)    <= sub_wire1(19);
	sub_wire2(10, 0)    <= sub_wire3(0);
	sub_wire2(10, 1)    <= sub_wire3(1);
	sub_wire2(10, 2)    <= sub_wire3(2);
	sub_wire2(10, 3)    <= sub_wire3(3);
	sub_wire2(10, 4)    <= sub_wire3(4);
	sub_wire2(10, 5)    <= sub_wire3(5);
	sub_wire2(10, 6)    <= sub_wire3(6);
	sub_wire2(10, 7)    <= sub_wire3(7);
	sub_wire2(10, 8)    <= sub_wire3(8);
	sub_wire2(10, 9)    <= sub_wire3(9);
	sub_wire2(10, 10)    <= sub_wire3(10);
	sub_wire2(10, 11)    <= sub_wire3(11);
	sub_wire2(10, 12)    <= sub_wire3(12);
	sub_wire2(10, 13)    <= sub_wire3(13);
	sub_wire2(10, 14)    <= sub_wire3(14);
	sub_wire2(10, 15)    <= sub_wire3(15);
	sub_wire2(10, 16)    <= sub_wire3(16);
	sub_wire2(10, 17)    <= sub_wire3(17);
	sub_wire2(10, 18)    <= sub_wire3(18);
	sub_wire2(10, 19)    <= sub_wire3(19);
	sub_wire2(9, 0)    <= sub_wire4(0);
	sub_wire2(9, 1)    <= sub_wire4(1);
	sub_wire2(9, 2)    <= sub_wire4(2);
	sub_wire2(9, 3)    <= sub_wire4(3);
	sub_wire2(9, 4)    <= sub_wire4(4);
	sub_wire2(9, 5)    <= sub_wire4(5);
	sub_wire2(9, 6)    <= sub_wire4(6);
	sub_wire2(9, 7)    <= sub_wire4(7);
	sub_wire2(9, 8)    <= sub_wire4(8);
	sub_wire2(9, 9)    <= sub_wire4(9);
	sub_wire2(9, 10)    <= sub_wire4(10);
	sub_wire2(9, 11)    <= sub_wire4(11);
	sub_wire2(9, 12)    <= sub_wire4(12);
	sub_wire2(9, 13)    <= sub_wire4(13);
	sub_wire2(9, 14)    <= sub_wire4(14);
	sub_wire2(9, 15)    <= sub_wire4(15);
	sub_wire2(9, 16)    <= sub_wire4(16);
	sub_wire2(9, 17)    <= sub_wire4(17);
	sub_wire2(9, 18)    <= sub_wire4(18);
	sub_wire2(9, 19)    <= sub_wire4(19);
	sub_wire2(8, 0)    <= sub_wire5(0);
	sub_wire2(8, 1)    <= sub_wire5(1);
	sub_wire2(8, 2)    <= sub_wire5(2);
	sub_wire2(8, 3)    <= sub_wire5(3);
	sub_wire2(8, 4)    <= sub_wire5(4);
	sub_wire2(8, 5)    <= sub_wire5(5);
	sub_wire2(8, 6)    <= sub_wire5(6);
	sub_wire2(8, 7)    <= sub_wire5(7);
	sub_wire2(8, 8)    <= sub_wire5(8);
	sub_wire2(8, 9)    <= sub_wire5(9);
	sub_wire2(8, 10)    <= sub_wire5(10);
	sub_wire2(8, 11)    <= sub_wire5(11);
	sub_wire2(8, 12)    <= sub_wire5(12);
	sub_wire2(8, 13)    <= sub_wire5(13);
	sub_wire2(8, 14)    <= sub_wire5(14);
	sub_wire2(8, 15)    <= sub_wire5(15);
	sub_wire2(8, 16)    <= sub_wire5(16);
	sub_wire2(8, 17)    <= sub_wire5(17);
	sub_wire2(8, 18)    <= sub_wire5(18);
	sub_wire2(8, 19)    <= sub_wire5(19);
	sub_wire2(7, 0)    <= sub_wire6(0);
	sub_wire2(7, 1)    <= sub_wire6(1);
	sub_wire2(7, 2)    <= sub_wire6(2);
	sub_wire2(7, 3)    <= sub_wire6(3);
	sub_wire2(7, 4)    <= sub_wire6(4);
	sub_wire2(7, 5)    <= sub_wire6(5);
	sub_wire2(7, 6)    <= sub_wire6(6);
	sub_wire2(7, 7)    <= sub_wire6(7);
	sub_wire2(7, 8)    <= sub_wire6(8);
	sub_wire2(7, 9)    <= sub_wire6(9);
	sub_wire2(7, 10)    <= sub_wire6(10);
	sub_wire2(7, 11)    <= sub_wire6(11);
	sub_wire2(7, 12)    <= sub_wire6(12);
	sub_wire2(7, 13)    <= sub_wire6(13);
	sub_wire2(7, 14)    <= sub_wire6(14);
	sub_wire2(7, 15)    <= sub_wire6(15);
	sub_wire2(7, 16)    <= sub_wire6(16);
	sub_wire2(7, 17)    <= sub_wire6(17);
	sub_wire2(7, 18)    <= sub_wire6(18);
	sub_wire2(7, 19)    <= sub_wire6(19);
	sub_wire2(6, 0)    <= sub_wire7(0);
	sub_wire2(6, 1)    <= sub_wire7(1);
	sub_wire2(6, 2)    <= sub_wire7(2);
	sub_wire2(6, 3)    <= sub_wire7(3);
	sub_wire2(6, 4)    <= sub_wire7(4);
	sub_wire2(6, 5)    <= sub_wire7(5);
	sub_wire2(6, 6)    <= sub_wire7(6);
	sub_wire2(6, 7)    <= sub_wire7(7);
	sub_wire2(6, 8)    <= sub_wire7(8);
	sub_wire2(6, 9)    <= sub_wire7(9);
	sub_wire2(6, 10)    <= sub_wire7(10);
	sub_wire2(6, 11)    <= sub_wire7(11);
	sub_wire2(6, 12)    <= sub_wire7(12);
	sub_wire2(6, 13)    <= sub_wire7(13);
	sub_wire2(6, 14)    <= sub_wire7(14);
	sub_wire2(6, 15)    <= sub_wire7(15);
	sub_wire2(6, 16)    <= sub_wire7(16);
	sub_wire2(6, 17)    <= sub_wire7(17);
	sub_wire2(6, 18)    <= sub_wire7(18);
	sub_wire2(6, 19)    <= sub_wire7(19);
	sub_wire2(5, 0)    <= sub_wire8(0);
	sub_wire2(5, 1)    <= sub_wire8(1);
	sub_wire2(5, 2)    <= sub_wire8(2);
	sub_wire2(5, 3)    <= sub_wire8(3);
	sub_wire2(5, 4)    <= sub_wire8(4);
	sub_wire2(5, 5)    <= sub_wire8(5);
	sub_wire2(5, 6)    <= sub_wire8(6);
	sub_wire2(5, 7)    <= sub_wire8(7);
	sub_wire2(5, 8)    <= sub_wire8(8);
	sub_wire2(5, 9)    <= sub_wire8(9);
	sub_wire2(5, 10)    <= sub_wire8(10);
	sub_wire2(5, 11)    <= sub_wire8(11);
	sub_wire2(5, 12)    <= sub_wire8(12);
	sub_wire2(5, 13)    <= sub_wire8(13);
	sub_wire2(5, 14)    <= sub_wire8(14);
	sub_wire2(5, 15)    <= sub_wire8(15);
	sub_wire2(5, 16)    <= sub_wire8(16);
	sub_wire2(5, 17)    <= sub_wire8(17);
	sub_wire2(5, 18)    <= sub_wire8(18);
	sub_wire2(5, 19)    <= sub_wire8(19);
	sub_wire2(4, 0)    <= sub_wire9(0);
	sub_wire2(4, 1)    <= sub_wire9(1);
	sub_wire2(4, 2)    <= sub_wire9(2);
	sub_wire2(4, 3)    <= sub_wire9(3);
	sub_wire2(4, 4)    <= sub_wire9(4);
	sub_wire2(4, 5)    <= sub_wire9(5);
	sub_wire2(4, 6)    <= sub_wire9(6);
	sub_wire2(4, 7)    <= sub_wire9(7);
	sub_wire2(4, 8)    <= sub_wire9(8);
	sub_wire2(4, 9)    <= sub_wire9(9);
	sub_wire2(4, 10)    <= sub_wire9(10);
	sub_wire2(4, 11)    <= sub_wire9(11);
	sub_wire2(4, 12)    <= sub_wire9(12);
	sub_wire2(4, 13)    <= sub_wire9(13);
	sub_wire2(4, 14)    <= sub_wire9(14);
	sub_wire2(4, 15)    <= sub_wire9(15);
	sub_wire2(4, 16)    <= sub_wire9(16);
	sub_wire2(4, 17)    <= sub_wire9(17);
	sub_wire2(4, 18)    <= sub_wire9(18);
	sub_wire2(4, 19)    <= sub_wire9(19);
	sub_wire2(3, 0)    <= sub_wire10(0);
	sub_wire2(3, 1)    <= sub_wire10(1);
	sub_wire2(3, 2)    <= sub_wire10(2);
	sub_wire2(3, 3)    <= sub_wire10(3);
	sub_wire2(3, 4)    <= sub_wire10(4);
	sub_wire2(3, 5)    <= sub_wire10(5);
	sub_wire2(3, 6)    <= sub_wire10(6);
	sub_wire2(3, 7)    <= sub_wire10(7);
	sub_wire2(3, 8)    <= sub_wire10(8);
	sub_wire2(3, 9)    <= sub_wire10(9);
	sub_wire2(3, 10)    <= sub_wire10(10);
	sub_wire2(3, 11)    <= sub_wire10(11);
	sub_wire2(3, 12)    <= sub_wire10(12);
	sub_wire2(3, 13)    <= sub_wire10(13);
	sub_wire2(3, 14)    <= sub_wire10(14);
	sub_wire2(3, 15)    <= sub_wire10(15);
	sub_wire2(3, 16)    <= sub_wire10(16);
	sub_wire2(3, 17)    <= sub_wire10(17);
	sub_wire2(3, 18)    <= sub_wire10(18);
	sub_wire2(3, 19)    <= sub_wire10(19);
	sub_wire2(2, 0)    <= sub_wire11(0);
	sub_wire2(2, 1)    <= sub_wire11(1);
	sub_wire2(2, 2)    <= sub_wire11(2);
	sub_wire2(2, 3)    <= sub_wire11(3);
	sub_wire2(2, 4)    <= sub_wire11(4);
	sub_wire2(2, 5)    <= sub_wire11(5);
	sub_wire2(2, 6)    <= sub_wire11(6);
	sub_wire2(2, 7)    <= sub_wire11(7);
	sub_wire2(2, 8)    <= sub_wire11(8);
	sub_wire2(2, 9)    <= sub_wire11(9);
	sub_wire2(2, 10)    <= sub_wire11(10);
	sub_wire2(2, 11)    <= sub_wire11(11);
	sub_wire2(2, 12)    <= sub_wire11(12);
	sub_wire2(2, 13)    <= sub_wire11(13);
	sub_wire2(2, 14)    <= sub_wire11(14);
	sub_wire2(2, 15)    <= sub_wire11(15);
	sub_wire2(2, 16)    <= sub_wire11(16);
	sub_wire2(2, 17)    <= sub_wire11(17);
	sub_wire2(2, 18)    <= sub_wire11(18);
	sub_wire2(2, 19)    <= sub_wire11(19);
	sub_wire2(1, 0)    <= sub_wire12(0);
	sub_wire2(1, 1)    <= sub_wire12(1);
	sub_wire2(1, 2)    <= sub_wire12(2);
	sub_wire2(1, 3)    <= sub_wire12(3);
	sub_wire2(1, 4)    <= sub_wire12(4);
	sub_wire2(1, 5)    <= sub_wire12(5);
	sub_wire2(1, 6)    <= sub_wire12(6);
	sub_wire2(1, 7)    <= sub_wire12(7);
	sub_wire2(1, 8)    <= sub_wire12(8);
	sub_wire2(1, 9)    <= sub_wire12(9);
	sub_wire2(1, 10)    <= sub_wire12(10);
	sub_wire2(1, 11)    <= sub_wire12(11);
	sub_wire2(1, 12)    <= sub_wire12(12);
	sub_wire2(1, 13)    <= sub_wire12(13);
	sub_wire2(1, 14)    <= sub_wire12(14);
	sub_wire2(1, 15)    <= sub_wire12(15);
	sub_wire2(1, 16)    <= sub_wire12(16);
	sub_wire2(1, 17)    <= sub_wire12(17);
	sub_wire2(1, 18)    <= sub_wire12(18);
	sub_wire2(1, 19)    <= sub_wire12(19);
	sub_wire2(0, 0)    <= sub_wire13(0);
	sub_wire2(0, 1)    <= sub_wire13(1);
	sub_wire2(0, 2)    <= sub_wire13(2);
	sub_wire2(0, 3)    <= sub_wire13(3);
	sub_wire2(0, 4)    <= sub_wire13(4);
	sub_wire2(0, 5)    <= sub_wire13(5);
	sub_wire2(0, 6)    <= sub_wire13(6);
	sub_wire2(0, 7)    <= sub_wire13(7);
	sub_wire2(0, 8)    <= sub_wire13(8);
	sub_wire2(0, 9)    <= sub_wire13(9);
	sub_wire2(0, 10)    <= sub_wire13(10);
	sub_wire2(0, 11)    <= sub_wire13(11);
	sub_wire2(0, 12)    <= sub_wire13(12);
	sub_wire2(0, 13)    <= sub_wire13(13);
	sub_wire2(0, 14)    <= sub_wire13(14);
	sub_wire2(0, 15)    <= sub_wire13(15);
	sub_wire2(0, 16)    <= sub_wire13(16);
	sub_wire2(0, 17)    <= sub_wire13(17);
	sub_wire2(0, 18)    <= sub_wire13(18);
	sub_wire2(0, 19)    <= sub_wire13(19);

	parallel_add_component : parallel_add
	GENERIC MAP (
		msw_subtract => "NO",
		pipeline => 2,
		representation => "SIGNED",
		result_alignment => "LSB",
		shift => 0,
		size => 12,
		width => 20,
		widthr => 24,
		lpm_type => "parallel_add"
	)
	PORT MAP (
		clock => clock,
		aclr => aclr,
		data => sub_wire2,
		result => sub_wire0
	);



END SYN;

-- ============================================================
-- CNX file retrieval info
-- ============================================================
-- Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone III"
-- Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "0"
-- Retrieval info: LIBRARY: altera_mf altera_mf.altera_mf_components.all
-- Retrieval info: CONSTANT: MSW_SUBTRACT STRING "NO"
-- Retrieval info: CONSTANT: PIPELINE NUMERIC "2"
-- Retrieval info: CONSTANT: REPRESENTATION STRING "SIGNED"
-- Retrieval info: CONSTANT: RESULT_ALIGNMENT STRING "LSB"
-- Retrieval info: CONSTANT: SHIFT NUMERIC "0"
-- Retrieval info: CONSTANT: SIZE NUMERIC "12"
-- Retrieval info: CONSTANT: WIDTH NUMERIC "20"
-- Retrieval info: CONSTANT: WIDTHR NUMERIC "24"
-- Retrieval info: USED_PORT: aclr 0 0 0 0 INPUT GND "aclr"
-- Retrieval info: USED_PORT: clock 0 0 0 0 INPUT GND "clock"
-- Retrieval info: USED_PORT: data0x 0 0 20 0 INPUT NODEFVAL "data0x[19..0]"
-- Retrieval info: USED_PORT: data10x 0 0 20 0 INPUT NODEFVAL "data10x[19..0]"
-- Retrieval info: USED_PORT: data11x 0 0 20 0 INPUT NODEFVAL "data11x[19..0]"
-- Retrieval info: USED_PORT: data1x 0 0 20 0 INPUT NODEFVAL "data1x[19..0]"
-- Retrieval info: USED_PORT: data2x 0 0 20 0 INPUT NODEFVAL "data2x[19..0]"
-- Retrieval info: USED_PORT: data3x 0 0 20 0 INPUT NODEFVAL "data3x[19..0]"
-- Retrieval info: USED_PORT: data4x 0 0 20 0 INPUT NODEFVAL "data4x[19..0]"
-- Retrieval info: USED_PORT: data5x 0 0 20 0 INPUT NODEFVAL "data5x[19..0]"
-- Retrieval info: USED_PORT: data6x 0 0 20 0 INPUT NODEFVAL "data6x[19..0]"
-- Retrieval info: USED_PORT: data7x 0 0 20 0 INPUT NODEFVAL "data7x[19..0]"
-- Retrieval info: USED_PORT: data8x 0 0 20 0 INPUT NODEFVAL "data8x[19..0]"
-- Retrieval info: USED_PORT: data9x 0 0 20 0 INPUT NODEFVAL "data9x[19..0]"
-- Retrieval info: USED_PORT: result 0 0 24 0 OUTPUT NODEFVAL "result[23..0]"
-- Retrieval info: CONNECT: @data 1 6 20 0 data6x 0 0 20 0
-- Retrieval info: CONNECT: @data 1 11 20 0 data11x 0 0 20 0
-- Retrieval info: CONNECT: @data 1 5 20 0 data5x 0 0 20 0
-- Retrieval info: CONNECT: @data 1 10 20 0 data10x 0 0 20 0
-- Retrieval info: CONNECT: @data 1 4 20 0 data4x 0 0 20 0
-- Retrieval info: CONNECT: @data 1 3 20 0 data3x 0 0 20 0
-- Retrieval info: CONNECT: @data 1 2 20 0 data2x 0 0 20 0
-- Retrieval info: CONNECT: @aclr 0 0 0 0 aclr 0 0 0 0
-- Retrieval info: CONNECT: @data 1 1 20 0 data1x 0 0 20 0
-- Retrieval info: CONNECT: @data 1 0 20 0 data0x 0 0 20 0
-- Retrieval info: CONNECT: result 0 0 24 0 @result 0 0 24 0
-- Retrieval info: CONNECT: @clock 0 0 0 0 clock 0 0 0 0
-- Retrieval info: CONNECT: @data 1 9 20 0 data9x 0 0 20 0
-- Retrieval info: CONNECT: @data 1 8 20 0 data8x 0 0 20 0
-- Retrieval info: CONNECT: @data 1 7 20 0 data7x 0 0 20 0
-- Retrieval info: GEN_FILE: TYPE_NORMAL adder_parallel_fir.vhd TRUE
-- Retrieval info: GEN_FILE: TYPE_NORMAL adder_parallel_fir.inc FALSE
-- Retrieval info: GEN_FILE: TYPE_NORMAL adder_parallel_fir.cmp TRUE
-- Retrieval info: GEN_FILE: TYPE_NORMAL adder_parallel_fir.bsf TRUE
-- Retrieval info: GEN_FILE: TYPE_NORMAL adder_parallel_fir_inst.vhd FALSE
-- Retrieval info: LIB_FILE: altera_mf
