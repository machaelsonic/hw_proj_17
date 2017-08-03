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

-- ***************************************************************************
-- This file contains a Vhdl test bench template that is freely editable to   
-- suit user's needs .Comments are provided in each section to help the user  
-- fill out necessary details.                                                
-- ***************************************************************************
-- Generated on "07/31/2017 16:47:44"
                                                            
-- Vhdl Test Bench template for design  :  plc_design
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all; 
USE ieee.std_logic_unsigned.all; 
--USE ieee.std_logic_arith.all;                              
use ieee.numeric_std.all;
use std.textio.all;



ENTITY plc_design_vhd_tst IS
END plc_design_vhd_tst;
ARCHITECTURE plc_design_arch OF plc_design_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL a_r : STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL clk_tx : STD_LOGIC;
SIGNAL cnt : STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL cnt_o : STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL datain : STD_LOGIC_VECTOR(35 DOWNTO 0);
SIGNAL demap_dout : STD_LOGIC_VECTOR(35 DOWNTO 0);
SIGNAL demap_sink_eop : STD_LOGIC;
SIGNAL demap_sink_sop : STD_LOGIC;
SIGNAL demap_sink_valid : STD_LOGIC;
SIGNAL en : STD_LOGIC;
SIGNAL fft_data_valid : STD_LOGIC;
SIGNAL fft_eop : STD_LOGIC;
SIGNAL fft_sink_ready : STD_LOGIC;
SIGNAL fft_sop : STD_LOGIC;
SIGNAL fft_source_eop : STD_LOGIC;
SIGNAL fft_source_error : STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL fft_source_exp : STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL fft_source_imag : STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL fft_source_imag_delay : STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL fft_source_imag_delay_1 : STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL fft_source_real : STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL fft_source_real_delay : STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL fft_source_real_delay_1 : STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL fft_source_sop : STD_LOGIC;
SIGNAL fft_source_valid : STD_LOGIC;
SIGNAL flag_eop : STD_LOGIC;
SIGNAL flag_o : STD_LOGIC;
SIGNAL flag_o1 : STD_LOGIC;
SIGNAL ifft_data : STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL ifft_data_valid : STD_LOGIC;
SIGNAL ifft_dout_imag : STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL ifft_dout_real : STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL ifft_eop : STD_LOGIC;
SIGNAL ifft_sink_ready : STD_LOGIC;
SIGNAL ifft_sop : STD_LOGIC;
SIGNAL ifft_source_eop : STD_LOGIC;
SIGNAL ifft_source_error : STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL ifft_source_exp : STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL ifft_source_imag : STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL ifft_source_real : STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL ifft_source_sop : STD_LOGIC;
SIGNAL max_p : STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL p_cnt_o : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL pre_cnt : STD_LOGIC;
SIGNAL pre_win_data : STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL pre_win_data_valid : STD_LOGIC;
SIGNAL ram1_d : STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL ram2_d : STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL ram_data_valid : STD_LOGIC;
SIGNAL ram_rd_adr : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL ram_rd_data : STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL ram_rd_en : STD_LOGIC;
SIGNAL ram_wr_adr : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL ram_wr_en : STD_LOGIC;
SIGNAL rcv_data : STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL rcv_data_delay : STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL rd_cnt_o : STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL rd_continue_o : STD_LOGIC;
SIGNAL rd_data_sel : STD_LOGIC;
SIGNAL rd_sel : STD_LOGIC;
SIGNAL rom_rd_adr : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL rom_rd_en : STD_LOGIC;
SIGNAL rst_n_tx : STD_LOGIC;
SIGNAL rt_r : STD_LOGIC_VECTOR(24 DOWNTO 0);
SIGNAL send_data_valid : STD_LOGIC;
SIGNAL syn_point : STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL tx_data_o : STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL tx_data_valid : STD_LOGIC;
SIGNAL wr_sel : STD_LOGIC;
SIGNAL x_cor1 : STD_LOGIC_VECTOR(20 DOWNTO 0);
SIGNAL x_cor2 : STD_LOGIC_VECTOR(20 DOWNTO 0);
COMPONENT plc_design
	PORT (
	a_r : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
	clk_tx : IN STD_LOGIC;
	cnt : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
	cnt_o : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
	datain : IN STD_LOGIC_VECTOR(35 DOWNTO 0);
	demap_dout : OUT STD_LOGIC_VECTOR(35 DOWNTO 0);
	demap_sink_eop : OUT STD_LOGIC;
	demap_sink_sop : OUT STD_LOGIC;
	demap_sink_valid : OUT STD_LOGIC;
	en : IN STD_LOGIC;
	fft_data_valid : OUT STD_LOGIC;
	fft_eop : OUT STD_LOGIC;
	fft_sink_ready : OUT STD_LOGIC;
	fft_sop : OUT STD_LOGIC;
	fft_source_eop : OUT STD_LOGIC;
	fft_source_error : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
	fft_source_exp : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
	fft_source_imag : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
	fft_source_imag_delay : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
	fft_source_imag_delay_1 : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
	fft_source_real : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
	fft_source_real_delay : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
	fft_source_real_delay_1 : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
	fft_source_sop : OUT STD_LOGIC;
	fft_source_valid : OUT STD_LOGIC;
	flag_eop : OUT STD_LOGIC;
	flag_o : OUT STD_LOGIC;
	flag_o1 : OUT STD_LOGIC;
	ifft_data : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	ifft_data_valid : OUT STD_LOGIC;
	ifft_dout_imag : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
	ifft_dout_real : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
	ifft_eop : OUT STD_LOGIC;
	ifft_sink_ready : OUT STD_LOGIC;
	ifft_sop : OUT STD_LOGIC;
	ifft_source_eop : OUT STD_LOGIC;
	ifft_source_error : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
	ifft_source_exp : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
	ifft_source_imag : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
	ifft_source_real : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
	ifft_source_sop : OUT STD_LOGIC;
	max_p : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
	p_cnt_o : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	pre_cnt : OUT STD_LOGIC;
	pre_win_data : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
	pre_win_data_valid : OUT STD_LOGIC;
	ram1_d : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	ram2_d : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	ram_data_valid : OUT STD_LOGIC;
	ram_rd_adr : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	ram_rd_data : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	ram_rd_en : OUT STD_LOGIC;
	ram_wr_adr : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	ram_wr_en : OUT STD_LOGIC;
	rcv_data : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
	rcv_data_delay : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
	rd_cnt_o : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
	rd_continue_o : OUT STD_LOGIC;
	rd_data_sel : OUT STD_LOGIC;
	rd_sel : OUT STD_LOGIC;
	rom_rd_adr : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	rom_rd_en : OUT STD_LOGIC;
	rst_n_tx : IN STD_LOGIC;
	rt_r : OUT STD_LOGIC_VECTOR(24 DOWNTO 0);
	send_data_valid : OUT STD_LOGIC;
	syn_point : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
	tx_data_o : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
	tx_data_valid : OUT STD_LOGIC;
	wr_sel : OUT STD_LOGIC;
	x_cor1 : OUT STD_LOGIC_VECTOR(20 DOWNTO 0);
	x_cor2 : OUT STD_LOGIC_VECTOR(20 DOWNTO 0)
	);
