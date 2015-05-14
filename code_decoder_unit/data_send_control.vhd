----------------------------------------------------------------------
--  This file is part of the FPGA design of the 1.09 GHz Receiver.  --
--  Designed and implemented by Dabin Zhang, all rights reserved.   --
----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;  -- DO NOT use "std_logic_signed"

-- this entity controls 4 sub-decoder entities
entity data_send_control is port
(
	clk, reset: in std_logic;
	-- control/data signal for the decoder core
	core_0_data, core_1_data, core_2_data, core_3_data, core_4_data: in std_logic_vector(179 downto 0);
	core_0_empty, core_1_empty, core_2_empty, core_3_empty, core_4_empty: in std_logic;
	core_0_read, core_1_read, core_2_read, core_3_read, core_4_read: out std_logic;
	-- control/data signal for the final FIFO
	fifo_data: out std_logic_vector(179 downto 0);
	fifo_write: out std_logic
);
end data_send_control;

architecture behavioral of data_send_control is

signal fifo_mux_select_signal: std_logic_vector(2 downto 0);

type control_state is (S_check_0, S_wait_0, S_send_0, S_check_1, S_wait_1, S_send_1,
	S_check_2, S_wait_2, S_send_2, S_check_3, S_wait_3, S_send_3, S_check_4, S_wait_4, S_send_4);
signal current_state, next_state: control_state;

component mux_51_180_p1 is port
(
	aclr: in std_logic:='0';
	clock: in std_logic;
	data0x: in std_logic_vector(179 downto 0);
	data1x: in std_logic_vector(179 downto 0);
	data2x: in std_logic_vector(179 downto 0);
	data3x: in std_logic_vector(179 downto 0);
	data4x: in std_logic_vector(179 downto 0);
	sel: in std_logic_vector(2 downto 0);
	result: out std_logic_vector(179 downto 0)
);
end component;

begin

decoder_buffer_mux: mux_51_180_p1 port map
(
	aclr=>reset, 
	clock=>clk, 
	data0x=>core_0_data, 
	data1x=>core_1_data, 
	data2x=>core_2_data, 
	data3x=>core_3_data, 
	data4x=>core_4_data, 
	sel=>fifo_mux_select_signal, 
	result=>fifo_data
);

-- this state machine controls the write function of FIFO
state_machine_reset: process(reset, clk)
begin
	if(reset='1')then
		current_state <= S_check_0;
	elsif(rising_edge(clk))then
		current_state <= next_state;
	end if;
end process;

state_machine_control: process(clk, reset, current_state, 
	core_0_empty, core_1_empty, core_2_empty, core_3_empty, core_4_empty)
begin
	case current_state is
	
		when S_check_0=>
			fifo_mux_select_signal <= "000";
			if(core_0_empty='0')then
				next_state <= S_wait_0;
			else
				next_state <= S_check_1;
			end if;
		when S_wait_0=>
			fifo_mux_select_signal <= "000";
			next_state <= S_send_0;
		when S_send_0=>
			fifo_mux_select_signal <= "000";
			next_state <= S_check_1;
			
		when S_check_1=>
			fifo_mux_select_signal <= "001";
			if(core_1_empty='0')then
				next_state <= S_wait_1;
			else
				next_state <= S_check_2;
			end if;
		when S_wait_1=>
			fifo_mux_select_signal <= "001";
			next_state <= S_send_1;
		when S_send_1=>
			fifo_mux_select_signal <= "001";
			next_state <= S_check_2;
			
		when S_check_2=>
			fifo_mux_select_signal <= "010";
			if(core_2_empty='0')then
				next_state <= S_wait_2;
			else
				next_state <= S_check_3;
			end if;
		when S_wait_2=>
			fifo_mux_select_signal <= "010";
			next_state <= S_send_2;
		when S_send_2=>
			fifo_mux_select_signal <= "010";
			next_state <= S_check_3;
			
		when S_check_3=>
			fifo_mux_select_signal <= "011";
			if(core_3_empty='0')then
				next_state <= S_wait_3;
			else
				next_state <= S_check_4;
			end if;
		when S_wait_3=>
			fifo_mux_select_signal <= "011";
			next_state <= S_send_3;
		when S_send_3=>
			fifo_mux_select_signal <= "011";
			next_state <= S_check_4;
			
		when S_check_4=>
			fifo_mux_select_signal <= "100";
			if(core_4_empty='0')then
				next_state <= S_wait_4;
			else
				next_state <= S_check_0;
			end if;
		when S_wait_4=>
			fifo_mux_select_signal <= "100";
			next_state <= S_send_4;
		when S_send_4=>
			fifo_mux_select_signal <= "100";
			next_state <= S_check_0;
			
		when others=> null;
	end case;
end process;

fifo_control: process(clk, reset, current_state,
	core_0_empty, core_1_empty, core_2_empty, core_3_empty, core_4_empty)
begin
	if(reset='1')then
		-- default value
		core_0_read <= '0';
		core_1_read <= '0';
		core_2_read <= '0';
		core_3_read <= '0';
		core_4_read <= '0';
		fifo_write <= '0';
	elsif(rising_edge(clk))then
		-- default value
		core_0_read <= '0';
		core_1_read <= '0';
		core_2_read <= '0';
		core_3_read <= '0';
		core_4_read <= '0';
		fifo_write <= '0';
		case current_state is
		
			when S_check_0=>
				if(core_0_empty='0')then
					core_0_read <= '1';
				end if;
			when S_send_0=>
				fifo_write <= '1';
				
			when S_check_1=>
				if(core_1_empty='0')then
					core_1_read <= '1';
				end if;
			when S_send_1=>
				fifo_write <= '1';
				
			when S_check_2=>
				if(core_2_empty='0')then
					core_2_read <= '1';
				end if;
			when S_send_2=>
				fifo_write <= '1';
				
			when S_check_3=>
				if(core_3_empty='0')then
					core_3_read <= '1';
				end if;
			when S_send_3=>
				fifo_write <= '1';
				
			when S_check_4=>
				if(core_4_empty='0')then
					core_4_read <= '1';
				end if;
			when S_send_4=>
				fifo_write <= '1';
				
			when others=> null;
		end case;
	end if;
end process;

end behavioral;