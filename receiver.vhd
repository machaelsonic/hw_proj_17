-- Copyright (C) 1991-2012 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- PROGRAM		"Quartus II 64-Bit"
-- VERSION		"Version 12.1 Build 177 11/07/2012 SJ Full Version"
-- CREATED		"Tue Aug 01 15:33:07 2017"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY receiver IS 
	PORT
	(
		rst :  IN  STD_LOGIC;
		clk :  IN  STD_LOGIC;
		data_in :  IN  STD_LOGIC_VECTOR(11 DOWNTO 0);
		fft_sink_ready :  OUT  STD_LOGIC;
		fft_source_sop :  OUT  STD_LOGIC;
		fft_source_eop :  OUT  STD_LOGIC;
		fft_source_valid :  OUT  STD_LOGIC;
		demap_sink_sop :  OUT  STD_LOGIC;
		demap_sink_eop :  OUT  STD_LOGIC;
		demap_sink_valid :  OUT  STD_LOGIC;
		pre_cnt :  OUT  STD_LOGIC;
		fft_sop :  OUT  STD_LOGIC;
		fft_eop :  OUT  STD_LOGIC;
		fft_data_valid :  OUT  STD_LOGIC;
		a_r :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		cnt_o :  OUT  STD_LOGIC_VECTOR(8 DOWNTO 0);
		demap_dout :  OUT  STD_LOGIC_VECTOR(35 DOWNTO 0);
		fft_source_eeror :  OUT  STD_LOGIC_VECTOR(1 DOWNTO 0);
		fft_source_exp :  OUT  STD_LOGIC_VECTOR(5 DOWNTO 0);
		fft_source_imag :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		fft_source_imag_delay :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		fft_source_imag_delay_1 :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		fft_source_real :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		fft_source_real_delay :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		fft_source_real_delay_1 :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		max_p :  OUT  STD_LOGIC_VECTOR(8 DOWNTO 0);
		max_value :  OUT  STD_LOGIC_VECTOR(20 DOWNTO 0);
		p_cnt_o :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);
		rcv_data :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		rcv_data_delay :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		rt_i :  OUT  STD_LOGIC_VECTOR(24 DOWNTO 0);
		rt_r :  OUT  STD_LOGIC_VECTOR(24 DOWNTO 0);
		syn_point :  OUT  STD_LOGIC_VECTOR(8 DOWNTO 0);
		x_cor1 :  OUT  STD_LOGIC_VECTOR(20 DOWNTO 0);
		x_cor2 :  OUT  STD_LOGIC_VECTOR(20 DOWNTO 0)
	);
END receiver;

ARCHITECTURE bdf_type OF receiver IS 

COMPONENT x_cor
	PORT(rst_n : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 din : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		 dout1 : OUT STD_LOGIC_VECTOR(20 DOWNTO 0);
		 dout2 : OUT STD_LOGIC_VECTOR(20 DOWNTO 0)
	);
END COMPONENT;

COMPONENT div
	PORT(rst_n : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 din2 : IN STD_LOGIC_VECTOR(20 DOWNTO 0);
		 pre_cnt_o : OUT STD_LOGIC;
		 cnt_o : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
		 max_p : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
		 max_value : OUT STD_LOGIC_VECTOR(20 DOWNTO 0);
		 p_cnt_o : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 syn_point : OUT STD_LOGIC_VECTOR(8 DOWNTO 0)
	);
END COMPONENT;

