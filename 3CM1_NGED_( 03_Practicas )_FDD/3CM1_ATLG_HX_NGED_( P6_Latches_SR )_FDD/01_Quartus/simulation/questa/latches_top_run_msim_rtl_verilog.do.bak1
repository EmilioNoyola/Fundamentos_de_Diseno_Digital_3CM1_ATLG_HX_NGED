transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog  -work work +incdir+C:/Users/noyol/Documents/p6_latches {C:/Users/noyol/Documents/p6_latches/latch_sr_nand_prim.v}
vlog  -work work +incdir+C:/Users/noyol/Documents/p6_latches {C:/Users/noyol/Documents/p6_latches/latch_sr_nand_asg.v}
vlog  -work work +incdir+C:/Users/noyol/Documents/p6_latches {C:/Users/noyol/Documents/p6_latches/latch_sr_nor_prim.v}
vlog  -work work +incdir+C:/Users/noyol/Documents/p6_latches {C:/Users/noyol/Documents/p6_latches/latch_sr_nor_asg.v}
vlog  -work work +incdir+C:/Users/noyol/Documents/p6_latches {C:/Users/noyol/Documents/p6_latches/latches_top.v}

vlog  -work work +incdir+C:/Users/noyol/Documents/p6_latches {C:/Users/noyol/Documents/p6_latches/tb_latches.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  tb_latches

do C:/Users/noyol/Documents/p6_latches/questa_ondas.do
