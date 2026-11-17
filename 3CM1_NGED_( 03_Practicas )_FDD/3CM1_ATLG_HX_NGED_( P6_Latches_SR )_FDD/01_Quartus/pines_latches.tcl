# pines_latches.tcl - Practica 6, tarjeta RZ301 (Cyclone IV EP4CE6E22C8)
# Uso: con el proyecto abierto, Tools > Tcl Scripts... > este archivo > Run
# (o en la consola Tcl:  source pines_latches.tcl)

# ---- opciones del chip (capitulo 11)
set_global_assignment -name USE_CONFIGURATION_DEVICE ON
set_global_assignment -name CYCLONEIII_CONFIGURATION_DEVICE EPCS16
set_global_assignment -name RESERVE_ALL_UNUSED_PINS_WEAK_PULLUP "AS INPUT TRI-STATED"
set_global_assignment -name CYCLONEII_RESERVE_NCEO_AFTER_CONFIGURATION "USE AS REGULAR IO"
set_global_assignment -name STRATIX_DEVICE_IO_STANDARD "3.3-V LVTTL"

# ---- entradas desde la protoboard (conector P2)
set_location_assignment PIN_83 -to c_555
set_location_assignment PIN_58 -to sw_s
set_location_assignment PIN_54 -to sw_r

# ---- salidas al conector P2 (fila de posiciones impares 9..23)
#      (S y R entran por las posiciones 25 y 27)
set_location_assignment PIN_77 -to q_nand_prim
set_location_assignment PIN_75 -to qn_nand_prim
set_location_assignment PIN_73 -to q_nand_asg
set_location_assignment PIN_71 -to qn_nand_asg
set_location_assignment PIN_69 -to q_nor_prim
set_location_assignment PIN_67 -to qn_nor_prim
set_location_assignment PIN_65 -to q_nor_asg
set_location_assignment PIN_60 -to qn_nor_asg

export_assignments
puts "Pines de la practica 6 asignados."
