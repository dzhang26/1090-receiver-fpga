----------------------------------------------------------------------
--  This file is part of the FPGA design of the 1.09 GHz Receiver.  --
--  Designed and implemented by Dabin Zhang, all rights reserved.   --
----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;  -- DO NOT use "std_logic_signed"

entity control_unit is port
(
	clk, reset, clk_l: in std_logic;
	-- input status flags
	f_pll_fault, f_adc_status: in std_logic;
	f_decoder_status: in std_logic_vector(3 downto 0);
	f_decoder_fault, f_usb_read, f_usb_fault: in std_logic;
	led_0, led_1, led_2, led_3: out std_logic;
	-- control command input from USB interface
	command_en: in std_logic;
	command_data: in std_logic_vector(7 downto 0);
	-- control command output
	decoder_snr, decoder_snr_ac: out std_logic_vector(13 downto 0);
	mode_ac_en: out std_logic;
	decoder_control: out std_logic_vector(15 downto 0);
	reset_delay: out std_logic
);
end control_unit;

architecture behavioral of control_unit is

signal reset_delay_signal: std_logic;
signal cmd_0_signal, cmd_1_signal, cmd_2_signal, cmd_3_signal: std_logic_vector(7 downto 0);
--signal flag_snr_set_signal: std_logic;
signal led_0_signal, led_0_flag_signal: std_logic;  --led_0_flag_signal, 

component dff_8 port
(
	aclr: IN STD_LOGIC;
	clock: IN STD_LOGIC;
	data: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
	enable: IN STD_LOGIC;
	q: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
);
end component;

component led_adapter is port
(
	clk,reset,trigger: in std_logic;
	led: out std_logic
);
end component;

component led_flash is port
(
	clk, reset: in std_logic;
	brightness: in std_logic_vector(3 downto 0);
	led_output: out std_logic
);
end component;

begin

-- delay the power-on process for certain block for 0.32 second
reset_delay_signal_control: process(clk_l, reset)
	variable counter: std_logic_vector(11 downto 0);
begin
	if(reset='1')then
		reset_delay_signal <= '1';
		counter := CONV_STD_LOGIC_VECTOR(0,12);
	elsif(rising_edge(clk_l))then
		if(counter(9) = '1')then
			reset_delay_signal <= '0';
		else
			reset_delay_signal <= '1';
			counter := counter + '1';
		end if;
	end if;
end process;
reset_delay <= reset_delay_signal;

cmd_0: dff_8 port map( aclr=>reset, clock=>clk, data=>command_data, enable=>command_en, q=>cmd_0_signal );
cmd_1: dff_8 port map( aclr=>reset, clock=>clk, data=>cmd_0_signal, enable=>command_en, q=>cmd_1_signal );
cmd_2: dff_8 port map( aclr=>reset, clock=>clk, data=>cmd_1_signal, enable=>command_en, q=>cmd_2_signal );
cmd_3: dff_8 port map( aclr=>reset, clock=>clk, data=>cmd_2_signal, enable=>command_en, q=>cmd_3_signal );

control_word_lut: process(reset,clk)
--	variable counter: std_logic_vector(4 downto 0);
begin
	if(reset='1')then  --  or f_pll_fault='1'
		led_0_flag_signal <= '0';
--		flag_snr_set_signal <= '0';
		decoder_snr <= "00000" & x"7" & "00000";  -- default value is 7 (1.75dB)
		decoder_snr_ac <= "00000" & x"7" & "00000";  -- default value is 7 (1.75dB)
		mode_ac_en <= '0';  -- default decode mode-A/C frame
		decoder_control <= "0000000000001101";
	elsif(clk'event and clk='1')then
	
		if( cmd_2_signal = x"53" and cmd_1_signal = x"53" )then  -- input between SS@ to SSO, set decoder SNR
--			flag_snr_set_signal <= '1';
			decoder_snr <= "00000" & cmd_0_signal(3 downto 0) & "00000";
--		elsif(flag_snr_set_signal = '0')then
--			decoder_snr <= "00000" & x"7" & "00000";  -- default value is 7 (1.75dB)
		end if;
		
		if( cmd_2_signal = x"53" and cmd_1_signal = x"41" )then  -- input between SA@ to SAO, set decoder SNR for mode-A/C
--			flag_snr_set_signal <= '1';
			decoder_snr_ac <= "00000" & cmd_0_signal(3 downto 0) & "00000";
--		elsif(flag_snr_set_signal = '0')then
--			decoder_snr <= "00000" & x"7" & "00000";  -- default value is 7 (1.75dB)
		end if;
		
		if( cmd_3_signal = x"77" and cmd_2_signal = x"66" )then  -- input: wfx, write x into flash
			null;  -- add steps here
		end if;
		
		if( cmd_2_signal = x"4D" and cmd_1_signal = x"41" and cmd_0_signal = x"45" )then  -- MAE, turn on mode-A/C decoding
			mode_ac_en <= '1';
		elsif( cmd_2_signal = x"4D" and cmd_1_signal = x"41" and cmd_0_signal = x"44" )then  -- MAD, turn off mode-A/C decoding
			mode_ac_en <= '0';
		end if;
		
		if( cmd_2_signal = x"44" and cmd_1_signal = x"43" and cmd_0_signal = x"38" )then  -- DC8, use 8 groups of preamble detection critiria
			decoder_control(0) <= '1';
		elsif( cmd_2_signal = x"44" and cmd_1_signal = x"43" and cmd_0_signal = x"34" )then  -- DC4, use 4 groups of preamble detection critiria
			decoder_control(0) <= '0';
		end if;
		
		if( cmd_2_signal = x"53" and cmd_1_signal = x"57" )then  -- input between SW@ to SWO, set wait time between preamble and data block
			decoder_control(4 downto 1) <= cmd_0_signal(3 downto 0);  -- dafault is 0110=6
		end if;
		
		
		if(cmd_0_signal = x"61")then  -- turn on led when see command "a"
			led_0_flag_signal <= '1';
		elsif(cmd_0_signal = x"62")then  -- turn off led when see command "b"
			led_0_flag_signal <= '0';
		end if;
		
	end if;
end process;
--led_0<=flag_snr_set_signal;

flash_clock_generater: process(clk_l,reset)
	variable counter: std_logic_vector(8 downto 0);
begin
	if(reset = '1')then
		counter := "000000000";
		led_0_signal <= '0';
	elsif(clk_l'event and clk_l='1')then
		if(led_0_flag_signal = '1')then
			if(counter = "111111111")then
				led_0_signal <= not led_0_signal;
				counter := "000000000";
			else
				counter := counter + '1';
			end if;
		else
			led_0_signal <= '0';
		end if;
	end if;
end process;
led_0 <= led_0_signal;

--led_1 <= '0';-- test f_decoder_busy;

led_0_briteness: led_flash port map
(
	clk => clk, reset => reset,  -- should be clk_l, test
	brightness => f_decoder_status,
	led_output => led_1
);

led_usb: led_adapter port map
(
	clk => clk, reset => reset, trigger => f_usb_read,
	led => led_3
);

led_2 <= command_en or f_decoder_fault or f_pll_fault or f_usb_fault or reset_delay_signal;

end behavioral;