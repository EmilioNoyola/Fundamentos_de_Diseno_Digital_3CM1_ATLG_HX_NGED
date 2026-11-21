# Sumador de 4 bits a partir de 4 sumadores completos — Verilog

Práctica: *Diseño e Implementación de un Sumador Completo de 4 Bits* · Fundamentos de Diseño Digital · ESCOM-IPN

```
Sumador4bits_Verilog/
├── 1_cyclone_iv_quartus/          ← FPGA Intel/Altera Cyclone IV (Quartus Prime)
│   ├── sumador_4bits.qpf          proyecto de Quartus (ábrelo con File > Open Project)
│   ├── sumador_4bits.qsf          dispositivo + asignación de pines (DE2-115)
│   ├── rtl/sumador_completo.v     sumador completo de 1 bit (compuertas)
│   ├── rtl/sumador_4bits.v        nivel superior: 4 sumadores completos en cascada
│   ├── sim/tb_sumador_4bits.v     banco de pruebas (512 combinaciones)
│   └── pines_otras_tarjetas/      plantilla por si tu tarjeta no es la DE2-115
└── 2_gal22v10/                    ← SPLD GAL22V10 / ATF22V10
    ├── verilog_isplever/          Verilog para Lattice ispLEVER Classic (+ testbench)
    ├── wincupl/sumador4.pld       misma lógica en CUPL para WinCUPL
    └── jedec_listo/sumador4.jed   archivo listo para grabar (verificado)
```

## Verificación hecha a estos archivos
* **Verilog (ambas versiones):** simulado con Icarus Verilog, las 512 combinaciones posibles de A, B y Cin dan `{Cout,S} = A + B + Cin`.
* **Cyclone IV:** sintetizado con Yosys para Cyclone IV → 10 elementos lógicos, sin errores.
* **GAL22V10:** el `.jed` se generó con el ensamblador *galette* y se simuló fusible por fusible
  con el mapa de la hoja de datos de la 22V10: 512/512 correctas.
* No fue posible ejecutar Quartus ni ispLEVER aquí (son programas de Windows/Linux con licencia
  gratuita que corren en tu computadora). Si alguno marca un error, copia el mensaje y lo revisamos.

Las instrucciones detalladas están en el `LEEME.md` de cada carpeta.
