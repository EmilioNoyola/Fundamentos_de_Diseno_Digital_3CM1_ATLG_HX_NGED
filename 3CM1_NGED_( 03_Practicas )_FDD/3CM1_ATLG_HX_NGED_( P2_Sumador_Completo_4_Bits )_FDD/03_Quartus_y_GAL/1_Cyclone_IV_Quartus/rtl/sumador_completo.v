// ============================================================================
//  sumador_completo.v
//  Sumador completo de 1 bit (full adder) - descripción a nivel de compuertas
//
//  Práctica: Diseño e Implementación de un Sumador Completo de 4 Bits
//  Unidad de Aprendizaje: Fundamentos de Diseño Digital - ESCOM IPN
//
//  Ecuaciones (obtenidas con mapas de Karnaugh):
//      S    = A xor B xor Cin
//      Cout = A·B + A·Cin + B·Cin
//
//  Es exactamente el circuito "rojo" visto en clase: una XOR de 3 entradas
//  para la suma, tres AND y una OR de 3 entradas para el acarreo.
// ============================================================================
`timescale 1ns / 1ps
module sumador_completo (
    input  wire A,      // bit del primer número
    input  wire B,      // bit del segundo número
    input  wire Cin,    // acarreo que llega de la etapa anterior
    output wire S,      // bit de suma
    output wire Cout    // acarreo que sale hacia la etapa siguiente
);
    // Cables internos: salidas de las tres compuertas AND
    wire ab, acin, bcin;

    // --- Suma: XOR de 3 entradas -------------------------------------------
    xor  g_suma (S, A, B, Cin);

    // --- Acarreo: tres AND y una OR de 3 entradas --------------------------
    and  g_and1 (ab,   A, B);
    and  g_and2 (acin, A, Cin);
    and  g_and3 (bcin, B, Cin);
    or   g_or   (Cout, ab, acin, bcin);

    // Descripción equivalente por flujo de datos (dataflow), por si tu
    // profesor la prefiere. Produce el mismo hardware:
    //   assign S    = A ^ B ^ Cin;
    //   assign Cout = (A & B) | (A & Cin) | (B & Cin);
endmodule
