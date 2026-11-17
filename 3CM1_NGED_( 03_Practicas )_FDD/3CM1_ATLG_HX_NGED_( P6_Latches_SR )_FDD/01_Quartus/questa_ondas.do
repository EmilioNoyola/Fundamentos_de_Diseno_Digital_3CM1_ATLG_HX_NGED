# questa_ondas.do - lo ejecuta Quartus (NativeLink) despues de vsim
# Agrega las senales en orden, con divisores, y corre 12.5 s simulados.
# La ventana de Questa se queda abierta para que revises las ondas.
configure wave -signalnamewidth 1
configure wave -timelineunits ms
add wave -divider "Entradas"
add wave -label S /tb_latches/S
add wave -label R /tb_latches/R
add wave -label C /tb_latches/C
add wave -divider "NAND primitivas"
add wave -label Q  /tb_latches/Q1
add wave -label Qn /tb_latches/Qn1
add wave -divider "NAND assign"
add wave -label Q  /tb_latches/Q2
add wave -label Qn /tb_latches/Qn2
add wave -divider "NOR primitivas"
add wave -label Q  /tb_latches/Q3
add wave -label Qn /tb_latches/Qn3
add wave -divider "NOR assign"
add wave -label Q  /tb_latches/Q4
add wave -label Qn /tb_latches/Qn4
add wave -divider "Revision"
add wave -label esperado /tb_latches/esperado
add wave -label errores -radix unsigned /tb_latches/errores
run 12499ms
wave zoom full
echo "Revisiones: [examine -radix unsigned /tb_latches/revisiones]  Errores: [examine -radix unsigned /tb_latches/errores]"
