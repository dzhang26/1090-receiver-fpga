----------------------------------------------------------------------
-- This file is designed for the software part of ADS-B receiver.
-- Design and implement written by Dabin Zhang, all rights reserved.
----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;  -- DO NOT use "std_logic_signed"

-- this entity is designed for 16M samples per second
entity test_data_capture is port
(
	clk,reset: in std_logic;
	data_in: in std_logic_vector(11 downto 0);
	sram_address: out std_logic_vector(17 downto 0);
	sram_data: out std_logic_vector(15 downto 0);
	sram_we_not,sram_oe_not,sram_ub_not,sram_lb_not,sram_ce_not,led_halt: out std_logic
);
end test_data_capture;

architecture behavioral of test_data_capture is

signal flag_work_signal,flag_capture_done_signal: std_logic;

type control_state is (S_idle,S_capture,S_check,S_halt);
signal current_state,next_state: control_state;

begin

-- default value, active low
sram_ub_not<='0';
sram_lb_not<='0';
sram_ce_not<='0';

-- sign extension
sram_data<=data_in(11)&data_in(11)&data_in(11)&data_in(11)&data_in;

state_machine_reset: process(reset,clk)
begin
	if(reset='1')then current_state<=S_idle;
	elsif(rising_edge(clk))then current_state<=next_state;
	end if;
end process;

state_machine_control: process(current_state,flag_capture_done_signal)
begin
	-- default value
	led_halt<='0';
	case current_state is
		when S_idle=> next_state<=S_capture;
		when S_capture=>
			if(flag_capture_done_signal='1')then
				flag_work_signal<='0';
				next_state<=S_check;
			else
				flag_work_signal<='1';
				next_state<=S_capture;
			end if;
		when S_check=>
			next_state<=S_halt;
		when S_halt=>
			led_halt<='1';
			next_state<=S_halt;
		when others=> null;
	end case;
end process;

capture_counter: process(clk,reset,current_state)
	-- state_counter bit [18:1] indicate the ram address
	-- state_counter bit [0] contrl set address or save data
	variable state_counter: std_logic_vector(17 downto 0);
begin
	if(reset='1')then  -- asychronize reset
		state_counter:=CONV_STD_LOGIC_VECTOR(0,18);
		flag_capture_done_signal<='0';
--		sram_we_not<='1';
--		sram_oe_not<='1';
	elsif(rising_edge(clk))then
		if(flag_work_signal='1')then
			-- default value
			flag_capture_done_signal<='0';
--			sram_we_not<='1';
--			sram_oe_not<='1';
			case current_state is
				-- reset everything in this state
				when S_idle=>
					state_counter:=CONV_STD_LOGIC_VECTOR(0,18);
				when S_capture=>
--					if(state_counter(0)='0')then
					sram_address<=state_counter(17 downto 0);
--					else
--					sram_we_not<=clk;
--					sram_oe_not<=clk;
--					end if;
					if(state_counter="11"&x"FFFF")then
						flag_capture_done_signal<='1';
						state_counter:=CONV_STD_LOGIC_VECTOR(0,18);
					else
						flag_capture_done_signal<='0';
						state_counter:=state_counter+'1';
					end if;
				when others=> null;
			end case;
		end if;
	end if;
end process;
sram_we_not<=clk;
sram_oe_not<=clk;

end behavioral;