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
-- CREATED		"Mon Jul 31 18:42:07 2017"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY cp_insert IS 
	PORT
	(
		rst_n :  IN  STD_LOGIC;
		clk :  IN  STD_LOGIC;
		eop :  IN  STD_LOGIC;
		sop :  IN  STD_LOGIC;
		din :  IN  STD_LOGIC_VECTOR(11 DOWNTO 0);
		rd_en :  OUT  STD_LOGIC;
		rd_sel :  OUT  STD_LOGIC;
		wr_en :  OUT  STD_LOGIC;
		wr_sel :  OUT  STD_LOGIC;
		rd_data_sel :  OUT  STD_LOGIC;
		ram_data_oe :  OUT  STD_LOGIC;
		rd_continue_o :  OUT  STD_LOGIC;
		flag_o1 :  OUT  STD_LOGIC;
		flag_eop :  OUT  STD_LOGIC;
		dout :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0);
		ram1_d :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0);
		ram2_d :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0);
		rd_adr :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);
		rd_cnt_o :  OUT  STD_LOGIC_VECTOR(8 DOWNTO 0);
		rt :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0);
		wr_adr :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END cp_insert;

ARCHITECTURE bdf_type OF cp_insert IS 

COMPONENT ifft_ram_rd_ctr
	PORT(rst_n : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 sop : IN STD_LOGIC;
		 eop : IN STD_LOGIC;
		 rd_en : OUT STD_LOGIC;
		 rd_sel : OUT STD_LOGIC;
		 rd_data_sel : OUT STD_LOGIC;
		 oe : OUT STD_LOGIC;
		 rd_continue_o : OUT STD_LOGIC;
		 flag_o1 : OUT STD_LOGIC;
		 flag_eop : OUT STD_LOGIC;
		 rd_adr : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 rd_cnt_o : OUT STD_LOGIC_VECTOR(8 DOWNTO 0)
	);
END COMPONENT;

