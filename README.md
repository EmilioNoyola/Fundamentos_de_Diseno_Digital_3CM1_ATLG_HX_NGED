<h1 align="center">Fundamentos de Diseño Digital</h1>

<p align="center"><strong>Escuela Superior de Cómputo · Instituto Politécnico Nacional</strong><br>Ingeniería en Sistemas Computacionales · Tercer semestre</p>

<p align="center">
  <a href="https://www.escom.ipn.mx/htmls/oferta/mapaCurrISC2020.php"><img src="https://img.shields.io/badge/ISC-Plan_2020-6D1A42?style=flat-square" alt="ISC · Plan 2020"></a>
  <img src="https://img.shields.io/badge/Semestre-III-334155?style=flat-square" alt="Semestre III">
  <img src="https://img.shields.io/badge/Grupo-3CM1-1E5A7A?style=flat-square" alt="Grupo 3CM1">
</p>

<p align="center"><a href="#programa-de-estudios">Programa de estudios</a> &nbsp;·&nbsp; <a href="#contenido-del-repositorio">Contenido</a> &nbsp;·&nbsp; <a href="#uso-del-material">Uso del material</a> &nbsp;·&nbsp; <a href="#referencias">Referencias</a></p>

---

Diseño y simulación de circuitos digitales, desde representaciones binarias y lógica combinacional hasta latches SR. Reúne código Verilog, proyectos de Gowin y Quartus, bancos de prueba, reportes y guías.

| Acceso directo | Qué encontrarás |
|---|---|
| [Abrir la práctica de latches](03_practicas/p06_latches_sr/) | Informe, fuentes Verilog y simulación Questa. |
| [Revisar sumadores](03_practicas/p02_sumador_4_bits/) | Implementaciones Gowin, Quartus y GAL. |
| [Consultar las guías](04_guias/) | Nueve guías ordenadas por tema y práctica. |

## Programa de estudios

Construir circuitos combinacionales y elementos de memoria mediante representaciones booleanas, HDL y dispositivos reconfigurables.

