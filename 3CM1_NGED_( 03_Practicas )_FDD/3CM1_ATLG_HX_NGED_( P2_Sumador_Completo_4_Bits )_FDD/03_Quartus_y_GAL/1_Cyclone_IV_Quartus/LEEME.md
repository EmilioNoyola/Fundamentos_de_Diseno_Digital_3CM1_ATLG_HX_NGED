# Cyclone IV con Quartus Prime Lite

## Mapa de la tarjeta DE2-115 (ya configurado en el .qsf)

| Señal | Interruptor / LED | Pin FPGA |
|---|---|---|
| Cin | SW8 | PIN_AC25 |
| A3 A2 A1 A0 | SW7 SW6 SW5 SW4 | AB26 AD26 AC26 AB27 |
| B3 B2 B1 B0 | SW3 SW2 SW1 SW0 | AD27 AC27 AC28 AB28 |
| Cout | LEDR4 | PIN_F18 |
| S3 S2 S1 S0 | LEDR3 LEDR2 LEDR1 LEDR0 | F21 E19 F19 G19 |

Leídos de izquierda a derecha, **LEDR4…LEDR0 = Cout S3 S2 S1 S0**, el resultado de 5 bits.

## Pasos
1. Abre Quartus Prime Lite → **File > Open Project** → `sumador_4bits.qpf`.
2. **Processing > Start Compilation** (Ctrl+L). Debe terminar sin errores.
3. Revisa los pines en **Assignments > Pin Planner** (ya vienen asignados).
4. Conecta la tarjeta por USB-Blaster → **Tools > Programmer** → *Hardware Setup* → USB-Blaster →
   verifica que aparezca `output_files/sumador_4bits.sof` con la casilla *Program/Configure* → **Start**.
5. Mueve los interruptores y compara con la tabla de verdad.

## Simulación (antes de programar)
* **ModelSim/Questa (incluido con Quartus):** crea un proyecto, agrega los 3 archivos `.v`
  (rtl + sim), compila, simula `tb_sumador_4bits` y ejecuta `run -all`.
  La consola debe decir `PRUEBA SUPERADA: 512 combinaciones correctas.`
* **Icarus Verilog (gratuito, opcional):**
  `iverilog -o tb rtl/*.v sim/tb_sumador_4bits.v && vvp tb` → y abre `sumador_4bits.vcd` en GTKWave.

## ¿Otra tarjeta?
Usa `pines_otras_tarjetas/plantilla_pines_otra_tarjeta.tcl`: cambia el DEVICE por el chip impreso
en tu FPGA y los números de pin por los de su manual. El Verilog NO cambia.
