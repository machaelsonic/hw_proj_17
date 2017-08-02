onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {New Divider}
add wave -noupdate /plc_design_vhd_tst/i1/b2v_inst1/b2v_inst1/clk
add wave -noupdate /plc_design_vhd_tst/i1/b2v_inst1/b2v_inst1/inverse
add wave -noupdate /plc_design_vhd_tst/i1/b2v_inst1/b2v_inst1/reset_n
add wave -noupdate -divider {New Divider}
add wave -noupdate /plc_design_vhd_tst/i1/b2v_inst1/b2v_inst1/sink_ready
add wave -noupdate /plc_design_vhd_tst/i1/b2v_inst1/b2v_inst1/sink_error
add wave -noupdate /plc_design_vhd_tst/i1/b2v_inst1/b2v_inst1/sink_valid
add wave -noupdate /plc_design_vhd_tst/i1/b2v_inst1/b2v_inst1/sink_sop
add wave -noupdate /plc_design_vhd_tst/i1/b2v_inst1/b2v_inst1/sink_eop
add wave -noupdate /plc_design_vhd_tst/i1/b2v_inst1/b2v_inst1/sink_real
add wave -noupdate /plc_design_vhd_tst/i1/b2v_inst1/b2v_inst1/sink_imag
add wave -noupdate -divider {New Divider}
add wave -noupdate /plc_design_vhd_tst/i1/b2v_inst1/b2v_inst1/source_ready
add wave -noupdate /plc_design_vhd_tst/i1/b2v_inst1/b2v_inst1/source_valid
add wave -noupdate /plc_design_vhd_tst/i1/b2v_inst1/b2v_inst1/source_error
add wave -noupdate /plc_design_vhd_tst/i1/b2v_inst1/b2v_inst1/source_sop
add wave -noupdate /plc_design_vhd_tst/i1/b2v_inst1/b2v_inst1/source_eop
add wave -noupdate /plc_design_vhd_tst/i1/b2v_inst1/b2v_inst1/source_real
add wave -noupdate /plc_design_vhd_tst/i1/b2v_inst1/b2v_inst1/source_imag
add wave -noupdate /plc_design_vhd_tst/i1/b2v_inst1/b2v_inst1/source_exp
add wave -noupdate -divider {New Divider}
add wave -noupdate -color Cyan /plc_design_vhd_tst/i1/b2v_inst1/fft_ip_gold/clk
add wave -noupdate -color Cyan /plc_design_vhd_tst/i1/b2v_inst1/fft_ip_gold/clk_ena
add wave -noupdate -color Cyan /plc_design_vhd_tst/i1/b2v_inst1/fft_ip_gold/inverse
add wave -noupdate -color Cyan /plc_design_vhd_tst/i1/b2v_inst1/fft_ip_gold/reset_n
add wave -noupdate /plc_design_vhd_tst/i1/b2v_inst1/send_data_valid_t
add wave -noupdate /plc_design_vhd_tst/i1/b2v_inst1/cnt_t
add wave -noupdate -divider {New Divider}
add wave -noupdate -color Cyan /plc_design_vhd_tst/i1/b2v_inst1/fft_ip_gold/sink_ready
add wave -noupdate -color Cyan /plc_design_vhd_tst/i1/b2v_inst1/fft_ip_gold/sink_error
add wave -noupdate -color Cyan /plc_design_vhd_tst/i1/b2v_inst1/fft_ip_gold/sink_valid
add wave -noupdate -color Cyan /plc_design_vhd_tst/i1/b2v_inst1/fft_ip_gold/sink_sop
add wave -noupdate -color Cyan /plc_design_vhd_tst/i1/b2v_inst1/fft_ip_gold/sink_eop
add wave -noupdate -color Cyan /plc_design_vhd_tst/i1/b2v_inst1/fft_ip_gold/sink_real
add wave -noupdate -color Cyan /plc_design_vhd_tst/i1/b2v_inst1/fft_ip_gold/sink_imag
add wave -noupdate -divider {New Divider}
add wave -noupdate -color Cyan /plc_design_vhd_tst/i1/b2v_inst1/fft_ip_gold/source_ready
add wave -noupdate -color Cyan /plc_design_vhd_tst/i1/b2v_inst1/fft_ip_gold/source_valid
add wave -noupdate -color Cyan /plc_design_vhd_tst/i1/b2v_inst1/fft_ip_gold/source_error
add wave -noupdate -color Cyan /plc_design_vhd_tst/i1/b2v_inst1/fft_ip_gold/source_sop
add wave -noupdate -color Cyan /plc_design_vhd_tst/i1/b2v_inst1/fft_ip_gold/source_eop
add wave -noupdate -color Cyan /plc_design_vhd_tst/i1/b2v_inst1/fft_ip_gold/source_real
add wave -noupdate -color Cyan /plc_design_vhd_tst/i1/b2v_inst1/fft_ip_gold/source_imag
add wave -noupdate -color Cyan /plc_design_vhd_tst/i1/b2v_inst1/fft_ip_gold/source_exp
add wave -noupdate -divider {New Divider}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {197500 ns} 0} {{Cursor 2} {620 ns} 0}
quietly wave cursor active 2
configure wave -namecolwidth 443
configure wave -valuecolwidth 54
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
WaveRestoreZoom {0 ns} {3990 ns}
