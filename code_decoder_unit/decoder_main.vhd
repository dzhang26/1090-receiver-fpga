----------------------------------------------------------------------
--  This file is part of the FPGA design of the 1.09 GHz Receiver.  --
--  Designed and implemented by Dabin Zhang, all rights reserved.   --
----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;  -- DO NOT use "std_logic_signed"

-- this entity is designed for 16M samples per second
entity decoder_main is port
(
	clk,reset: in std_logic;
	average_3: in std_logic_vector(13 downto 0);
	average_0: in std_logic_vector(13 downto 0);
	core_start,mode_s_detected: in std_logic;
	current_bit_value: in std_logic_vector(1 downto 0);
	time_in: in std_logic_vector(47 downto 0);
	-- control for task controller
	flag_busy: out std_logic;
	-- control signal for FIFO
	fifo_data_raw: out std_logic_vector(179 downto 0);
	fifo_write: out std_logic;
	fifo_full: in std_logic;
	control_cmd: in std_logic_vector(15 downto 0)
);
end decoder_main;

architecture behavioral of decoder_main is

signal flag_bit_error_signal: std_logic;
signal flag_decoding_signal,flag_preamble_0_done_signal,flag_preamble_1_done_signal,flag_format_done_signal,flag_data_done_signal: std_logic;

signal input_level_cache_enable_signal: std_logic;
signal input_level_cache_signal: std_logic_vector(13 downto 0);

signal frame_time_signal: std_logic_vector(47 downto 0);

signal decoded_data_reg_clear_signal,decoded_data_reg_enable_signal: std_logic;
signal decoded_data_reg_signal: std_logic_vector(111 downto 0);
signal data_type_signal: std_logic_vector(3 downto 0);

signal timestamp_load_signal: std_logic;  -- test @ 201306030009
signal timestamp_signal: std_logic_vector(47 downto 0);

type control_state is (S_idle,S_preamble_0,S_preamble_1,S_format,S_data,
	S_wait_0,S_wait_1,S_wait_2,S_save);
signal current_state,next_state: control_state;

component reg_14 is port
(
	aclr,clock,enable: in std_logic;
	data: in std_logic_vector(13 downto 0);
	q: out std_logic_vector(13 downto 0)
);
end component;

component reg_48 is port
(
	aclr,clock,enable: in std_logic;
	data: in std_logic_vector(47 downto 0);
	q: out std_logic_vector(47 downto 0)
);
end component;

-- 112-bit shift register, right shift
component shift_reg_112_1 is port
(
	aclr,sclr,enable,clock,shiftin: in std_logic;
	q: out std_logic_vector(111 downto 0)
);
end component;

begin

input_level_cache: reg_14 port map
(
	aclr=>reset,
	clock=>clk,
	data=>average_0,
	enable=>input_level_cache_enable_signal,
	q=>input_level_cache_signal
);

time_stamp_cache: reg_48 port map
(
	aclr=>reset,
	clock=>clk,
	data=>time_in,
	enable=>timestamp_load_signal,
	q=>timestamp_signal
);

decoded_data_buffer: shift_reg_112_1 port map
(
	aclr=>reset,
	sclr=>decoded_data_reg_clear_signal,
	enable=>decoded_data_reg_enable_signal,
	clock=>clk,
	shiftin=>current_bit_value(0),
	q=>decoded_data_reg_signal
);

-- 201304062323, output data has 180-bit, 48(time_stamp)+112(frame)+16(reserve)+4(type)
--fifo_data_raw <= time_in & decoded_data_reg_signal & x"FFFF" & data_type_signal;
--fifo_data_raw <= frame_time_signal & decoded_data_reg_signal & x"FFFF" & data_type_signal;  -- @ 201306022358
fifo_data_raw <= timestamp_signal & decoded_data_reg_signal & x"FFFF" & data_type_signal;  -- test @ 201306030009


state_machine_reset: process(reset,clk)
begin
	if(reset='1')then current_state<=S_idle;
	elsif(rising_edge(clk))then current_state<=next_state;
	end if;
end process;

state_machine_control: process(current_state,mode_s_detected,
	flag_bit_error_signal,flag_preamble_0_done_signal,flag_preamble_1_done_signal,
	flag_format_done_signal,flag_data_done_signal,core_start,
	time_in)
