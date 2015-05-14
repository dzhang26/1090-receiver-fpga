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


FUNCTION mux_32to1_4 
(
	data0x[3..0],
	data10x[3..0],
	data11x[3..0],
	data12x[3..0],
	data13x[3..0],
	data14x[3..0],
	data15x[3..0],
	data16x[3..0],
	data17x[3..0],
	data18x[3..0],
	data19x[3..0],
	data1x[3..0],
	data20x[3..0],
	data21x[3..0],
	data22x[3..0],
	data23x[3..0],
	data24x[3..0],
	data25x[3..0],
	data26x[3..0],
	data27x[3..0],
	data28x[3..0],
	data29x[3..0],
	data2x[3..0],
	data30x[3..0],
	data31x[3..0],
	data3x[3..0],
	data4x[3..0],
	data5x[3..0],
	data6x[3..0],
	data7x[3..0],
	data8x[3..0],
	data9x[3..0],
	sel[4..0]
)

RETURNS (
	result[3..0]
);
