----------------------------------------------------------------------
--  This file is part of the FPGA design of the 1.09 GHz Receiver.  --
--  Designed and implemented by Dabin Zhang, all rights reserved.   --
----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;  -- DO NOT use "std_logic_signed"

entity ft245_interface is port
(
	clk,reset: in std_logic;
	-- I/O of FIFO
	fifo_data: in std_logic_vector(179 downto 0);
	fifo_empty: in std_logic;
	fifo_read: out std_logic;
	-- I/O for control unit
	command_en: out std_logic;
	-- I/O port of FT245RL, DO NOT change, connect them directly. Control signals are active LOW except wr
	ft245_rxf_n,ft245_txe_n: in std_logic;
	ft245_data: out std_logic_vector(7 downto 0);
	ft245_rd_n,ft245_wr: out std_logic;
	-- end of FT245RL I/O
	fault: out std_logic--;
--	tmp: out std_logic_vector(3 downto 0)
);
end ft245_interface;

architecture behavioral of ft245_interface is

-- signal for 180-bit register
signal reg_output_signal: std_logic_vector(179 downto 0);
signal reg_load_signal: std_logic;
-- flag for comparing previous and current frame
signal flag_same_signal: std_logic;
-- signal for 4-bit 40 to 1 MUX
signal mux_select_signal: std_logic_vector(5 downto 0);
signal mux_output_signal: std_logic_vector(3 downto 0);
-- signal for 4-bit 2 to 1 MUX for coder input select
signal coder_mux_signal,symbol_code_signal: std_logic_vector(3 downto 0);
-- signal for HEX to ACSII coder
signal hex_asc_mode_signal: std_logic;
signal output_duplexer_signal: std_logic;

--signal tmp_signal: std_logic_vector(3 downto 0);
--signal tmp_reset0, tmp_reset1: std_logic;

component reg_180 is port
(
	aclr: in std_logic;
	clock: in std_logic;
	data: in std_logic_vector(179 downto 0);
	enable: in std_logic;
	q: out std_logic_vector(179 downto 0)
);
end component;

--component reg_8 is port
--(
--	aclr: in std_logic;
--	clock: in std_logic;
--	data: in std_logic_vector(7 downto 0);
--	enable: in std_logic;
--	q: out std_logic_vector(7 downto 0)
--);
--end component;

component mux_40to1_4 is port
(
	data0x,data1x,data2x,data3x,data4x,data5x,data6x,data7x,data8x,data9x,data10x,data11x,data12x,data13x,data14x,data15x,data16x,data17x,data18x,data19x,data20x,data21x,data22x,data23x,data24x,data25x,data26x,data27x,data28x,data29x,data30x,data31x,data32x,data33x,data34x,data35x,data36x,data37x,data38x,data39x: in std_logic_vector(3 downto 0);
	sel: in std_logic_vector(5 downto 0);
	result: out std_logic_vector (3 downto 0)
);
end component;

component mux_21_4 is port
(
	data0x: in std_logic_vector(3 downto 0);
	data1x: in std_logic_vector(3 downto 0);
	sel: in std_logic;
	result: out std_logic_vector(3 downto 0)
);
end component;

component hex_to_asc is port
(
	mode: in std_logic;
	hex_input: in std_logic_vector(3 downto 0);
	output_z: in std_logic;  -- tri-state output control
	asc_output: out std_logic_vector(7 downto 0)
);
end component;

component usb_state_machine is port
(
	tmp: out std_logic_vector(3 downto 0);
	clk,reset: in std_logic;
	data_type: in std_logic_vector(3 downto 0);  -- specify current data word structer
	-- signal which control the other components
	reg_load: out std_logic;
	flag_same: in std_logic;
	mux_select: out std_logic_vector(5 downto 0);
	symbol_code: out std_logic_vector(3 downto 0);
	hex_asc_mode: out std_logic;
	output_duplexer: out std_logic;  -- control output of hex_asc to high impedance or normal value
	command_en: out std_logic;
	-- I/O of FIFO
	fifo_empty: in std_logic;
	fifo_read: out std_logic;
	-- I/O port of FT245RL, DO NOT change  -- control signals are active LOW except wr
	ft245_rxf_n,ft245_txe_n: in std_logic;
	ft245_rd_n,ft245_wr: out std_logic
	-- end of FT245RL I/O
);
end component;

begin

