# Las fuentes se resuelven desde este archivo.
set ruta_proyecto [file normalize [file dirname [info script]]]
set ruta_trabajo [file join $ruta_proyecto .simulacion]
file mkdir $ruta_trabajo
catch {quit -sim}
cd $ruta_trabajo
if {[file exists work]} {vdel -lib work -all}
vlib work
vmap work work
foreach fuente {d_ffp.v sr_ffp.v t_ffp.v jk_ffn.v ff_top_555.v tb_flipflops.v tb_flipflops_verificacion.v} {
    vlog -work work [file join $ruta_proyecto $fuente]
}
vsim -voptargs=+acc -onfinish stop work.tb_flipflops
do [file join $ruta_proyecto questa_ondas.do]
puts "SIMULACION_FLIPFLOPS_COMPLETA"