begin
	-- default value
	input_level_cache_enable_signal<='0';
	decoded_data_reg_clear_signal<='0';
	fifo_write<='0';
	timestamp_load_signal<='0';  -- test @ 201306030007
	case current_state is
		-- wait until a preamble has been detected
		when S_idle=>
			decoded_data_reg_clear_signal<='1';  -- clear decoded data register
			if(core_start='1')then
				input_level_cache_enable_signal<='1';  -- save current voltage level as reference
				next_state<=S_preamble_0;
			else next_state<=S_idle;
			end if;
		-- first part of the preamble
		when S_preamble_0=>
			-- if there's an error during the waiting period, stop
			if(flag_bit_error_signal='1')then  -- if an error is detected, stop waiting for another part of preamble
				next_state<=S_idle;
			-- check if the second part of the preamble is detected after 3.5us
			elsif(flag_preamble_0_done_signal='1')then
				flag_decoding_signal<='0';
				-- second part of the preamble detected
				if(mode_s_detected='1')then
					input_level_cache_enable_signal<='1';  -- save the current voltage level as reference
					next_state<=S_preamble_1;
				else next_state<=S_idle;
				end if;
			else
				flag_decoding_signal<='1';
				next_state<=S_preamble_0;
			end if;
		-- second part of the preamble
		when S_preamble_1=>
			-- wait until the external process received and processed all the sampled points for the current frame
			if(flag_bit_error_signal='1')then  -- if there's an error, stop decoding this frame
				next_state<=S_idle;
			-- go the the next state after 2.5us
			elsif(flag_preamble_1_done_signal='1')then
				flag_decoding_signal<='0';
				next_state<=S_format;
			else
				flag_decoding_signal<='1';
				next_state<=S_preamble_1;
			end if;
		-- decode the format number (first bit)
		when S_format=>
			-- wait until the external process received and processed all the sample point for the current frame
			if(flag_bit_error_signal='1')then  -- if there's an error, stop decoding this frame
				next_state<=S_idle;
			elsif(flag_format_done_signal='1')then
				flag_decoding_signal<='0';
				next_state<=S_data;
			else
				flag_decoding_signal<='1';
				next_state<=S_format;
			end if;
			-- save current time stamp for this frame @ 201304012226
			frame_time_signal <= time_in;
			timestamp_load_signal<='1';  -- test @ 201306030007
		-- decode the rest 55-bit or 111-bit of this frame (total 56/112-bit)
		when S_data=>
			if(flag_bit_error_signal='1')then
				next_state<=S_idle;
			elsif(flag_data_done_signal='1')then
				flag_decoding_signal<='0';
				next_state<=S_wait_0;
			else
				flag_decoding_signal<='1';
				next_state<=S_data;
			end if;
		-- wait for an extra clock cycle to ensure output data is stable
		when S_wait_0=>
			next_state<=S_wait_1;
		when S_wait_1=>
			next_state<=S_save;
		-- save the demodulated data for the current frame to the FIFO, include raw data and data_type_signal code
		when S_save=>
			-- store data to FIFO
			fifo_write<='1';
			next_state<=S_wait_2;
		when S_wait_2=>
			next_state<=S_idle;
		when others=> null;
	end case;
end process;

decode_frame_counter: process(clk,reset,current_state)
	-- state_counter bits [10:4] indicate the total number of bits in the fame (0~54 or 0~106 depend on the format code)
	-- state_counter bits [3:0] indicate the number of sample point in the bit (each bit has 16 sample points devided into 2 parts)
	variable state_counter: std_logic_vector(10 downto 0);
	-- frame_length is the length of the frame (excluding the format code) we are going to decode (55 or 107)
	variable word_length: std_logic_vector(6 downto 0);
begin
	if(reset='1')then  -- asychronize reset
		state_counter:=CONV_STD_LOGIC_VECTOR(0,11);
		word_length:=CONV_STD_LOGIC_VECTOR(0,7);
		flag_preamble_0_done_signal<='0';
		flag_preamble_1_done_signal<='0';
		flag_format_done_signal<='0';
		flag_data_done_signal<='0';
		decoded_data_reg_enable_signal<='0';
		flag_bit_error_signal<='0';
		data_type_signal<=x"1";
	elsif(rising_edge(clk))then
		if(flag_decoding_signal='1')then
			-- default value
			flag_preamble_0_done_signal<='0';
			flag_preamble_1_done_signal<='0';
			flag_format_done_signal<='0';
			flag_data_done_signal<='0';
			decoded_data_reg_enable_signal<='0';
			flag_bit_error_signal<='0';
			case current_state is
				-- reset everything in this state
				when S_idle=>
					word_length:=CONV_STD_LOGIC_VECTOR(0,7);
					state_counter:=CONV_STD_LOGIC_VECTOR(0,11);
				when S_preamble_0=>
