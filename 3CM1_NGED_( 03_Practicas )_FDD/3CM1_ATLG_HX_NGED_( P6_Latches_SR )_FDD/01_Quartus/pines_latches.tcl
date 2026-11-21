set_global_assignment -name USE_CONFIGURATION_DEVICE ON
set_global_assignment -name CYCLONEIII_CONFIGURATION_DEVICE EPCS16
set_global_assignment -name RESERVE_ALL_UNUSED_PINS_WEAK_PULLUP "AS INPUT TRI-STATED"
set_global_assignment -name CYCLONEII_RESERVE_NCEO_AFTER_CONFIGURATION "USE AS REGULAR IO"
set_global_assignment -name STRATIX_DEVICE_IO_STANDARD "3.3-V LVTTL"

set_location_assignment PIN_83 -to c_555
set_location_assignment PIN_58 -to sw_s
set_location_assignment PIN_54 -to sw_r

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