END COMPONENT;
signal cnt_1:integer range 0 to 2299;
signal tmp:std_logic_vector(35 downto 0);
signal d_t:std_logic;
signal ifft_sop_t: integer;

FILE tb_ifft_data_in:TEXT OPEN WRITE_MODE IS "tb_ifft_data_in.txt";
FILE tb_ifft_data_out:TEXT OPEN WRITE_MODE IS "tb_ifft_data_out.txt";
FILE tb_fft_data_out:TEXT OPEN WRITE_MODE IS "tb_fft_data_out.txt";
FILE tb_fft_data_in:TEXT OPEN WRITE_MODE IS "tb_fft_data_in.txt";
  
BEGIN
	i1 : plc_design
	PORT MAP (
-- list connections between master ports and signals
	a_r => a_r,
	clk_tx => clk_tx,
	cnt => cnt,
	cnt_o => cnt_o,
	datain => datain,
	demap_dout => demap_dout,
	demap_sink_eop => demap_sink_eop,
	demap_sink_sop => demap_sink_sop,
	demap_sink_valid => demap_sink_valid,
	en => en,
	fft_data_valid => fft_data_valid,
	fft_eop => fft_eop,
	fft_sink_ready => fft_sink_ready,
	fft_sop => fft_sop,
	fft_source_eop => fft_source_eop,
	fft_source_error => fft_source_error,
	fft_source_exp => fft_source_exp,
	fft_source_imag => fft_source_imag,
	fft_source_imag_delay => fft_source_imag_delay,
	fft_source_imag_delay_1 => fft_source_imag_delay_1,
	fft_source_real => fft_source_real,
	fft_source_real_delay => fft_source_real_delay,
	fft_source_real_delay_1 => fft_source_real_delay_1,
	fft_source_sop => fft_source_sop,
	fft_source_valid => fft_source_valid,
	flag_eop => flag_eop,
	flag_o => flag_o,
	flag_o1 => flag_o1,
	ifft_data => ifft_data,
	ifft_data_valid => ifft_data_valid,
	ifft_dout_imag => ifft_dout_imag,
	ifft_dout_real => ifft_dout_real,
	ifft_eop => ifft_eop,
	ifft_sink_ready => ifft_sink_ready,
	ifft_sop => ifft_sop,
	ifft_source_eop => ifft_source_eop,
	ifft_source_error => ifft_source_error,
	ifft_source_exp => ifft_source_exp,
	ifft_source_imag => ifft_source_imag,
	ifft_source_real => ifft_source_real,
	ifft_source_sop => ifft_source_sop,
	max_p => max_p,
	p_cnt_o => p_cnt_o,
	pre_cnt => pre_cnt,
	pre_win_data => pre_win_data,
	pre_win_data_valid => pre_win_data_valid,
	ram1_d => ram1_d,
	ram2_d => ram2_d,
	ram_data_valid => ram_data_valid,
	ram_rd_adr => ram_rd_adr,
	ram_rd_data => ram_rd_data,
	ram_rd_en => ram_rd_en,
	ram_wr_adr => ram_wr_adr,
	ram_wr_en => ram_wr_en,
	rcv_data => rcv_data,
	rcv_data_delay => rcv_data_delay,
	rd_cnt_o => rd_cnt_o,
	rd_continue_o => rd_continue_o,
	rd_data_sel => rd_data_sel,
	rd_sel => rd_sel,
	rom_rd_adr => rom_rd_adr,
	rom_rd_en => rom_rd_en,
	rst_n_tx => rst_n_tx,
	rt_r => rt_r,
	send_data_valid => send_data_valid,
	syn_point => syn_point,
	tx_data_o => tx_data_o,
	tx_data_valid => tx_data_valid,
	wr_sel => wr_sel,
	x_cor1 => x_cor1,
	x_cor2 => x_cor2
	);

