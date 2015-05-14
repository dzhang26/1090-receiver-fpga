----------------------------------------------------------------------
--  This file is part of the FPGA design of the 1.09 GHz Receiver.  --
--  Designed and implemented by Dabin Zhang, all rights reserved.   --
----------------------------------------------------------------------
-- start adding the read function 201304022329

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;  -- DO NOT use "std_logic_signed"

entity usb_state_machine is port
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
	-- I/O port of FT245RL, DO NOT change. Control signals are active LOW except wr.
	ft245_rxf_n,ft245_txe_n: in std_logic;
	ft245_rd_n,ft245_wr: out std_logic
	-- end of FT245RL I/O
);
end usb_state_machine;

architecture behavioral of usb_state_machine is

signal send_start_flag,send_head_done_flag,send_body_done_flag,send_foot_done_flag: std_logic;

type control_state is
(
	S_idle,S_read_0,S_read_1,S_read_2,S_load,S_check,S_save,  -- check if this frame is same as previous one
	S_send_head,S_send_body,S_send_foot  -- send HEADER, BODY, END of each frame
);
signal current_state,next_state: control_state;

begin

state_machine_reset: process(reset,clk)
begin
	if(reset='1')then
		current_state<=S_idle;
	elsif(rising_edge(clk))then
		current_state<=next_state;
	end if;
end process;

state_machine_control: process(current_state,fifo_empty,ft245_rxf_n,
	send_head_done_flag,send_body_done_flag,send_foot_done_flag,flag_same)
begin
	-- default value
	fifo_read<='0';
	reg_load<='0';
	output_duplexer <= '0';  -- keep output as normal for defalut
	command_en <= '0';
	ft245_rd_n<='1';
	tmp <= x"6";  -- test!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	next_state<=S_idle;  -- test!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	case current_state is
		-- check if there is data in FIFO waiting to be sent
		when S_idle=>
			if(ft245_rxf_n = '0')then  -- we have data to read from USB
				next_state <= S_read_0;
			elsif(fifo_empty='0')then
				next_state<=S_load;
			else next_state<=S_idle;
			end if;
			tmp <= x"1";  -- test!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
		when S_read_0=>
			output_duplexer <= '1';  -- must turn off the output in order to read from the USB
			ft245_rd_n <= '0';
			next_state <= S_read_1;
		when S_read_1=>
			output_duplexer <= '1';  -- must turn off the output in order to read from the USB
			ft245_rd_n <= '0';
			command_en <= '1';
			next_state <= S_read_2;
		when S_read_2=>
			output_duplexer <= '1';  -- must turn off the output in order to read from the USB
			next_state <= S_idle;

		-- load a word from FIFO
		when S_load=>
			fifo_read<='1';
			next_state<=S_check;
		-- check if this frame is same as the previous one
		when S_check=>
			if(flag_same='1')then
				next_state<=S_save;
			else
				next_state<=S_save;
			end if;
		-- save the current frame into the cache
		when S_save=>
			reg_load<='1';
			next_state<=S_send_head;
		-- send the data work to FT245
		when S_send_head=>  -- send frame HEADER "@", change from * to @ on 201304071019
			if(send_head_done_flag='1')then
				send_start_flag<='0';
				next_state<=S_send_body;
			else
				send_start_flag<='1';
				next_state<=S_send_head;
			end if;
			tmp <= x"2";  -- test!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
		when S_send_body=>  -- send frame BODY
			if(send_body_done_flag='1')then
				send_start_flag<='0';
				next_state<=S_send_foot;
			else
				send_start_flag<='1';
				next_state<=S_send_body;
			end if;
			tmp <= x"3";  -- test!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
		when S_send_foot=>  -- send frame END SYMBOL ";<CR><LF>"
			if(send_foot_done_flag='1')then
				send_start_flag<='0';
				next_state<=S_idle;
			else
				send_start_flag<='1';
				next_state<=S_send_foot;
			end if;
			tmp <= x"4";  -- test!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
		when others=> tmp <= x"5";  -- test!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
			--null;
	end case;
