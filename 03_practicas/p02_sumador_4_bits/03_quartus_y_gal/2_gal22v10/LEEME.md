# GAL22V10 (o ATF22V10C)

## Por qué los acarreos salen por pines
La GAL solo hace sumas de productos de 2 niveles (AND-OR) y cada salida admite de 8 a 16
productos. Si todo el sumador se "aplana", S3 necesitaría decenas de productos y no cabe.
Sacando C0, C1 y C2 a pines, la GAL los realimenta a su arreglo AND y cada sumador completo
usa solo 4 productos (suma) y 3 productos (acarreo). Por eso el diseño usa 8 de las 10 salidas.

## Distribución de pines (DIP-24)

```
                 GAL22V10
          -------\___/-------
       NC |  1           24 | VCC (+5 V)
       A0 |  2           23 | S0
       B0 |  3           22 | C0
       A1 |  4           21 | S1
       B1 |  5           20 | C1
       A2 |  6           19 | S2
       B2 |  7           18 | C2
       A3 |  8           17 | S3
       B3 |  9           16 | Cout
      Cin | 10           15 | NC
       NC | 11           14 | NC
      GND | 12           13 | NC
          -------------------
```

## Tres caminos para obtener el .jed (elige uno)

### A) Verilog con Lattice ispLEVER Classic (lo que pide la práctica)
1. **File > New Project** → tipo *Verilog HDL*, síntesis *Synplify*.
2. Marca *Show Obsolete Devices* → familia **GAL Device** → **GAL22V10** (paquete 24PDIP).
3. Importa `verilog_isplever/sumador_4bits_gal.v` (NO el testbench).
4. Selecciona `sumador_4bits_gal` como nivel superior → *Synplify Synthesize Verilog File*.
5. Sobre el dispositivo: **Link Design → Fit Design → Create Fuse Map** → genera el `.jed`.
6. Para fijar los pines de la tabla de arriba usa el *Constraint Editor* antes de *Fit Design*.
   Si no los fijas, el fitter elige los pines: revísalos en el reporte (.rpt) antes de cablear.

### B) CUPL con WinCUPL (muy usado para la ATF22V10)
Abre `wincupl/sumador4.pld` → **Run > Device Dependent Compile** → genera `SUMADOR4.jed`.
Los pines ya van declarados en el archivo.

### C) Usar el archivo ya generado
`jedec_listo/sumador4.jed` (pines de la tabla de arriba). Fue creado con galette a partir de
`sumador4.pld` y verificado simulando sus fusibles con las 512 combinaciones.

## Grabar la GAL
En el programador (TL866/T48 con Xgpro, Dataman, Xeltek…): elige el chip exacto que tengas
(GAL22V10 de Lattice o ATF22V10C de Atmel/Microchip) → **Load** el `.jed` → **Erase** →
**Program** → **Verify**.

## Armado en la protoboard
* Pin 24 a +5 V y pin 12 a GND, con un capacitor de 0.1 µF entre ambos.
* Entradas (pines 2–10) desde un DIP switch con resistencias pull-down de 10 kΩ a GND.
* Conecta a GND las entradas sin usar (pines 1, 11 y 13).
* Salidas S0–S3 y Cout a LEDs con resistencia de 1 kΩ a GND. Opcional: LEDs en C0, C1, C2
  para ver cómo se propaga el acarreo.