Síntesis del [programa oficial de la unidad de aprendizaje](https://www.escom.ipn.mx/docs/oferta/uaISC2020/fundamentosDisenoDigital_ISC2020.pdf), perteneciente al **Plan ISC 2020**.

**Carga semanal:** 3 horas de teoría y 1.5 de práctica. **Créditos:** 7.5 TEPIC / 6.4 SATCA.

| Unidad | Eje de estudio | Alcance |
|:---:|---|---|
| I | Bases del diseño digital | Representación de información y fundamentos de lógica. |
| II | Dispositivos programables y HDL | Tecnologías reconfigurables y descripción de hardware. |
| III | Circuitos combinacionales | Síntesis e implementación de funciones lógicas. |
| IV | Almacenamiento elemental | Elementos de memoria y comportamiento secuencial básico. |

**Antecedentes académicos:** Matemáticas Discretas y Algoritmos y Estructuras de Datos.

El programa describe el alcance de la asignatura. Las carpetas siguientes muestran el material efectivamente disponible en esta colección.

## Contenido del repositorio

| Carpeta | Contenido |
|---|---|
| [Ejercicios](01_ejercicios/) · `01_ejercicios` | LEDs con Tang Nano 9K. |
| [Tareas](02_tareas/) · `02_tareas` | Circuitos integrados, representaciones, comparador y sumador-restador. |
| [Prácticas](03_practicas/) · `03_practicas` | Falstad/Tinkercad, sumadores, restador, BCD a 7 segmentos, 555 y latches. |
| [Guías](04_guias/) · `04_guias` | Enteros con signo, Karnaugh, Verilog, aritmética digital y memoria. |
| [Recursos](05_recursos/) · `05_recursos` | Ejemplos de Tang Nano 9K y material de Cyclone IV. |
| [Apuntes](06_apuntes/) · `06_apuntes` | Cuaderno de clase. |

Los números de actividad conservan la identificación de las entregas; las guías se distinguen por el prefijo `g` y las prácticas por `p` o `act`, según la materia.

## Uso del material

### Elegir la herramienta

| Archivo o recurso | Aplicación |
|---|---|
| `.gprj` | Gowin EDA para los proyectos Tang Nano 9K. |
| `.qpf` junto con `.qsf` | Quartus Prime Lite y el soporte del dispositivo seleccionado. |
| `.v` y banco de pruebas | Questa para simulación de Verilog. |
| Prácticas de circuitos | Falstad o Tinkercad, según el reporte de la actividad. |

Conserva cada proyecto con sus fuentes, restricciones y archivos de configuración. Las carpetas académicas usan nombres ASCII sin espacios; los identificadores de módulos y proyectos mantienen los nombres que requieren las herramientas.

### Simular Latches SR

Desde la raíz del repositorio, con Questa instalado y su licencia configurada:

```powershell
.\03_practicas\p06_latches_sr\01_quartus\simular_questa.cmd
```

El [lanzador](03_practicas/p06_latches_sr/01_quartus/simular_questa.cmd) busca Questa en `PATH` o en la instalación habitual de Quartus bajo `C:\altera_lite`. El [script Tcl](03_practicas/p06_latches_sr/01_quartus/simular_questa.tcl) resuelve las fuentes respecto de su propia ubicación y crea la biblioteca temporal en `.simulacion`.

Si Questa ya está abierto, ejecuta `source` con la ruta del archivo `simular_questa.tcl`. El banco de pruebas y las [ondas configuradas](03_practicas/p06_latches_sr/01_quartus/questa_ondas.do) quedan junto a los módulos de la práctica.

<details>
<summary><strong>Validaciones registradas el 20 de noviembre de 2026</strong></summary>

| Comprobación | Resultado |
|---|---|
| Cinco proyectos Gowin | Compilación completa. |
| Sumador y latches para Cyclone IV | Compilación completa en Quartus. |
| Cuatro escenarios Questa | Simulación completada, incluido el arranque de latches desde otra carpeta. |
| Cuatro variantes MAX II/MAX 10 | Compilación pendiente: falta instalar el soporte de esos dispositivos. |

Son verificaciones de compilación y simulación; no sustituyen la comprobación del montaje o la programación de una placa física. Los resultados regenerables se excluyen de Git.

</details>

<details>
<summary><strong>Clonar el repositorio y descargar archivos grandes</strong></summary>

```powershell
git clone https://github.com/EmilioNoyola/Fundamentos_de_Diseno_Digital_3CM1_ATLG_HX_NGED.git fundamentos_disenho_digital
cd fundamentos_disenho_digital
git lfs install
git lfs pull
```

Algunos recursos se almacenan con Git LFS. Instálalo antes de descargarlos; si ves un archivo de texto que empieza por `version https://git-lfs.github.com/spec/v1`, falta obtener el contenido con `git lfs pull`.

</details>

## Referencias

- [Programa oficial de Fundamentos de Diseño Digital — PDF](https://www.escom.ipn.mx/docs/oferta/uaISC2020/fundamentosDisenoDigital_ISC2020.pdf): unidades, carga académica, evaluación y bibliografía institucional.
- [Catálogo de unidades de aprendizaje de ISC 2020](https://www.escom.ipn.mx/htmls/oferta/mapaCurrISC2020.php): programas oficiales publicados por ESCOM.
- [Mapa curricular de ISC 2020 — PDF](https://www.escom.ipn.mx/docs/oferta/mapaCurricularISC2020.pdf): ubicación de la materia en la carrera.

---

**Repositorios relacionados:** [Circuitos Eléctricos](https://github.com/EmilioNoyola/Circuitos_Electricos_3CM1_ATLG_HEY_HX_NGED) · [Paradigmas de Programación](https://github.com/EmilioNoyola/Paradigmas_de_Programacion_3CM3_NGED).

Colección académica de [Emilio Noyola](https://github.com/EmilioNoyola). La autoría de cada entrega se indica en su portada o en el código correspondiente.