-- save the last frame read from FIFO
data_cache_out: reg_180 port map
(
	aclr=>reset,
	clock=>clk,
	data=>fifo_data,
	enable=>reg_load_signal,
	q=>reg_output_signal
);

-- compare previous frame with current frame
-- only check duplicity for the mode-S data block ([131:20]) but not the time stamp ([179:132]) @ 201305191716
frame_compare: process(clk,reset,fifo_data,reg_output_signal)
begin
	if(reset='1')then
		flag_same_signal<='0';
	elsif(rising_edge(clk))then
		if( fifo_data(131 downto 20) = reg_output_signal(131 downto 20) )then
			flag_same_signal<='1';
		else
			flag_same_signal<='0';
		end if;
	end if;
end process;

-- select 4-bit from the input data word
send_data_select: mux_40to1_4 port map
(
	data0x=>reg_output_signal(179 downto 176),data1x=>reg_output_signal(175 downto 172),data2x=>reg_output_signal(171 downto 168),data3x=>reg_output_signal(167 downto 164),data4x=>reg_output_signal(163 downto 160),data5x=>reg_output_signal(159 downto 156),data6x=>reg_output_signal(155 downto 152),data7x=>reg_output_signal(151 downto 148),data8x=>reg_output_signal(147 downto 144),data9x=>reg_output_signal(143 downto 140),data10x=>reg_output_signal(139 downto 136),data11x=>reg_output_signal(135 downto 132),data12x=>reg_output_signal(131 downto 128),data13x=>reg_output_signal(127 downto 124),data14x=>reg_output_signal(123 downto 120),data15x=>reg_output_signal(119 downto 116),data16x=>reg_output_signal(115 downto 112),data17x=>reg_output_signal(111 downto 108),data18x=>reg_output_signal(107 downto 104),data19x=>reg_output_signal(103 downto 100),data20x=>reg_output_signal(99 downto 96),data21x=>reg_output_signal(95 downto 92),data22x=>reg_output_signal(91 downto 88),data23x=>reg_output_signal(87 downto 84),data24x=>reg_output_signal(83 downto 80),data25x=>reg_output_signal(79 downto 76),data26x=>reg_output_signal(75 downto 72),data27x=>reg_output_signal(71 downto 68),data28x=>reg_output_signal(67 downto 64),data29x=>reg_output_signal(63 downto 60),data30x=>reg_output_signal(59 downto 56),data31x=>reg_output_signal(55 downto 52),data32x=>reg_output_signal(51 downto 48),data33x=>reg_output_signal(47 downto 44),data34x=>reg_output_signal(43 downto 40),data35x=>reg_output_signal(39 downto 36),data36x=>reg_output_signal(35 downto 32),data37x=>reg_output_signal(31 downto 28),data38x=>reg_output_signal(27 downto 24),data39x=>reg_output_signal(23 downto 20),
	sel=>mux_select_signal,
	result=>mux_output_signal
);

coder_input_select: mux_21_4 port map
(
	data0x=>mux_output_signal,
	data1x=>symbol_code_signal,
	sel=>hex_asc_mode_signal,
	result=>coder_mux_signal
);

-- translate the data in HEX format into ACSII code and send it to the FT245
data_coder: hex_to_asc port map
(
	mode=>hex_asc_mode_signal,
	hex_input=>coder_mux_signal,
	output_z => output_duplexer_signal or (not ft245_rxf_n),
	asc_output=>ft245_data
);

fault <= '0'; --tmp_reset1;

control_state_machine: usb_state_machine port map
(
	clk=>clk,
	reset=>reset,--tmp_reset1,
	--tmp => tmp_signal, -- test!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	data_type=>reg_output_signal(3 downto 0),
	-- signal which control the other components
	reg_load=>reg_load_signal,
	flag_same=>flag_same_signal,
	mux_select=>mux_select_signal,
	symbol_code=>symbol_code_signal,
	hex_asc_mode=>hex_asc_mode_signal,
	output_duplexer => output_duplexer_signal,
	command_en => command_en,
	-- I/O of FIFO
	fifo_empty=>fifo_empty,
	fifo_read=>fifo_read,
	-- I/O port of FT245RL, DO NOT change  -- control signals are active LOW except wr
	ft245_rxf_n=>ft245_rxf_n,
	ft245_txe_n=>ft245_txe_n,
	ft245_rd_n=>ft245_rd_n,
	ft245_wr=>ft245_wr
	-- end of FT245RL I/O
);

end behavioral;