end process;

send_word_control: process(clk,reset,current_state,ft245_txe_n,send_start_flag)
	-- state_counter bit [6:2] select 4-bit hex in the word (control the 4-bit 32 to 1 mux)
	-- state_counter bit [1:0] control load and send of the state machine
	variable state_counter: std_logic_vector(8 downto 0);
	-- word_length is the actual length of the word we are going to send
	variable word_length: std_logic_vector(8 downto 0);
begin
	mux_select<=state_counter(8 downto 3);  -- control the MUX
	if(reset='1')then
		send_head_done_flag<='0';
		send_body_done_flag<='0';
		send_foot_done_flag<='0';
		ft245_wr<='0';
		state_counter:="000000000";
		hex_asc_mode<='0';  -- send normal number
		symbol_code<=x"F";  -- default symbol
	elsif(rising_edge(clk) and send_start_flag='1')then
		-- default value
		ft245_wr<='0';
		hex_asc_mode<='0';  -- send normal number
		symbol_code<=x"F";  -- default symbol
		send_head_done_flag<='0';
		send_body_done_flag<='0';
		send_foot_done_flag<='0';
		case data_type is
			when x"0"=> word_length:="100111111";  -- 112-bit (160-bit total)
			when x"1"=> word_length:="011001111";  -- 56-bit (104-bit total)
			when x"2"=> word_length:="000011111";  -- 16-bit
			when x"3"=> word_length:="000010111";  -- 12-bit
			when x"4"=> word_length:="000001111";  -- 8-bit, add @ 201304122308
			when x"5"=> word_length:="001111111";  -- 16-bit (64-bit total)
			when others=> word_length:="111111111";
		end case;
		case current_state is
			when S_load=> null;
			when S_send_head=>
				hex_asc_mode<='1';  -- send symbol instead of normal number
				case state_counter(6 downto 3) is
					when x"0"=> symbol_code<=x"1";
					--when x"1"=> symbol_code<=x"1";  -- send the frame HEADER "@", change from * to @ on 201304071019
					when others=> null;
				end case;
				-- if all the data have been sent, then we exit this process, otherwise increase the counter and continue
				if(state_counter="000000111")then
					state_counter:="000000000";
					send_head_done_flag<='1';
				-- ft245_txe_n='0' indicades FT245 is not busy and we can send data
				elsif(ft245_txe_n='0')then
					if(state_counter(2)='0')then  -- state_counter[0] control WR
						ft245_wr<='1';
					end if;
					state_counter:=state_counter+'1';
				else null;  -- FT245 is busy, thus wait for one cycle and try again
				end if;
			when S_send_body=>
				-- exit this process if all the data have been sent, otherwise increase the counter and continue
				if(state_counter=word_length)then
					state_counter:="000000000";
					send_body_done_flag<='1';
				-- ft245_txe_n='0' indicades FT245 is not busy and we can send data
				elsif(ft245_txe_n='0')then
					if(state_counter(2)='0')then  -- state_counter[2] control WR
						ft245_wr<='1';
					end if;
					state_counter:=state_counter+'1';
				else null;  -- FT245 is busy, wait and try again
				end if;
			when S_send_foot=>
				hex_asc_mode<='1';  -- send the symbol instead of the normal number
				case state_counter(6 downto 3) is
					when x"0"=> symbol_code<=x"3";
					when x"1"=> symbol_code<=x"4";
					when x"2"=> symbol_code<=x"5";
					when others=> null;
				end case;
				-- if we sent all the data then we exit this process, otherwise increase the counter and continue
				if(state_counter="000010111")then
					state_counter:="000000000";
					send_foot_done_flag<='1';
				-- ft245_txe_n='0' indicade FT245 is not busy and we can send data
				elsif(ft245_txe_n='0')then
					if(state_counter(2)='0')then  -- state_counter[2] control WR
						ft245_wr<='1';
					end if;
					state_counter:=state_counter+'1';
				else null;  -- FT245 is busy, we wait and try again
				end if;
			when others=> null;
		end case;
	end if;
end process;

end behavioral;