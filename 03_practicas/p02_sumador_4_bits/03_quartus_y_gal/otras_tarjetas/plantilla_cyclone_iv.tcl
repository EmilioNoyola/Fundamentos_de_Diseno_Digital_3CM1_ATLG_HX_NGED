# Plantilla para tarjetas Cyclone IV "economicas" (EP4CE6E22C8, EP4CE10E22C8...)
# 1) En el asistente de proyecto elige Family = Cyclone IV E y el DEVICE impreso en el chip.
# 2) Sustituye xx por los pines que tu tarjeta conecta a interruptores/LEDs (ver su manual).
#    Si tu tarjeta no tiene suficientes interruptores, usa DIP switches en protoboard a 3.3 V.
# set_location_assignment PIN_xx -to A[0]
# ... (repite para A[1..3], B[0..3], Cin, S[0..3], Cout)
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to A[*]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to B[*]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to Cin
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to S[*]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to Cout