COMPONENT sop_eop_gen
	PORT(rst_n : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 pre_cnt : IN STD_LOGIC;
		 sop : OUT STD_LOGIC;
		 eop : OUT STD_LOGIC;
		 data_valid : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT mult_complex_ip
	PORT(dataa_imag : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		 dataa_real : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		 datab_imag : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		 datab_real : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		 result_imag : OUT STD_LOGIC_VECTOR(24 DOWNTO 0);
		 result_real : OUT STD_LOGIC_VECTOR(24 DOWNTO 0)
	);
END COMPONENT;

COMPONENT add_ip
	PORT(datab : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
	);
END COMPONENT;

COMPONENT fft_ip
	PORT(clk : IN STD_LOGIC;
		 reset_n : IN STD_LOGIC;
		 clk_ena : IN STD_LOGIC;
		 inverse : IN STD_LOGIC;
		 sink_valid : IN STD_LOGIC;
		 sink_sop : IN STD_LOGIC;
		 sink_eop : IN STD_LOGIC;
		 source_ready : IN STD_LOGIC;
		 sink_error : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 sink_imag : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		 sink_real : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		 sink_ready : OUT STD_LOGIC;
		 source_sop : OUT STD_LOGIC;
		 source_eop : OUT STD_LOGIC;
		 source_valid : OUT STD_LOGIC;
		 source_error : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		 source_exp : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
		 source_imag : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
		 source_real : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
	);
END COMPONENT;

COMPONENT fifo_ip
	PORT(wrreq : IN STD_LOGIC;
		 rdreq : IN STD_LOGIC;
		 clock : IN STD_LOGIC;
		 aclr : IN STD_LOGIC;
		 data : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		 q : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
	);
END COMPONENT;

COMPONENT data_out
	PORT(rst_n : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 sink_eop : IN STD_LOGIC;
		 sink_valid : IN STD_LOGIC;
		 din : IN STD_LOGIC_VECTOR(35 DOWNTO 0);
		 data_valid : OUT STD_LOGIC;
		 dout : OUT STD_LOGIC_VECTOR(35 DOWNTO 0)
	);
END COMPONENT;

COMPONENT fifo_ip_8
	PORT(wrreq : IN STD_LOGIC;
		 rdreq : IN STD_LOGIC;
		 clock : IN STD_LOGIC;
		 aclr : IN STD_LOGIC;
		 data : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		 q : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
	);
END COMPONENT;

COMPONENT de_map
GENERIC (N : INTEGER
			);
	PORT(rst_n : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 source_valid : IN STD_LOGIC;
		 source_sop : IN STD_LOGIC;
		 din_imag : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		 din_imag_clc : IN STD_LOGIC_VECTOR(24 DOWNTO 0);
		 din_real : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		 din_real_clc : IN STD_LOGIC_VECTOR(24 DOWNTO 0);
		 sink_sop : OUT STD_LOGIC;
		 sink_eop : OUT STD_LOGIC;
		 sink_valid : OUT STD_LOGIC;
		 dout : OUT STD_LOGIC_VECTOR(35 DOWNTO 0);
		 dout_imag : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
		 dout_real : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	a_i :  STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL	a_r_ALTERA_SYNTHESIZED :  STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL	fft_data_valid_ALTERA_SYNTHESIZED :  STD_LOGIC;
SIGNAL	fft_eop_ALTERA_SYNTHESIZED :  STD_LOGIC;
SIGNAL	fft_sop_ALTERA_SYNTHESIZED :  STD_LOGIC;
SIGNAL	fft_source_imag_ALTERA_SYNTHESIZED :  STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL	fft_source_imag_delay_ALTERA_SYNTHESIZED0 :  STD_LOGIC;
SIGNAL	fft_source_imag_delay_ALTERA_SYNTHESIZED1 :  STD_LOGIC;
SIGNAL	fft_source_imag_delay_ALTERA_SYNTHESIZED10 :  STD_LOGIC;
SIGNAL	fft_source_imag_delay_ALTERA_SYNTHESIZED11 :  STD_LOGIC;
SIGNAL	fft_source_imag_delay_ALTERA_SYNTHESIZED110 :  STD_LOGIC;
SIGNAL	fft_source_imag_delay_ALTERA_SYNTHESIZED111 :  STD_LOGIC;
SIGNAL	fft_source_imag_delay_ALTERA_SYNTHESIZED12 :  STD_LOGIC;
SIGNAL	fft_source_imag_delay_ALTERA_SYNTHESIZED13 :  STD_LOGIC;
SIGNAL	fft_source_imag_delay_ALTERA_SYNTHESIZED14 :  STD_LOGIC;
SIGNAL	fft_source_imag_delay_ALTERA_SYNTHESIZED15 :  STD_LOGIC;
SIGNAL	fft_source_imag_delay_ALTERA_SYNTHESIZED16 :  STD_LOGIC;
SIGNAL	fft_source_imag_delay_ALTERA_SYNTHESIZED17 :  STD_LOGIC;
SIGNAL	fft_source_imag_delay_ALTERA_SYNTHESIZED18 :  STD_LOGIC;
SIGNAL	fft_source_imag_delay_ALTERA_SYNTHESIZED19 :  STD_LOGIC;
SIGNAL	fft_source_imag_delay_ALTERA_SYNTHESIZED2 :  STD_LOGIC;
SIGNAL	fft_source_imag_delay_ALTERA_SYNTHESIZED3 :  STD_LOGIC;
SIGNAL	fft_source_imag_delay_ALTERA_SYNTHESIZED4 :  STD_LOGIC;
SIGNAL	fft_source_imag_delay_ALTERA_SYNTHESIZED5 :  STD_LOGIC;
SIGNAL	fft_source_imag_delay_ALTERA_SYNTHESIZED6 :  STD_LOGIC;
SIGNAL	fft_source_imag_delay_ALTERA_SYNTHESIZED7 :  STD_LOGIC;
SIGNAL	fft_source_imag_delay_ALTERA_SYNTHESIZED8 :  STD_LOGIC;
SIGNAL	fft_source_imag_delay_ALTERA_SYNTHESIZED9 :  STD_LOGIC;
SIGNAL	fft_source_real_ALTERA_SYNTHESIZED :  STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL	fft_source_real_delay_ALTERA_SYNTHESIZED0 :  STD_LOGIC;
SIGNAL	fft_source_real_delay_ALTERA_SYNTHESIZED1 :  STD_LOGIC;
SIGNAL	fft_source_real_delay_ALTERA_SYNTHESIZED10 :  STD_LOGIC;
SIGNAL	fft_source_real_delay_ALTERA_SYNTHESIZED11 :  STD_LOGIC;
SIGNAL	fft_source_real_delay_ALTERA_SYNTHESIZED110 :  STD_LOGIC;
SIGNAL	fft_source_real_delay_ALTERA_SYNTHESIZED111 :  STD_LOGIC;
SIGNAL	fft_source_real_delay_ALTERA_SYNTHESIZED12 :  STD_LOGIC;
SIGNAL	fft_source_real_delay_ALTERA_SYNTHESIZED13 :  STD_LOGIC;
SIGNAL	fft_source_real_delay_ALTERA_SYNTHESIZED14 :  STD_LOGIC;
SIGNAL	fft_source_real_delay_ALTERA_SYNTHESIZED15 :  STD_LOGIC;
SIGNAL	fft_source_real_delay_ALTERA_SYNTHESIZED16 :  STD_LOGIC;
SIGNAL	fft_source_real_delay_ALTERA_SYNTHESIZED17 :  STD_LOGIC;
SIGNAL	fft_source_real_delay_ALTERA_SYNTHESIZED18 :  STD_LOGIC;
SIGNAL	fft_source_real_delay_ALTERA_SYNTHESIZED19 :  STD_LOGIC;
SIGNAL	fft_source_real_delay_ALTERA_SYNTHESIZED2 :  STD_LOGIC;
SIGNAL	fft_source_real_delay_ALTERA_SYNTHESIZED3 :  STD_LOGIC;
SIGNAL	fft_source_real_delay_ALTERA_SYNTHESIZED4 :  STD_LOGIC;
SIGNAL	fft_source_real_delay_ALTERA_SYNTHESIZED5 :  STD_LOGIC;
SIGNAL	fft_source_real_delay_ALTERA_SYNTHESIZED6 :  STD_LOGIC;
SIGNAL	fft_source_real_delay_ALTERA_SYNTHESIZED7 :  STD_LOGIC;
SIGNAL	fft_source_real_delay_ALTERA_SYNTHESIZED8 :  STD_LOGIC;
SIGNAL	fft_source_real_delay_ALTERA_SYNTHESIZED9 :  STD_LOGIC;
SIGNAL	fft_source_sop_ALTERA_SYNTHESIZED :  STD_LOGIC;
SIGNAL	fft_source_valid_ALTERA_SYNTHESIZED :  STD_LOGIC;
SIGNAL	pre_cnt_ALTERA_SYNTHESIZED :  STD_LOGIC;
SIGNAL	rcv_data_ALTERA_SYNTHESIZED :  STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL	rcv_data_delay_ALTERA_SYNTHESIZED :  STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL	rst_n :  STD_LOGIC;
SIGNAL	rt_i_ALTERA_SYNTHESIZED :  STD_LOGIC_VECTOR(24 DOWNTO 0);
SIGNAL	rt_r_ALTERA_SYNTHESIZED :  STD_LOGIC_VECTOR(24 DOWNTO 0);
SIGNAL	x_cor_ALTERA_SYNTHESIZED2 :  STD_LOGIC_VECTOR(20 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC_VECTOR(0 TO 1);
SIGNAL	SYNTHESIZED_WIRE_4 :  STD_LOGIC_VECTOR(0 TO 11);
SIGNAL	SYNTHESIZED_WIRE_12 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_7 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_8 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_9 :  STD_LOGIC_VECTOR(35 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_13 :  STD_LOGIC;

SIGNAL	GDFX_TEMP_SIGNAL_2 :  STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_4 :  STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_7 :  STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_0 :  STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_3 :  STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_5 :  STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_6 :  STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_1 :  STD_LOGIC_VECTOR(11 DOWNTO 0);

BEGIN 
demap_sink_eop <= SYNTHESIZED_WIRE_7;
SYNTHESIZED_WIRE_1 <= '1';
SYNTHESIZED_WIRE_2 <= '0';
SYNTHESIZED_WIRE_3 <= "00";
SYNTHESIZED_WIRE_4 <= "000000000000";
SYNTHESIZED_WIRE_12 <= '1';
SYNTHESIZED_WIRE_13 <= '1';

fft_source_real_delay_ALTERA_SYNTHESIZED111 <= GDFX_TEMP_SIGNAL_2(11);
fft_source_real_delay_ALTERA_SYNTHESIZED110 <= GDFX_TEMP_SIGNAL_2(10);
fft_source_real_delay_ALTERA_SYNTHESIZED19 <= GDFX_TEMP_SIGNAL_2(9);
fft_source_real_delay_ALTERA_SYNTHESIZED18 <= GDFX_TEMP_SIGNAL_2(8);
fft_source_real_delay_ALTERA_SYNTHESIZED17 <= GDFX_TEMP_SIGNAL_2(7);
fft_source_real_delay_ALTERA_SYNTHESIZED16 <= GDFX_TEMP_SIGNAL_2(6);
fft_source_real_delay_ALTERA_SYNTHESIZED15 <= GDFX_TEMP_SIGNAL_2(5);
fft_source_real_delay_ALTERA_SYNTHESIZED14 <= GDFX_TEMP_SIGNAL_2(4);
fft_source_real_delay_ALTERA_SYNTHESIZED13 <= GDFX_TEMP_SIGNAL_2(3);
fft_source_real_delay_ALTERA_SYNTHESIZED12 <= GDFX_TEMP_SIGNAL_2(2);
fft_source_real_delay_ALTERA_SYNTHESIZED11 <= GDFX_TEMP_SIGNAL_2(1);
fft_source_real_delay_ALTERA_SYNTHESIZED10 <= GDFX_TEMP_SIGNAL_2(0);

GDFX_TEMP_SIGNAL_4 <= (fft_source_real_delay_ALTERA_SYNTHESIZED111 & fft_source_real_delay_ALTERA_SYNTHESIZED110 & fft_source_real_delay_ALTERA_SYNTHESIZED19 & fft_source_real_delay_ALTERA_SYNTHESIZED18 & fft_source_real_delay_ALTERA_SYNTHESIZED17 & fft_source_real_delay_ALTERA_SYNTHESIZED16 & fft_source_real_delay_ALTERA_SYNTHESIZED15 & fft_source_real_delay_ALTERA_SYNTHESIZED14 & fft_source_real_delay_ALTERA_SYNTHESIZED13 & fft_source_real_delay_ALTERA_SYNTHESIZED12 & fft_source_real_delay_ALTERA_SYNTHESIZED11 & fft_source_real_delay_ALTERA_SYNTHESIZED10);
GDFX_TEMP_SIGNAL_7 <= (fft_source_real_delay_ALTERA_SYNTHESIZED111 & fft_source_real_delay_ALTERA_SYNTHESIZED110 & fft_source_real_delay_ALTERA_SYNTHESIZED19 & fft_source_real_delay_ALTERA_SYNTHESIZED18 & fft_source_real_delay_ALTERA_SYNTHESIZED17 & fft_source_real_delay_ALTERA_SYNTHESIZED16 & fft_source_real_delay_ALTERA_SYNTHESIZED15 & fft_source_real_delay_ALTERA_SYNTHESIZED14 & fft_source_real_delay_ALTERA_SYNTHESIZED13 & fft_source_real_delay_ALTERA_SYNTHESIZED12 & fft_source_real_delay_ALTERA_SYNTHESIZED11 & fft_source_real_delay_ALTERA_SYNTHESIZED10);
GDFX_TEMP_SIGNAL_0 <= (fft_source_real_delay_ALTERA_SYNTHESIZED11 & fft_source_real_delay_ALTERA_SYNTHESIZED10 & fft_source_real_delay_ALTERA_SYNTHESIZED9 & fft_source_real_delay_ALTERA_SYNTHESIZED8 & fft_source_real_delay_ALTERA_SYNTHESIZED7 & fft_source_real_delay_ALTERA_SYNTHESIZED6 & fft_source_real_delay_ALTERA_SYNTHESIZED5 & fft_source_real_delay_ALTERA_SYNTHESIZED4 & fft_source_real_delay_ALTERA_SYNTHESIZED3 & fft_source_real_delay_ALTERA_SYNTHESIZED2 & fft_source_real_delay_ALTERA_SYNTHESIZED1 & fft_source_real_delay_ALTERA_SYNTHESIZED0);
fft_source_imag_delay_ALTERA_SYNTHESIZED111 <= GDFX_TEMP_SIGNAL_3(11);
fft_source_imag_delay_ALTERA_SYNTHESIZED110 <= GDFX_TEMP_SIGNAL_3(10);
fft_source_imag_delay_ALTERA_SYNTHESIZED19 <= GDFX_TEMP_SIGNAL_3(9);
fft_source_imag_delay_ALTERA_SYNTHESIZED18 <= GDFX_TEMP_SIGNAL_3(8);
fft_source_imag_delay_ALTERA_SYNTHESIZED17 <= GDFX_TEMP_SIGNAL_3(7);
fft_source_imag_delay_ALTERA_SYNTHESIZED16 <= GDFX_TEMP_SIGNAL_3(6);
fft_source_imag_delay_ALTERA_SYNTHESIZED15 <= GDFX_TEMP_SIGNAL_3(5);
fft_source_imag_delay_ALTERA_SYNTHESIZED14 <= GDFX_TEMP_SIGNAL_3(4);
fft_source_imag_delay_ALTERA_SYNTHESIZED13 <= GDFX_TEMP_SIGNAL_3(3);
fft_source_imag_delay_ALTERA_SYNTHESIZED12 <= GDFX_TEMP_SIGNAL_3(2);
fft_source_imag_delay_ALTERA_SYNTHESIZED11 <= GDFX_TEMP_SIGNAL_3(1);
fft_source_imag_delay_ALTERA_SYNTHESIZED10 <= GDFX_TEMP_SIGNAL_3(0);

GDFX_TEMP_SIGNAL_5 <= (fft_source_imag_delay_ALTERA_SYNTHESIZED111 & fft_source_imag_delay_ALTERA_SYNTHESIZED110 & fft_source_imag_delay_ALTERA_SYNTHESIZED19 & fft_source_imag_delay_ALTERA_SYNTHESIZED18 & fft_source_imag_delay_ALTERA_SYNTHESIZED17 & fft_source_imag_delay_ALTERA_SYNTHESIZED16 & fft_source_imag_delay_ALTERA_SYNTHESIZED15 & fft_source_imag_delay_ALTERA_SYNTHESIZED14 & fft_source_imag_delay_ALTERA_SYNTHESIZED13 & fft_source_imag_delay_ALTERA_SYNTHESIZED12 & fft_source_imag_delay_ALTERA_SYNTHESIZED11 & fft_source_imag_delay_ALTERA_SYNTHESIZED10);
GDFX_TEMP_SIGNAL_6 <= (fft_source_imag_delay_ALTERA_SYNTHESIZED111 & fft_source_imag_delay_ALTERA_SYNTHESIZED110 & fft_source_imag_delay_ALTERA_SYNTHESIZED19 & fft_source_imag_delay_ALTERA_SYNTHESIZED18 & fft_source_imag_delay_ALTERA_SYNTHESIZED17 & fft_source_imag_delay_ALTERA_SYNTHESIZED16 & fft_source_imag_delay_ALTERA_SYNTHESIZED15 & fft_source_imag_delay_ALTERA_SYNTHESIZED14 & fft_source_imag_delay_ALTERA_SYNTHESIZED13 & fft_source_imag_delay_ALTERA_SYNTHESIZED12 & fft_source_imag_delay_ALTERA_SYNTHESIZED11 & fft_source_imag_delay_ALTERA_SYNTHESIZED10);
GDFX_TEMP_SIGNAL_1 <= (fft_source_imag_delay_ALTERA_SYNTHESIZED11 & fft_source_imag_delay_ALTERA_SYNTHESIZED10 & fft_source_imag_delay_ALTERA_SYNTHESIZED9 & fft_source_imag_delay_ALTERA_SYNTHESIZED8 & fft_source_imag_delay_ALTERA_SYNTHESIZED7 & fft_source_imag_delay_ALTERA_SYNTHESIZED6 & fft_source_imag_delay_ALTERA_SYNTHESIZED5 & fft_source_imag_delay_ALTERA_SYNTHESIZED4 & fft_source_imag_delay_ALTERA_SYNTHESIZED3 & fft_source_imag_delay_ALTERA_SYNTHESIZED2 & fft_source_imag_delay_ALTERA_SYNTHESIZED1 & fft_source_imag_delay_ALTERA_SYNTHESIZED0);


b2v_inst : x_cor
PORT MAP(rst_n => rst_n,
		 clk => clk,
		 din => rcv_data_ALTERA_SYNTHESIZED,
		 dout1 => x_cor1,
		 dout2 => x_cor_ALTERA_SYNTHESIZED2);


b2v_inst1 : div
PORT MAP(rst_n => rst_n,
		 clk => clk,
		 din2 => x_cor_ALTERA_SYNTHESIZED2,
		 pre_cnt_o => pre_cnt_ALTERA_SYNTHESIZED,
		 cnt_o => cnt_o,
		 max_p => max_p,
		 max_value => max_value,
		 p_cnt_o => p_cnt_o,
		 syn_point => syn_point);




b2v_inst2 : sop_eop_gen
PORT MAP(rst_n => rst_n,
		 clk => clk,
		 pre_cnt => pre_cnt_ALTERA_SYNTHESIZED,
		 sop => fft_sop_ALTERA_SYNTHESIZED,
		 eop => fft_eop_ALTERA_SYNTHESIZED,
		 data_valid => fft_data_valid_ALTERA_SYNTHESIZED);


b2v_inst28 : mult_complex_ip
PORT MAP(dataa_imag => a_i,
		 dataa_real => a_r_ALTERA_SYNTHESIZED,
		 datab_imag => SYNTHESIZED_WIRE_0,
		 datab_real => GDFX_TEMP_SIGNAL_0,
		 result_imag => rt_i_ALTERA_SYNTHESIZED,
		 result_real => rt_r_ALTERA_SYNTHESIZED);


b2v_inst29 : add_ip
PORT MAP(datab => GDFX_TEMP_SIGNAL_1,
		 result => SYNTHESIZED_WIRE_0);


b2v_inst3 : fft_ip
PORT MAP(clk => clk,
		 reset_n => rst_n,
		 clk_ena => SYNTHESIZED_WIRE_1,
		 inverse => SYNTHESIZED_WIRE_2,
		 sink_valid => fft_data_valid_ALTERA_SYNTHESIZED,
		 sink_sop => fft_sop_ALTERA_SYNTHESIZED,
		 sink_eop => fft_eop_ALTERA_SYNTHESIZED,
		 source_ready => fft_source_valid_ALTERA_SYNTHESIZED,
		 sink_error => SYNTHESIZED_WIRE_3,
		 sink_imag => SYNTHESIZED_WIRE_4,
		 sink_real => rcv_data_delay_ALTERA_SYNTHESIZED,
		 sink_ready => fft_sink_ready,
		 source_sop => fft_source_sop_ALTERA_SYNTHESIZED,
		 source_eop => fft_source_eop,
		 source_valid => fft_source_valid_ALTERA_SYNTHESIZED,
		 source_error => fft_source_eeror,
		 source_exp => fft_source_exp,
		 source_imag => fft_source_imag_ALTERA_SYNTHESIZED,
		 source_real => fft_source_real_ALTERA_SYNTHESIZED);



b2v_inst32 : fifo_ip
PORT MAP(wrreq => SYNTHESIZED_WIRE_12,
		 rdreq => SYNTHESIZED_WIRE_12,
		 clock => clk,
		 aclr => rst,
		 data => rcv_data_ALTERA_SYNTHESIZED,
		 q => rcv_data_delay_ALTERA_SYNTHESIZED);


b2v_inst33 : fifo_ip
PORT MAP(wrreq => fft_source_valid_ALTERA_SYNTHESIZED,
		 rdreq => fft_source_valid_ALTERA_SYNTHESIZED,
		 clock => clk,
		 aclr => rst,
		 data => fft_source_real_ALTERA_SYNTHESIZED,
		 q => GDFX_TEMP_SIGNAL_2);


b2v_inst34 : fifo_ip
PORT MAP(wrreq => fft_source_valid_ALTERA_SYNTHESIZED,
		 rdreq => fft_source_valid_ALTERA_SYNTHESIZED,
		 clock => clk,
		 aclr => rst,
		 data => fft_source_imag_ALTERA_SYNTHESIZED,
		 q => GDFX_TEMP_SIGNAL_3);


b2v_inst35 : fifo_ip
PORT MAP(wrreq => fft_source_valid_ALTERA_SYNTHESIZED,
		 rdreq => fft_source_valid_ALTERA_SYNTHESIZED,
		 clock => clk,
		 aclr => rst,
		 data => GDFX_TEMP_SIGNAL_4,
		 q => fft_source_real_delay);


b2v_inst36 : fifo_ip
PORT MAP(wrreq => fft_source_valid_ALTERA_SYNTHESIZED,
		 rdreq => fft_source_valid_ALTERA_SYNTHESIZED,
		 clock => clk,
		 aclr => rst,
		 data => GDFX_TEMP_SIGNAL_5,
		 q => fft_source_imag_delay);


rst_n <= NOT(rst);



b2v_inst5 : data_out
PORT MAP(rst_n => rst_n,
		 clk => clk,
		 sink_eop => SYNTHESIZED_WIRE_7,
		 sink_valid => SYNTHESIZED_WIRE_8,
		 din => SYNTHESIZED_WIRE_9,
		 data_valid => demap_sink_valid,
		 dout => demap_dout);




b2v_inst8 : fifo_ip_8
PORT MAP(wrreq => SYNTHESIZED_WIRE_13,
		 rdreq => SYNTHESIZED_WIRE_13,
		 clock => clk,
		 aclr => rst,
		 data => data_in,
		 q => rcv_data_ALTERA_SYNTHESIZED);



b2v_inst_17 : de_map
GENERIC MAP(N => 33
			)
PORT MAP(rst_n => rst_n,
		 clk => clk,
		 source_valid => fft_source_valid_ALTERA_SYNTHESIZED,
		 source_sop => fft_source_sop_ALTERA_SYNTHESIZED,
		 din_imag => GDFX_TEMP_SIGNAL_6,
		 din_imag_clc => rt_i_ALTERA_SYNTHESIZED,
		 din_real => GDFX_TEMP_SIGNAL_7,
		 din_real_clc => rt_r_ALTERA_SYNTHESIZED,
		 sink_sop => demap_sink_sop,
		 sink_eop => SYNTHESIZED_WIRE_7,
		 sink_valid => SYNTHESIZED_WIRE_8,
		 dout => SYNTHESIZED_WIRE_9,
		 dout_imag => a_i,
		 dout_real => a_r_ALTERA_SYNTHESIZED);

fft_source_sop <= fft_source_sop_ALTERA_SYNTHESIZED;
fft_source_valid <= fft_source_valid_ALTERA_SYNTHESIZED;
pre_cnt <= pre_cnt_ALTERA_SYNTHESIZED;
fft_sop <= fft_sop_ALTERA_SYNTHESIZED;
fft_eop <= fft_eop_ALTERA_SYNTHESIZED;
fft_data_valid <= fft_data_valid_ALTERA_SYNTHESIZED;
a_r <= a_r_ALTERA_SYNTHESIZED;
fft_source_imag <= fft_source_imag_ALTERA_SYNTHESIZED;
fft_source_real <= fft_source_real_ALTERA_SYNTHESIZED;
rcv_data <= rcv_data_ALTERA_SYNTHESIZED;
rcv_data_delay <= rcv_data_delay_ALTERA_SYNTHESIZED;
rt_i <= rt_i_ALTERA_SYNTHESIZED;
rt_r <= rt_r_ALTERA_SYNTHESIZED;
x_cor2 <= x_cor_ALTERA_SYNTHESIZED2;

fft_source_imag_delay_ALTERA_SYNTHESIZED10 <= GDFX_TEMP_SIGNAL_3(0);
fft_source_imag_delay_ALTERA_SYNTHESIZED11 <= GDFX_TEMP_SIGNAL_3(1);
fft_source_imag_delay_ALTERA_SYNTHESIZED110 <= GDFX_TEMP_SIGNAL_3(10);
fft_source_imag_delay_ALTERA_SYNTHESIZED111 <= GDFX_TEMP_SIGNAL_3(11);
fft_source_imag_delay_ALTERA_SYNTHESIZED12 <= GDFX_TEMP_SIGNAL_3(2);
fft_source_imag_delay_ALTERA_SYNTHESIZED13 <= GDFX_TEMP_SIGNAL_3(3);
fft_source_imag_delay_ALTERA_SYNTHESIZED14 <= GDFX_TEMP_SIGNAL_3(4);
fft_source_imag_delay_ALTERA_SYNTHESIZED15 <= GDFX_TEMP_SIGNAL_3(5);
fft_source_imag_delay_ALTERA_SYNTHESIZED16 <= GDFX_TEMP_SIGNAL_3(6);
fft_source_imag_delay_ALTERA_SYNTHESIZED17 <= GDFX_TEMP_SIGNAL_3(7);
fft_source_imag_delay_ALTERA_SYNTHESIZED18 <= GDFX_TEMP_SIGNAL_3(8);
fft_source_imag_delay_ALTERA_SYNTHESIZED19 <= GDFX_TEMP_SIGNAL_3(9);
fft_source_real_delay_ALTERA_SYNTHESIZED10 <= GDFX_TEMP_SIGNAL_2(0);
fft_source_real_delay_ALTERA_SYNTHESIZED11 <= GDFX_TEMP_SIGNAL_2(1);
fft_source_real_delay_ALTERA_SYNTHESIZED110 <= GDFX_TEMP_SIGNAL_2(10);
fft_source_real_delay_ALTERA_SYNTHESIZED111 <= GDFX_TEMP_SIGNAL_2(11);
fft_source_real_delay_ALTERA_SYNTHESIZED12 <= GDFX_TEMP_SIGNAL_2(2);
fft_source_real_delay_ALTERA_SYNTHESIZED13 <= GDFX_TEMP_SIGNAL_2(3);
fft_source_real_delay_ALTERA_SYNTHESIZED14 <= GDFX_TEMP_SIGNAL_2(4);
fft_source_real_delay_ALTERA_SYNTHESIZED15 <= GDFX_TEMP_SIGNAL_2(5);
fft_source_real_delay_ALTERA_SYNTHESIZED16 <= GDFX_TEMP_SIGNAL_2(6);
fft_source_real_delay_ALTERA_SYNTHESIZED17 <= GDFX_TEMP_SIGNAL_2(7);
fft_source_real_delay_ALTERA_SYNTHESIZED18 <= GDFX_TEMP_SIGNAL_2(8);
fft_source_real_delay_ALTERA_SYNTHESIZED19 <= GDFX_TEMP_SIGNAL_2(9);
END bdf_type;