init : PROCESS                                               
-- variable declarations                                     
BEGIN 
    rst_n_tx<='0';
	 wait for 770 ns;                                                        
    rst_n_tx<='1';
    wait;    -- code that executes only once                      
END PROCESS init;   
                                                                                               
always : PROCESS                                              
-- optional sensitivity list                                  
-- (        )                                                 
-- variable declarations                                      
BEGIN                                                         
        -- code executes for every event on sensitivity list  
clk_tx<='1';
wait for 20 ns;
clk_tx<='0';
wait for 20 ns; 
                      

							 
END PROCESS always;
   process(rst_n_tx,clk_tx) is
		  begin
		    if rst_n_tx='0' then
			    cnt_1<=2100;
				 d_t<='0';
				 tmp<=(others=>'0');
			 elsif clk_tx'event and clk_tx='1' then
			    if cnt_1=2299 then
				    cnt_1<=0;
					 d_t<='1';
					 tmp<=tmp+1;
				 else
				    cnt_1<=cnt_1+1;
					 d_t<='0';
					 tmp<=tmp;
				end if;
		    end if;
			 
		end process;
		en<=d_t;
		datain<="101001011010010110100101101001011010";
       --datain<=tmp; 
    --ifft_sop_t<=to_integer(ifft_sop);

-------------------------------------------------------------------------------
-- XMT IFFT IN&OUT
-------------------------------------------------------------------------------
process(clk_tx) is
 	VARIABLE lo_1:LINE;
    BEGIN
	     if rising_edge(clk_tx) then
				if ifft_data_valid='1' then
					-- WRITE (lo_1,to_bit(ifft_sop),left ,10);
					-- WRITE (lo_1,to_bit(ifft_eop),left ,10);
					WRITE (lo_1,to_integer(signed(ifft_dout_real)),left,10);
					WRITE (lo_1,to_integer(signed(ifft_dout_imag)),left,10);
					WRITELINE (tb_ifft_data_in,lo_1);
				end if;
		end if;
	end 
process;


process(clk_tx) is
 	VARIABLE lo_1:LINE;
	alias ifft_source_valid is <<signal i1.b2v_inst1.ifft_source_ready_t  : STD_LOGIC>>;
    BEGIN
	     if rising_edge(clk_tx) then
				if ifft_source_valid='1' then
					-- WRITE (lo_1,to_bit(ifft_source_sop),left ,10);
					-- WRITE (lo_1,to_bit(ifft_source_eop),left ,10);
					WRITE (lo_1,to_integer(signed(ifft_source_real)),left,10);
					WRITE (lo_1,to_integer(signed(ifft_source_imag)),left,10);
					WRITELINE (tb_ifft_data_out,lo_1);
				end if;
		end if;
	end 
process;

-------------------------------------------------------------------------------
-- RCV FFT IN&OUT
-------------------------------------------------------------------------------
process(clk_tx) is
 	VARIABLE lo_1:LINE;
    BEGIN
	    if rising_edge(clk_tx) then
		    if fft_data_valid='1' then
				-- WRITE (lo_1,to_bit(fft_sop),left ,10);
				-- WRITE (lo_1,to_bit(fft_eop),left ,10);
		        WRITE (lo_1,to_integer(signed(rcv_data_delay)),left,10);
		        ---WRITE (lo_1,to_integer(signed(fft_source_imag)),left,10);
		        
			    WRITELINE (tb_fft_data_in,lo_1);
			end if;
		end if;
end process;  
  
process(clk_tx) is
 	VARIABLE lo_1:LINE;
    BEGIN
	     if rising_edge(clk_tx) then
			if fft_source_valid='1' then
				-- WRITE (lo_1,to_bit(fft_source_sop),left ,10);
				-- WRITE (lo_1,to_bit(fft_source_eop),left ,10);
		        WRITE (lo_1,to_integer(signed(fft_source_real)),left,10);
		        WRITE (lo_1,to_integer(signed(fft_source_imag)),left,10);
		        
			    WRITELINE (tb_fft_data_out,lo_1);
			end if;
		end if;
	end process; 


                                                                     
END plc_design_arch;
