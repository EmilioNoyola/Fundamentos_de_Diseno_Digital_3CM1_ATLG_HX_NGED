// ============================================================================
//  sumador_4bits_gal.v
//  Sumador de 4 bits a partir de 4 sumadores completos - versión para GAL22V10
//  Herramienta: Lattice ispLEVER Classic (Synplify)  ->  genera el archivo .JED
//
//  ¿Por qué C0, C1 y C2 son SALIDAS en esta versión?
//  La GAL22V10 solo sabe hacer sumas de productos de 2 niveles (AND-OR),
//  con 8 a 16 productos por salida. Si el sintetizador "aplana" todo el
//  sumador, S3 necesitaría decenas de productos y NO CABE. Sacando cada
//  acarreo a un pin, la GAL lo realimenta al arreglo AND y cada sumador
//  completo queda en su propia etapa, con muy pocos productos:
//      S  = A xor B xor Cin     -> 4 productos
//      Co = AB + ACin + BCin    -> 3 productos
//  Los pines de C0, C1 y C2 se pueden dejar sin conectar en la protoboard
//  (o ponerles un LED para ver cómo se propaga el acarreo).
// ============================================================================

// ---------------- Sumador completo de 1 bit ----------------
module sumador_completo (
    input  A,
    input  B,
    input  Cin,
    output S,
    output Cout
);
    assign S    = A ^ B ^ Cin;
    assign Cout = (A & B) | (A & Cin) | (B & Cin);
endmodule

// ---------------- Nivel superior: 4 sumadores en cascada ----------------
//  Puertos escalares (un pin de la GAL por señal).
//  Asignación de pines sugerida (fíjala en el Constraint Editor de ispLEVER,
//  o revisa en el reporte del fitter qué pin eligió para cada señal):
//     Entradas: A0=2  B0=3  A1=4  B1=5  A2=6  B2=7  A3=8  B3=9  Cin=10
//     Salidas : S0=23 C0=22 S1=21 C1=20 S2=19 C2=18 S3=17 Cout=16
//     GND=12  VCC=24
module sumador_4bits_gal (
    input  A0, A1, A2, A3,
    input  B0, B1, B2, B3,
    input  Cin,
    output S0, S1, S2, S3,
    output C0, C1, C2,       // acarreos intermedios (necesarios en la GAL)
    output Cout
);
    sumador_completo SC0 (.A(A0), .B(B0), .Cin(Cin), .S(S0), .Cout(C0));
    sumador_completo SC1 (.A(A1), .B(B1), .Cin(C0),  .S(S1), .Cout(C1));
    sumador_completo SC2 (.A(A2), .B(B2), .Cin(C1),  .S(S2), .Cout(C2));
    sumador_completo SC3 (.A(A3), .B(B3), .Cin(C2),  .S(S3), .Cout(Cout));
endmodule