COMPONENT ifft_ram_wr_ctr
	PORT(rst_n : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 sop : IN STD_LOGIC;
		 din : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		 wr_en : OUT STD_LOGIC;
		 wr_sel : OUT STD_LOGIC;
		 dout : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		 wr_adr : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT d_sel
	PORT(sel : IN STD_LOGIC;
		 oe : IN STD_LOGIC;
		 a : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 b : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 c : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END COMPONENT;

COMPONENT ifft_ram
	PORT(wren : IN STD_LOGIC;
		 rden : IN STD_LOGIC;
		 clock : IN STD_LOGIC;
		 data : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 rdaddress : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 wraddress : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 q : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	dout_ALTERA_SYNTHESIZED :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	ram_data_oe_ALTERA_SYNTHESIZED :  STD_LOGIC;
SIGNAL	rd_adr_ALTERA_SYNTHESIZED :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	rd_data_sel_ALTERA_SYNTHESIZED :  STD_LOGIC;
SIGNAL	rd_en_ALTERA_SYNTHESIZED :  STD_LOGIC;
SIGNAL	rd_en_ALTERA_SYNTHESIZED1 :  STD_LOGIC;
SIGNAL	rd_en_ALTERA_SYNTHESIZED2 :  STD_LOGIC;
SIGNAL	rd_sel_ALTERA_SYNTHESIZED :  STD_LOGIC;
SIGNAL	rd_sel_n :  STD_LOGIC;
SIGNAL	wr_adr_ALTERA_SYNTHESIZED :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	wr_en_ALTERA_SYNTHESIZED :  STD_LOGIC;
SIGNAL	wr_en_ALTERA_SYNTHESIZED1 :  STD_LOGIC;
SIGNAL	wr_en_ALTERA_SYNTHESIZED2 :  STD_LOGIC;
SIGNAL	wr_sel_ALTERA_SYNTHESIZED :  STD_LOGIC;
SIGNAL	wr_sel_n :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC_VECTOR(15 DOWNTO 0);


BEGIN 
ram1_d <= SYNTHESIZED_WIRE_0;
ram2_d <= SYNTHESIZED_WIRE_1;



b2v_inst : ifft_ram_rd_ctr
PORT MAP(rst_n => rst_n,
		 clk => clk,
		 sop => sop,
		 eop => eop,
		 rd_en => rd_en_ALTERA_SYNTHESIZED,
		 rd_sel => rd_sel_ALTERA_SYNTHESIZED,
		 rd_data_sel => rd_data_sel_ALTERA_SYNTHESIZED,
		 oe => ram_data_oe_ALTERA_SYNTHESIZED,
		 rd_continue_o => rd_continue_o,
		 flag_o1 => flag_o1,
		 flag_eop => flag_eop,
		 rd_adr => rd_adr_ALTERA_SYNTHESIZED,
		 rd_cnt_o => rd_cnt_o);


b2v_inst1 : ifft_ram_wr_ctr
PORT MAP(rst_n => rst_n,
		 clk => clk,
		 sop => sop,
		 din => din,
		 wr_en => wr_en_ALTERA_SYNTHESIZED,
		 wr_sel => wr_sel_ALTERA_SYNTHESIZED,
		 dout => dout_ALTERA_SYNTHESIZED,
		 wr_adr => wr_adr_ALTERA_SYNTHESIZED);


wr_en_ALTERA_SYNTHESIZED1 <= wr_en_ALTERA_SYNTHESIZED AND wr_sel_ALTERA_SYNTHESIZED;


wr_en_ALTERA_SYNTHESIZED2 <= wr_en_ALTERA_SYNTHESIZED AND wr_sel_n;


rd_en_ALTERA_SYNTHESIZED1 <= rd_en_ALTERA_SYNTHESIZED AND rd_sel_ALTERA_SYNTHESIZED;


rd_en_ALTERA_SYNTHESIZED2 <= rd_en_ALTERA_SYNTHESIZED AND rd_sel_n;


b2v_inst15 : d_sel
PORT MAP(sel => rd_data_sel_ALTERA_SYNTHESIZED,
		 oe => ram_data_oe_ALTERA_SYNTHESIZED,
		 a => SYNTHESIZED_WIRE_0,
		 b => SYNTHESIZED_WIRE_1,
		 c => rt);


b2v_inst6 : ifft_ram
PORT MAP(wren => wr_en_ALTERA_SYNTHESIZED1,
		 rden => rd_en_ALTERA_SYNTHESIZED1,
		 clock => clk,
		 data => dout_ALTERA_SYNTHESIZED,
		 rdaddress => rd_adr_ALTERA_SYNTHESIZED,
		 wraddress => wr_adr_ALTERA_SYNTHESIZED,
		 q => SYNTHESIZED_WIRE_0);


b2v_inst7 : ifft_ram
PORT MAP(wren => wr_en_ALTERA_SYNTHESIZED2,
		 rden => rd_en_ALTERA_SYNTHESIZED2,
		 clock => clk,
		 data => dout_ALTERA_SYNTHESIZED,
		 rdaddress => rd_adr_ALTERA_SYNTHESIZED,
		 wraddress => wr_adr_ALTERA_SYNTHESIZED,
		 q => SYNTHESIZED_WIRE_1);


rd_sel_n <= NOT(rd_sel_ALTERA_SYNTHESIZED);



wr_sel_n <= NOT(wr_sel_ALTERA_SYNTHESIZED);


rd_en <= rd_en_ALTERA_SYNTHESIZED;
rd_sel <= rd_sel_ALTERA_SYNTHESIZED;
wr_en <= wr_en_ALTERA_SYNTHESIZED;
wr_sel <= wr_sel_ALTERA_SYNTHESIZED;
rd_data_sel <= rd_data_sel_ALTERA_SYNTHESIZED;
ram_data_oe <= ram_data_oe_ALTERA_SYNTHESIZED;
dout <= dout_ALTERA_SYNTHESIZED;
rd_adr <= rd_adr_ALTERA_SYNTHESIZED;
wr_adr <= wr_adr_ALTERA_SYNTHESIZED;

END bdf_type;