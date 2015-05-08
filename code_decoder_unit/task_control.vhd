----------------------------------------------------------------------
--  This file is part of the FPGA design of the 1.09 GHz Receiver.  --
--  Designed and implemented by Dabin Zhang, all rights reserved.   --
----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;  -- DO NOT use "std_logic_signed"

-- this entity controls the 4 sub-decoder entities
entity task_control is port
(
	clk, reset, mode_s_detected: in std_logic;
	core_0_busy, core_1_busy, core_2_busy, core_3_busy: in std_logic;
	core_0_start, core_1_start, core_2_start, core_3_start: out std_logic;
	core_status: out std_logic_vector(3 downto 0)
);
end task_control;

architecture behavioral of task_control is

signal flag_hold_start_signal, flag_hold_on_signal: std_logic;  -- use this flag to ignore some preambles to avoid mutiple processes decoding the same frame
signal core_busy_signal: std_logic_vector(3 downto 0);

begin

core_busy_signal <= core_3_busy & core_2_busy & core_1_busy & core_0_busy;

core_status_out: process(core_0_busy, core_1_busy, core_2_busy, core_3_busy)
begin
	case core_busy_signal is
		when x"0" => core_status <= x"0";  -- 0 core is busy
		when x"1" => core_status <= x"3";  -- 1 core is busy
		when x"2" => core_status <= x"3";
		when x"4" => core_status <= x"3";
		when x"8" => core_status <= x"3";
		when x"7" => core_status <= x"B";  -- 3 cores are busy
		when x"B" => core_status <= x"B";
		when x"C" => core_status <= x"B";
		when x"E" => core_status <= x"B";
		when x"F" => core_status <= x"F";  -- 4 cores are busy
		when others => core_status <= x"7";  -- 2 cores are busy
	end case;
end process;

-- this process controls the start of each process
-- processes which name have a smaller number have higher priority
start_control: process(clk, reset, mode_s_detected, flag_hold_on_signal, core_0_busy, core_1_busy, core_2_busy, core_3_busy)
begin
	if(reset='1')then
		-- default value
		flag_hold_start_signal <= '0';
		core_0_start <= '0';
		core_1_start <= '0';
		core_2_start <= '0';
		core_3_start <= '0';
	elsif(rising_edge(clk))then  --else--
		-- default value
		flag_hold_start_signal <= '0';
		core_0_start <= '0';
		core_1_start <= '0';
		core_2_start <= '0';
		core_3_start <= '0';
		if(flag_hold_on_signal='1')then null;  -- hold all the core
		else
			if(core_3_busy='0')then  -- elsif
				core_3_start <= mode_s_detected;
				flag_hold_start_signal <= '1';
			elsif(core_3_busy='1' and core_2_busy='0')then
				core_2_start <= mode_s_detected;
				flag_hold_start_signal <= '1';
			elsif(core_3_busy='1' and core_2_busy='1' and core_1_busy='0')then
				core_1_start <= mode_s_detected;
				flag_hold_start_signal <= '1';
			elsif(core_3_busy='1' and core_2_busy='1' and core_1_busy='1' and core_0_busy='0')then
				core_0_start <= mode_s_detected;
				flag_hold_start_signal <= '1';
			else null;
			end if;
		end if;
	end if;
end process;

----disabled on 201307141708 for testing
--flag_hold_on_signal <= '0';
hold_counter: process(clk, reset, flag_hold_start_signal)
	variable counter: std_logic_vector(3 downto 0);
begin
	if(reset='1')then
		flag_hold_on_signal <= '0';
		counter:=x"0";
	elsif(rising_edge(clk))then
		if(counter=x"3")then
		-- with cnt=2, we observed some duplicate frames with timestamp_difference=3 ~10%
		-- with cnt=2, we observed some duplicate frames with timestamp_difference=4 ~1%
			counter:=x"0";
			flag_hold_on_signal <= '0';
		end if;
		if(flag_hold_start_signal='1')then
			flag_hold_on_signal <= '1';
		elsif(flag_hold_on_signal='1')then
			counter:=counter+1;
		end if;
	end if;
end process;

end behavioral;