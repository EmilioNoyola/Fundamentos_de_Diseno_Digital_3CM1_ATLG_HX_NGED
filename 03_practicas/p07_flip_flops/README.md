# Práctica 7 · Flip-flops SR, D, T y JK

Implementación para Cyclone IV E EP4CE6E22C8 con reloj externo de 3 segundos generado por un 555. El proyecto principal conserva la versión editada en Documentos; la salida `sdram_cs_n` mantiene deshabilitada la SDRAM de la tarjeta.

| Recurso | Uso |
|---|---|
| [Guía completa](../../04_guias/g10_p7_flip_flops.pdf) | Desarrollo, simulación y montaje; incluye como alternativa un reloj de 50 MHz dividido. |
| [Proyecto Quartus](01_quartus/p7_flipflops.qpf) | Abrir la revisión `ff_top_555`; fuentes y pines en la misma carpeta. |
| [Montaje](02_montaje/) | Conexión del 555 y fila correcta del conector P2. |
| [Circuito Falstad](03_falstad/flip_flops.txt) | Importar con **File → Import From Text** en CircuitJS. |

## Simulación

Con Questa instalado y su licencia configurada, ejecutar `01_quartus/simular_questa.cmd`. El lanzador resuelve las fuentes desde su ubicación y guarda los resultados regenerables en `.simulacion`.

`tb_flipflops.v` muestra las ondas del módulo superior durante 25 segundos simulados. `tb_flipflops_verificacion.v` compara los cuatro módulos con sus tablas de comportamiento y reporta el número de revisiones y errores. Son bancos de pruebas distintos: el segundo se simula seleccionando `work.tb_flipflops_verificacion` y ejecutando `run -all` después de compilar.

Las salidas de compilación y la biblioteca de simulación se regeneran localmente y quedan excluidas de Git. La simulación no sustituye una prueba con la placa física.
