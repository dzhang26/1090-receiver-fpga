-- megafunction wizard: %LPM_ADD_SUB%
-- GENERATION: STANDARD
-- VERSION: WM1.0
-- MODULE: lpm_add_sub 

-- ============================================================
-- File Name: adder_24_d1.vhd
-- Megafunction Name(s):
-- 			lpm_add_sub
--
-- Simulation Library Files(s):
-- 			lpm
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

LIBRARY lpm;
USE lpm.all;

ENTITY adder_24_d1 IS
	PORT
	(
		aclr		: IN STD_LOGIC ;
		clock		: IN STD_LOGIC ;
		dataa		: IN STD_LOGIC_VECTOR (23 DOWNTO 0);
		datab		: IN STD_LOGIC_VECTOR (23 DOWNTO 0);
		overflow		: OUT STD_LOGIC ;
		result		: OUT STD_LOGIC_VECTOR (23 DOWNTO 0)
	);
END adder_24_d1;


ARCHITECTURE SYN OF adder_24_d1 IS

	SIGNAL sub_wire0	: STD_LOGIC ;
	SIGNAL sub_wire1	: STD_LOGIC_VECTOR (23 DOWNTO 0);



	COMPONENT lpm_add_sub
	GENERIC (
		lpm_direction		: STRING;
		lpm_hint		: STRING;
		lpm_pipeline		: NATURAL;
		lpm_representation		: STRING;
		lpm_type		: STRING;
		lpm_width		: NATURAL
	);
	PORT (
			dataa	: IN STD_LOGIC_VECTOR (23 DOWNTO 0);
			datab	: IN STD_LOGIC_VECTOR (23 DOWNTO 0);
			overflow	: OUT STD_LOGIC ;
			aclr	: IN STD_LOGIC ;
			clock	: IN STD_LOGIC ;
			result	: OUT STD_LOGIC_VECTOR (23 DOWNTO 0)
	);
	END COMPONENT;

BEGIN
	overflow    <= sub_wire0;
	result    <= sub_wire1(23 DOWNTO 0);

	lpm_add_sub_component : lpm_add_sub
	GENERIC MAP (
		lpm_direction => "ADD",
		lpm_hint => "ONE_INPUT_IS_CONSTANT=NO,CIN_USED=NO",
		lpm_pipeline => 1,
		lpm_representation => "SIGNED",
		lpm_type => "LPM_ADD_SUB",
		lpm_width => 24
	)
	PORT MAP (
		dataa => dataa,
		datab => datab,
		aclr => aclr,
		clock => clock,
		overflow => sub_wire0,
		result => sub_wire1
	);



END SYN;

-- ============================================================
-- CNX file retrieval info
-- ============================================================
-- Retrieval info: PRIVATE: CarryIn NUMERIC "0"
-- Retrieval info: PRIVATE: CarryOut NUMERIC "0"
-- Retrieval info: PRIVATE: ConstantA NUMERIC "0"
-- Retrieval info: PRIVATE: ConstantB NUMERIC "0"
-- Retrieval info: PRIVATE: Function NUMERIC "0"
-- Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone III"
-- Retrieval info: PRIVATE: LPM_PIPELINE NUMERIC "1"
-- Retrieval info: PRIVATE: Latency NUMERIC "1"
-- Retrieval info: PRIVATE: Overflow NUMERIC "1"
-- Retrieval info: PRIVATE: RadixA NUMERIC "10"
-- Retrieval info: PRIVATE: RadixB NUMERIC "10"
-- Retrieval info: PRIVATE: Representation NUMERIC "0"
-- Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "0"
-- Retrieval info: PRIVATE: ValidCtA NUMERIC "0"
-- Retrieval info: PRIVATE: ValidCtB NUMERIC "0"
-- Retrieval info: PRIVATE: WhichConstant NUMERIC "0"
-- Retrieval info: PRIVATE: aclr NUMERIC "1"
-- Retrieval info: PRIVATE: clken NUMERIC "0"
-- Retrieval info: PRIVATE: nBit NUMERIC "24"
-- Retrieval info: CONSTANT: LPM_DIRECTION STRING "ADD"
-- Retrieval info: CONSTANT: LPM_HINT STRING "ONE_INPUT_IS_CONSTANT=NO,CIN_USED=NO"
-- Retrieval info: CONSTANT: LPM_PIPELINE NUMERIC "1"
-- Retrieval info: CONSTANT: LPM_REPRESENTATION STRING "SIGNED"
-- Retrieval info: CONSTANT: LPM_TYPE STRING "LPM_ADD_SUB"
-- Retrieval info: CONSTANT: LPM_WIDTH NUMERIC "24"
-- Retrieval info: USED_PORT: aclr 0 0 0 0 INPUT NODEFVAL aclr
-- Retrieval info: USED_PORT: clock 0 0 0 0 INPUT NODEFVAL clock
-- Retrieval info: USED_PORT: dataa 0 0 24 0 INPUT NODEFVAL dataa[23..0]
-- Retrieval info: USED_PORT: datab 0 0 24 0 INPUT NODEFVAL datab[23..0]
-- Retrieval info: USED_PORT: overflow 0 0 0 0 OUTPUT NODEFVAL overflow
-- Retrieval info: USED_PORT: result 0 0 24 0 OUTPUT NODEFVAL result[23..0]
-- Retrieval info: CONNECT: result 0 0 24 0 @result 0 0 24 0
-- Retrieval info: CONNECT: @dataa 0 0 24 0 dataa 0 0 24 0
-- Retrieval info: CONNECT: @datab 0 0 24 0 datab 0 0 24 0
-- Retrieval info: CONNECT: overflow 0 0 0 0 @overflow 0 0 0 0
-- Retrieval info: CONNECT: @clock 0 0 0 0 clock 0 0 0 0
-- Retrieval info: CONNECT: @aclr 0 0 0 0 aclr 0 0 0 0
-- Retrieval info: LIBRARY: lpm lpm.lpm_components.all
-- Retrieval info: GEN_FILE: TYPE_NORMAL adder_24_d1.vhd TRUE
-- Retrieval info: GEN_FILE: TYPE_NORMAL adder_24_d1.inc FALSE
-- Retrieval info: GEN_FILE: TYPE_NORMAL adder_24_d1.cmp TRUE
-- Retrieval info: GEN_FILE: TYPE_NORMAL adder_24_d1.bsf TRUE FALSE
-- Retrieval info: GEN_FILE: TYPE_NORMAL adder_24_d1_inst.vhd FALSE
-- Retrieval info: GEN_FILE: TYPE_NORMAL adder_24_d1_waveforms.html TRUE
-- Retrieval info: GEN_FILE: TYPE_NORMAL adder_24_d1_wave*.jpg FALSE
-- Retrieval info: LIB_FILE: lpm
