vcom -93 -work work {plc_design_vhd_tst.vht}
vcom -93 -work work {transfer.vhd}
#vsim -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cycloneive -L rtl_work -L work plc_design_vhd_tst
vsim work.plc_design_vhd_tst
do wave_fft.do
run 200us