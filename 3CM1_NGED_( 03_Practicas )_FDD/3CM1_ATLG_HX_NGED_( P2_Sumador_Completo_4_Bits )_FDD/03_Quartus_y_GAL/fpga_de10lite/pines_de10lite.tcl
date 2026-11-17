# ---------------- Pines DE10-Lite (MAX 10 10M50DAF484C7G) ----------------
# Interruptores:  SW0-SW3 = A[0..3]   SW4-SW7 = B[0..3]   SW8 = Cin
# LEDs:           LEDR0-LEDR3 = S[0..3]   LEDR4 = Cout
set_location_assignment PIN_C10 -to A[0]
set_location_assignment PIN_C11 -to A[1]
set_location_assignment PIN_D12 -to A[2]
set_location_assignment PIN_C12 -to A[3]
set_location_assignment PIN_A12 -to B[0]
set_location_assignment PIN_B12 -to B[1]
set_location_assignment PIN_A13 -to B[2]
set_location_assignment PIN_A14 -to B[3]
set_location_assignment PIN_B14 -to Cin
set_location_assignment PIN_A8  -to S[0]
set_location_assignment PIN_A9  -to S[1]
set_location_assignment PIN_A10 -to S[2]
set_location_assignment PIN_B10 -to S[3]
set_location_assignment PIN_D13 -to Cout
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to A[*]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to B[*]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to Cin
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to S[*]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to Cout