--					if(state_counter="00000110111")then  -- if already wait 3.5us  -- wait one more, compensate timming
					-- changed on 201307272230
					if(state_counter="00000110110")then  -- if already wait 3.5us  -- wait one less, compensate timming
						state_counter:=CONV_STD_LOGIC_VECTOR(0,11);
						flag_preamble_0_done_signal<='1';
					else
						-- made the following change @ 201307141511
						-- double CHECK the criteria!!!!!!!!!!!!!!!!!!!!!!!!!!
						-- change from 00000010100 to 1111 @ 20130727
						if((state_counter<"00000000111")and(input_level_cache_signal(12 downto 0)<average_3(12 downto 0)))then  -- we got an error
--						if( (state_counter>"00000100000") and (input_level_cache_signal(12 downto 0)<average_3(12 downto 0)) )then  -- we got an error
			--				flag_bit_error_signal<='1';  -- test @ 20130723
						end if;
						flag_preamble_0_done_signal<='0';
						state_counter:=state_counter+'1';
					end if;
				when S_preamble_1=>
--					if(state_counter="00000100110")then  -- if already wait 2.5us
					-- changed on 201307272230; changed from 00000010110 to 00000011001 @ 20130728
					-- changed on 201308022302 from 00000010110 to "0000001"&control_cmd(4 downto 1)
					if(state_counter="0000001"&control_cmd(4 downto 1))then  -- if already wait 1.7us (wait .2us more to reach the peak)
						state_counter:=CONV_STD_LOGIC_VECTOR(0,11);
						flag_preamble_1_done_signal<='1';
					else  --  @ 201307232250
						-- change from 00000010100 to 11111 @ 20130727
						if((state_counter<"00000001111")and(input_level_cache_signal(12 downto 0)<average_3(12 downto 0)))then  -- we got an error
--						if((state_counter<"00000100100")and(input_level_cache_signal(12 downto 0)<average_3(12 downto 0)))then  -- we got an error
							flag_bit_error_signal<='1';
						end if;
						flag_preamble_1_done_signal<='0';
						state_counter:=state_counter+'1';
					end if;
				when S_format=>
					-- the threshold value of state_counter should be 00001001111 which stands for 5 full clock cycles
					-- however, there's one clock cycle delay when the threshold is reached and it delays the decoding process by 1 clock cycle
					-- to slove this problem, reduce the threshold value to 00001001110
					if(state_counter="00000001110")then
						if(current_bit_value(1)='1')then  -- we got an error
							flag_bit_error_signal<='1';
						else
							decoded_data_reg_enable_signal<='1';
						end if;
						if(current_bit_value(0)='0')then
							-- this is a 56-bit frame since the first bit is 0
							-- we have another 55-bit to decode and the threshold is 55 (0~55, one more cycle)
							word_length:="0110110";
							data_type_signal<=x"1";  -- set proper data type code into FIFO for the USB interface
						else
							-- this is a 112-bit frame since the first bit is 1
							-- there are another 111-bit to decode and the threshold is 110
							word_length:="1101110";
							data_type_signal<=x"0";
						end if;
						flag_format_done_signal<='1';
						state_counter:=CONV_STD_LOGIC_VECTOR(0,11);
					else
						flag_format_done_signal<='0';
						state_counter:=state_counter+'1';
					end if;
				when S_data=>
					-- store the value of the current bit to the buffer register
					if(state_counter(3 downto 0)="1111")then
						if(current_bit_value(1)='1')then  -- got an error
							flag_bit_error_signal<='1';
							state_counter:=CONV_STD_LOGIC_VECTOR(0,11);  -- test
						else
							decoded_data_reg_enable_signal<='1';
						end if;
					end if;
					if(state_counter=word_length&"1111")then
						flag_data_done_signal<='1';
						state_counter:=CONV_STD_LOGIC_VECTOR(0,11);
					else
						flag_data_done_signal<='0';
						state_counter:=state_counter+'1';
					end if;
				when others=> null;
			end case;
		else
			flag_preamble_0_done_signal<='0';
			flag_preamble_1_done_signal<='0';
			decoded_data_reg_enable_signal<='0';  -- make sure the shift register has been disabled
		end if;
	end if;
end process;

status_output: process(current_state)
begin
	case current_state is
		when S_idle=> flag_busy<='0';
		when others=> flag_busy<='1';
	end case;
end process;

end behavioral;