set_global_assignment -name USE_CONFIGURATION_DEVICE ON
set_global_assignment -name CYCLONEIII_CONFIGURATION_DEVICE EPCS16
set_global_assignment -name RESERVE_ALL_UNUSED_PINS_WEAK_PULLUP "AS INPUT TRI-STATED"
set_global_assignment -name CYCLONEII_RESERVE_NCEO_AFTER_CONFIGURATION "USE AS REGULAR IO"
set_global_assignment -name STRATIX_DEVICE_IO_STANDARD "3.3-V LVTTL"

set_location_assignment PIN_83 -to clk_555

set_location_assignment PIN_50 -to sw_sj
set_location_assignment PIN_52 -to sw_rk
set_location_assignment PIN_54 -to sw_dt
set_location_assignment PIN_58 -to sw_rst

set_location_assignment PIN_60 -to q_sr
set_location_assignment PIN_65 -to qn_sr
set_location_assignment PIN_67 -to q_d
set_location_assignment PIN_69 -to qn_d
set_location_assignment PIN_71 -to q_t
set_location_assignment PIN_73 -to qn_t
set_location_assignment PIN_75 -to q_jk
set_location_assignment PIN_77 -to qn_jk

set_location_assignment PIN_72 -to sdram_cs_n

export_assignments
