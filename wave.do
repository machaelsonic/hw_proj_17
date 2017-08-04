onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /plc_design_vhd_tst/a_r
add wave -noupdate /plc_design_vhd_tst/clk_tx
add wave -noupdate /plc_design_vhd_tst/cnt
add wave -noupdate /plc_design_vhd_tst/cnt_o
add wave -noupdate -radix hexadecimal /plc_design_vhd_tst/datain
add wave -noupdate -radix hexadecimal /plc_design_vhd_tst/demap_dout
add wave -noupdate -format Analog-Step -height 200 -max 50000.0 -min -50000.0 /plc_design_vhd_tst/rt_r
add wave -noupdate /plc_design_vhd_tst/demap_sink_eop
add wave -noupdate /plc_design_vhd_tst/demap_sink_sop
add wave -noupdate /plc_design_vhd_tst/demap_sink_valid
add wave -noupdate /plc_design_vhd_tst/en
add wave -noupdate /plc_design_vhd_tst/fft_data_valid
add wave -noupdate /plc_design_vhd_tst/fft_eop
add wave -noupdate /plc_design_vhd_tst/fft_sink_ready
add wave -noupdate /plc_design_vhd_tst/fft_sop
add wave -noupdate /plc_design_vhd_tst/fft_source_eop
add wave -noupdate /plc_design_vhd_tst/fft_source_error
add wave -noupdate /plc_design_vhd_tst/fft_source_exp
add wave -noupdate /plc_design_vhd_tst/fft_source_imag
add wave -noupdate /plc_design_vhd_tst/fft_source_imag_delay
add wave -noupdate /plc_design_vhd_tst/fft_source_imag_delay_1
add wave -noupdate /plc_design_vhd_tst/fft_source_real
add wave -noupdate /plc_design_vhd_tst/fft_source_real_delay
add wave -noupdate /plc_design_vhd_tst/fft_source_real_delay_1
add wave -noupdate /plc_design_vhd_tst/fft_source_sop
add wave -noupdate /plc_design_vhd_tst/fft_source_valid
add wave -noupdate /plc_design_vhd_tst/flag_eop
add wave -noupdate /plc_design_vhd_tst/flag_o
add wave -noupdate /plc_design_vhd_tst/flag_o1
add wave -noupdate /plc_design_vhd_tst/ifft_data
add wave -noupdate /plc_design_vhd_tst/ifft_data_valid
add wave -noupdate /plc_design_vhd_tst/ifft_dout_imag
add wave -noupdate /plc_design_vhd_tst/ifft_dout_real
add wave -noupdate /plc_design_vhd_tst/ifft_eop
add wave -noupdate /plc_design_vhd_tst/ifft_sink_ready
add wave -noupdate /plc_design_vhd_tst/ifft_sop
add wave -noupdate /plc_design_vhd_tst/ifft_source_eop
add wave -noupdate /plc_design_vhd_tst/ifft_source_error
add wave -noupdate /plc_design_vhd_tst/ifft_source_exp
add wave -noupdate /plc_design_vhd_tst/ifft_source_imag
add wave -noupdate /plc_design_vhd_tst/ifft_source_real
add wave -noupdate /plc_design_vhd_tst/ifft_source_sop
add wave -noupdate /plc_design_vhd_tst/max_p
add wave -noupdate /plc_design_vhd_tst/p_cnt_o
add wave -noupdate /plc_design_vhd_tst/pre_cnt
add wave -noupdate /plc_design_vhd_tst/pre_win_data
add wave -noupdate /plc_design_vhd_tst/pre_win_data_valid
add wave -noupdate /plc_design_vhd_tst/ram1_d
add wave -noupdate /plc_design_vhd_tst/ram2_d
add wave -noupdate /plc_design_vhd_tst/ram_data_valid
add wave -noupdate /plc_design_vhd_tst/ram_rd_adr
add wave -noupdate /plc_design_vhd_tst/ram_rd_data
add wave -noupdate /plc_design_vhd_tst/ram_rd_en
add wave -noupdate /plc_design_vhd_tst/ram_wr_adr
add wave -noupdate /plc_design_vhd_tst/ram_wr_en
add wave -noupdate /plc_design_vhd_tst/rcv_data
add wave -noupdate /plc_design_vhd_tst/rcv_data_delay
add wave -noupdate /plc_design_vhd_tst/rd_cnt_o
add wave -noupdate /plc_design_vhd_tst/rd_continue_o
add wave -noupdate /plc_design_vhd_tst/rd_data_sel
add wave -noupdate /plc_design_vhd_tst/rd_sel
add wave -noupdate /plc_design_vhd_tst/rom_rd_adr
add wave -noupdate /plc_design_vhd_tst/rom_rd_en
add wave -noupdate /plc_design_vhd_tst/rst_n_tx
add wave -noupdate /plc_design_vhd_tst/send_data_valid
add wave -noupdate /plc_design_vhd_tst/syn_point
add wave -noupdate -format Analog-Step -height 200 -max 500.0 -min -500.0 /plc_design_vhd_tst/tx_data_o
add wave -noupdate /plc_design_vhd_tst/tx_data_valid
add wave -noupdate /plc_design_vhd_tst/wr_sel
add wave -noupdate /plc_design_vhd_tst/x_cor1
add wave -noupdate /plc_design_vhd_tst/x_cor2
add wave -noupdate /plc_design_vhd_tst/cnt_1
add wave -noupdate /plc_design_vhd_tst/tmp
add wave -noupdate /plc_design_vhd_tst/d_t
add wave -noupdate /plc_design_vhd_tst/ifft_sop_t
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {838454 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 326
configure wave -valuecolwidth 38
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {51935750 ps} {520550750 ps}
