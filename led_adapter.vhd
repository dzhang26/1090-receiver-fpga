-------------------------------------------------------------------
-- This file is designed for the firmware part of 1.09GHz receiver.
-- Design and implement by Dabin Zhang, all rights reserved.
-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;  -- DO NOT use "std_logic_signed"

entity led_adapter is port
(
	clk,reset,trigger: in std_logic;
	led: out std_logic
);
end led_adapter;

architecture behavioral of led_adapter is

signal flag_hold_end: std_logic;

type control_state is (S_idle,S_hold);
signal current_state,next_state: control_state;

begin

state_machine_reset: process(reset,clk)
begin
	if(reset='1')then current_state<=S_idle;
	elsif(rising_edge(clk))then current_state<=next_state;
	end if;
end process;

state_machine_control: process(current_state,trigger,flag_hold_end)
begin
	-- default value
	led<='0';
	case current_state is
		when S_idle=>
			if(trigger='1')then
				next_state<=S_hold;
			else
				next_state<=S_idle;
			end if;
		when S_hold=>
			led<='1';
			if(flag_hold_end='1')then
				next_state<=S_idle;
			else
				next_state<=S_hold;
			end if;
		when others=> null;
	end case;
end process;

hold_counter: process(clk,reset,trigger)
	variable counter: std_logic_vector(15 downto 0);
begin
	if(reset='1')then
		counter:=x"0000";
		flag_hold_end<='0';
	elsif(rising_edge(clk))then
		flag_hold_end<='0';
		case current_state is
			when S_idle=>
				counter:=x"0000";
			when S_hold=>
				if(trigger='1')then
					counter:=x"0000";
				elsif(counter=x"07FF")then  -- set hold time here
					counter:=x"0000";
					flag_hold_end<='1';
				else
					counter:=counter+'1';
				end if;
		end case;
	end if;
end process;

end behavioral;