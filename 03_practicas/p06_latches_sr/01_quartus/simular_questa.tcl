# Ejecutar con: source simular_questa.tcl
# Las fuentes se resuelven desde este archivo, no desde el directorio de Questa.
set ruta_proyecto [file normalize [file dirname [info script]]]
set ruta_trabajo [file join $ruta_proyecto .simulacion]
file mkdir $ruta_trabajo
catch {quit -sim}
cd $ruta_trabajo
if {[file exists work]} {
    vdel -lib work -all
}
vlib work
vmap work work
foreach fuente {latch_sr_nand_prim.v latch_sr_nand_asg.v latch_sr_nor_prim.v latch_sr_nor_asg.v tb_latches.v} {
    vlog -work work [file join $ruta_proyecto $fuente]
}
vsim -voptargs=+acc -onfinish stop work.tb_latches
do [file join $ruta_proyecto questa_ondas.do]
puts "SIMULACION_LATCHES_COMPLETA"
