-- megafunction wizard: %LPM_COMPARE%
-- GENERATION: STANDARD
-- VERSION: WM1.0
-- MODULE: lpm_compare 

-- ============================================================
-- File Name: compare_12.vhd
-- Megafunction Name(s):
-- 			lpm_compare
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

ENTITY compare_12 IS
	PORT
	(
		aclr		: IN STD_LOGIC ;
		clock		: IN STD_LOGIC ;
		dataa		: IN STD_LOGIC_VECTOR (11 DOWNTO 0);
		datab		: IN STD_LOGIC_VECTOR (11 DOWNTO 0);
		AgB		: OUT STD_LOGIC 
	);
END compare_12;


ARCHITECTURE SYN OF compare_12 IS

	SIGNAL sub_wire0	: STD_LOGIC ;



	COMPONENT lpm_compare
	GENERIC (
		lpm_pipeline		: NATURAL;
		lpm_representation		: STRING;
		lpm_type		: STRING;
		lpm_width		: NATURAL
	);
	PORT (
			dataa	: IN STD_LOGIC_VECTOR (11 DOWNTO 0);
			datab	: IN STD_LOGIC_VECTOR (11 DOWNTO 0);
			aclr	: IN STD_LOGIC ;
			clock	: IN STD_LOGIC ;
			AgB	: OUT STD_LOGIC 
	);
	END COMPONENT;

BEGIN
	AgB    <= sub_wire0;

	lpm_compare_component : lpm_compare
	GENERIC MAP (
		lpm_pipeline => 1,
		lpm_representation => "SIGNED",
		lpm_type => "LPM_COMPARE",
		lpm_width => 12
	)
	PORT MAP (
		dataa => dataa,
		datab => datab,
		aclr => aclr,
		clock => clock,
		AgB => sub_wire0
	);



END SYN;

-- ============================================================
-- CNX file retrieval info
-- ============================================================
-- Retrieval info: PRIVATE: AeqB NUMERIC "0"
-- Retrieval info: PRIVATE: AgeB NUMERIC "0"
-- Retrieval info: PRIVATE: AgtB NUMERIC "1"
-- Retrieval info: PRIVATE: AleB NUMERIC "0"
-- Retrieval info: PRIVATE: AltB NUMERIC "0"
-- Retrieval info: PRIVATE: AneB NUMERIC "0"
-- Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone III"
-- Retrieval info: PRIVATE: LPM_PIPELINE NUMERIC "1"
-- Retrieval info: PRIVATE: Latency NUMERIC "1"
-- Retrieval info: PRIVATE: PortBValue NUMERIC "0"
-- Retrieval info: PRIVATE: Radix NUMERIC "10"
-- Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "0"
-- Retrieval info: PRIVATE: SignedCompare NUMERIC "1"
-- Retrieval info: PRIVATE: aclr NUMERIC "1"
-- Retrieval info: PRIVATE: clken NUMERIC "0"
-- Retrieval info: PRIVATE: isPortBConstant NUMERIC "0"
-- Retrieval info: PRIVATE: nBit NUMERIC "12"
-- Retrieval info: CONSTANT: LPM_PIPELINE NUMERIC "1"
-- Retrieval info: CONSTANT: LPM_REPRESENTATION STRING "SIGNED"
-- Retrieval info: CONSTANT: LPM_TYPE STRING "LPM_COMPARE"
-- Retrieval info: CONSTANT: LPM_WIDTH NUMERIC "12"
-- Retrieval info: USED_PORT: AgB 0 0 0 0 OUTPUT NODEFVAL AgB
-- Retrieval info: USED_PORT: aclr 0 0 0 0 INPUT NODEFVAL aclr
-- Retrieval info: USED_PORT: clock 0 0 0 0 INPUT NODEFVAL clock
-- Retrieval info: USED_PORT: dataa 0 0 12 0 INPUT NODEFVAL dataa[11..0]
-- Retrieval info: USED_PORT: datab 0 0 12 0 INPUT NODEFVAL datab[11..0]
-- Retrieval info: CONNECT: AgB 0 0 0 0 @AgB 0 0 0 0
-- Retrieval info: CONNECT: @dataa 0 0 12 0 dataa 0 0 12 0
-- Retrieval info: CONNECT: @datab 0 0 12 0 datab 0 0 12 0
-- Retrieval info: CONNECT: @clock 0 0 0 0 clock 0 0 0 0
-- Retrieval info: CONNECT: @aclr 0 0 0 0 aclr 0 0 0 0
-- Retrieval info: LIBRARY: lpm lpm.lpm_components.all
-- Retrieval info: GEN_FILE: TYPE_NORMAL compare_12.vhd TRUE
-- Retrieval info: GEN_FILE: TYPE_NORMAL compare_12.inc TRUE
-- Retrieval info: GEN_FILE: TYPE_NORMAL compare_12.cmp TRUE
-- Retrieval info: GEN_FILE: TYPE_NORMAL compare_12.bsf TRUE FALSE
-- Retrieval info: GEN_FILE: TYPE_NORMAL compare_12_inst.vhd TRUE
-- Retrieval info: GEN_FILE: TYPE_NORMAL compare_12_waveforms.html TRUE
-- Retrieval info: GEN_FILE: TYPE_NORMAL compare_12_wave*.jpg FALSE
-- Retrieval info: LIB_FILE: lpm
