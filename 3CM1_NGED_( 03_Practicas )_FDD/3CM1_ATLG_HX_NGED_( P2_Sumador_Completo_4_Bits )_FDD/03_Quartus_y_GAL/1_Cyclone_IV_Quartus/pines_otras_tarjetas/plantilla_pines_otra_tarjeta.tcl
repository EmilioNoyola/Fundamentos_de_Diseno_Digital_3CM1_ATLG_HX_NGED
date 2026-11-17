# ============================================================================
#  Plantilla de pines para OTRA tarjeta con Cyclone IV
#
#  Cómo usarla:
#   1. En Quartus: Assignments > Device... y elige el chip de TU tarjeta
#      (está impreso sobre el FPGA; ej. EP4CE6E22C8, EP4CE10E22C8, EP4CE22F17C6).
#   2. Reemplaza cada PIN_XXX por el pin real, según el manual/esquemático de tu tarjeta.
#   3. Borra del .qsf las líneas set_location_assignment de la DE2-115.
#   4. Tools > Tcl Scripts... > selecciona este archivo > Run.
#      (o copia las líneas al final del .qsf)
#
#  IMPORTANTE: el sumador necesita 9 entradas y 5 salidas. Muchas tarjetas
#  económicas solo traen 4 botones y 4 LEDs; en ese caso conecta un DIP switch
#  y LEDs externos a los pines del conector de expansión (GPIO) de la tarjeta,
#  respetando el voltaje de esos pines (normalmente 3.3 V, NUNCA 5 V).
#  Si los LEDs o botones de tu tarjeta son activos en bajo (se encienden con 0),
#  avísame y te paso la versión con salidas invertidas.
# ============================================================================
set_location_assignment PIN_XXX -to Cin
set_location_assignment PIN_XXX -to A[3]
set_location_assignment PIN_XXX -to A[2]
set_location_assignment PIN_XXX -to A[1]
set_location_assignment PIN_XXX -to A[0]
set_location_assignment PIN_XXX -to B[3]
set_location_assignment PIN_XXX -to B[2]
set_location_assignment PIN_XXX -to B[1]
set_location_assignment PIN_XXX -to B[0]
set_location_assignment PIN_XXX -to Cout
set_location_assignment PIN_XXX -to S[3]
set_location_assignment PIN_XXX -to S[2]
set_location_assignment PIN_XXX -to S[1]
set_location_assignment PIN_XXX -to S[0]
# Estándar de E/S típico de los conectores de expansión:
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to *
