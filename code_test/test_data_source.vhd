----------------------------------------------------------------------
--  This file is part of the FPGA design of the 1.09 GHz Receiver.  --
--  Designed and implemented by Dabin Zhang, all rights reserved.   --
----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;  -- DO NOT use "std_logic_signed"

entity test_data_source is port
(
	clk,reset: in std_logic;
	-- I/O of FIFO
	fifo_full: in std_logic;
	fifo_data: out std_logic_vector(179 downto 0);
	fifo_write: out std_logic
);
end test_data_source;

architecture behavioral of test_data_source is

-- signal for the test ROM
signal rom_address: std_logic_vector(3 downto 0);

begin

data_rom: process(rom_address)
begin
	case rom_address is
		when x"0"=> fifo_data<=x"89468B7944F0A4E7839B1D44B1910000"&x"1234567890ABC";
		when x"1"=> fifo_data<=x"8D032F5E29743A75E063C60F861C0000"&x"1234567890ABC";
		when x"2"=> fifo_data<=x"8D8F2A0A315458C3E1638F0E1D240000"&x"1234567890ABC";
		when x"3"=> fifo_data<=x"8CC7BE5C1870EAA3C50D173E30340000"&x"1234567890ABC";
		when x"4"=> fifo_data<=x"8FC3D70B1CBA7A74F0F5C2C7951C0000"&x"1234567890ABC";
		when x"5"=> fifo_data<=x"8FAF0F0A3EC01033C1614500275E0000"&x"1234567890ABC";
		when x"6"=> fifo_data<=x"87878E9E0E0E2D7838F0D5A460810000"&x"1234567890ABC";
		when x"7"=> fifo_data<=x"818387CFEE1A1C5CB89862C2F1C90000"&x"1234567890ABC";
		when x"8"=> fifo_data<=x"83CF0F4E9A3C24F8F0E9D14505CB0000"&x"1234567890ABC";
		when x"9"=> fifo_data<=x"83CE577A7CF88182DA8E1CFC4D610000"&x"1234567890ABC";
		when x"A"=> fifo_data<=x"878C160E787870D1E38F5C4C5AF00000"&x"1234567890ABC";
		when x"B"=> fifo_data<=x"8308863E99F96173C507CE343C2A0000"&x"1234567890ABC";
		when x"C"=> fifo_data<=x"86063CBD7930F1F1E7C5AA86343E0000"&x"1234567890ABC";
		when x"D"=> fifo_data<=x"81A79E8C0C7CA06082E1831E030A0000"&x"1234567890ABC";
		when x"E"=> fifo_data<=x"81C323021C1CB850C8E0C1070F8F0000"&x"1234567890ABC";
--		when x"0"=> fifo_data<=x"8D75805B9944F033C0045DA67C630000";  -- group 1
--		when x"1"=> fifo_data<=x"8D75805B58C392AC308A95C631850000";
--		when x"2"=> fifo_data<=x"8D75805B58C392AC7A8A80C6EFBA0000";
--		when x"3"=> fifo_data<=x"8D75805B9944F033C0045E5994710000";
--		when x"4"=> fifo_data<=x"8D75805B9944EF33C8045E16F8830000";
--		when x"5"=> fifo_data<=x"8D75805B200C50B9DB6820B0ED780000";
--		when x"6"=> fifo_data<=x"8D75805B9944EF33C8045E16F8830000";
--		when x"7"=> fifo_data<=x"8D75805B58C392AED889D234AC390000";
--		when x"8"=> fifo_data<=x"8D75805B9944EF33C0045E785A8B0000";
--		when x"9"=> fifo_data<=x"A028023C2010C231595820AA90010000";  -- group 2
--		when x"A"=> fifo_data<=x"8D484395990052B2E80B027D687F0000";
--		when x"B"=> fifo_data<=x"8D3C65039990FB9E286404A0043E0000";
--		when x"C"=> fifo_data<=x"8D4BAA499945161668800268C26E0000";
--		when x"D"=> fifo_data<=x"8D3C662B903D006914A84A707D6A0000";
--		when x"E"=> fifo_data<=x"8D75804458B9835671AA96E4AE420000";  -- group 3
		when others=> fifo_data<=CONV_STD_LOGIC_VECTOR(0,180);
	end case;
end process;

-- Generates low speed clock signal for FT245, f_clk=50/4/2=6.25MHz
-- Caution: reduce the clock frequency will reduce the data transfer rate (each byte takes 4 clock cycles)
-- This part may be replaced by a PLL
test_data_sender: process(reset,clk)
	variable counter: std_logic_vector(14 downto 0);
begin
	if(reset='1')then
		counter:="000000000000000";
	elsif(clk'event and clk='1')then
		rom_address<=counter(14 downto 11);
		fifo_write<='0';
		--if(counter="11111")then  -- we sent all the data, halt
		--	null;
		--else
			if(counter(10)='1')then
				fifo_write<='1';
			end if;
			counter:=counter+1;
		--end if;
	end if;
end process;

end behavioral;