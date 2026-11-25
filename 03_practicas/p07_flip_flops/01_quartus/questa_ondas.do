configure wave -signalnamewidth 1
configure wave -timelineunits ms
add wave -divider Entradas
add wave /tb_flipflops/clk_555
add wave /tb_flipflops/sw_rst
add wave /tb_flipflops/sw_sj
add wave /tb_flipflops/sw_rk
add wave /tb_flipflops/sw_dt
add wave -divider SR
add wave /tb_flipflops/q_sr
add wave /tb_flipflops/qn_sr
add wave -divider D
add wave /tb_flipflops/q_d
add wave /tb_flipflops/qn_d
add wave -divider T
add wave /tb_flipflops/q_t
add wave /tb_flipflops/qn_t
add wave -divider JK
add wave /tb_flipflops/q_jk
add wave /tb_flipflops/qn_jk
run 25000 ms
wave zoom full
