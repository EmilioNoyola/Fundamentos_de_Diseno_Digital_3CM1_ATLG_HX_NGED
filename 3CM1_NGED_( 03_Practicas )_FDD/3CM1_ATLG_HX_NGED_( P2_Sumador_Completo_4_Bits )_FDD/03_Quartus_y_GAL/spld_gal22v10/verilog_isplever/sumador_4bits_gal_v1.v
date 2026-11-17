// =====================================================================
//  sumador_4bits_gal_v1.v  --  SPLD GAL22V10 / ATF22V10C  (VERSION 1)
//  Archivo AUTOCONTENIDO: importa SOLO este archivo en ispLEVER Classic.
//
//  Por que C1, C2 y C3 son SALIDAS (pines) y no cables internos:
//  la GAL solo implementa "sumas de productos" de 2 niveles y cada salida
//  admite entre 8 y 16 productos. Si todo se "aplanara", S3 dependeria de
//  las 9 entradas y necesitaria muchisimos productos (no cabe).
//  Sacando los acarreos a pines, la GAL los realimenta a su matriz AND y
//  cada etapa solo necesita 4 productos (suma) y 3 productos (acarreo).
//  Se usan 8 de las 10 macroceldas de salida.
// =====================================================================
module fa_gal_v1 (input wire a, b, cin, output wire s, cout);
    wire p, g, pc;
    xor U_P  (p,    a, b);
    and U_G  (g,    a, b);
    and U_PC (pc,   p, cin);
    xor U_S  (s,    p, cin);
    or  U_CO (cout, g, pc);
endmodule

module sumador_4bits_gal_v1 (
    input  wire A0, B0, A1, B1, A2, B2, A3, B3, Cin,
    output wire S0, S1, S2, S3,
    output wire C1, C2, C3,          // acarreos visibles (realimentacion)
    output wire Cout
);
    fa_gal_v1 FA0 (.a(A0), .b(B0), .cin(Cin), .s(S0), .cout(C1));
    fa_gal_v1 FA1 (.a(A1), .b(B1), .cin(C1),  .s(S1), .cout(C2));
    fa_gal_v1 FA2 (.a(A2), .b(B2), .cin(C2),  .s(S2), .cout(C3));
    fa_gal_v1 FA3 (.a(A3), .b(B3), .cin(C3),  .s(S3), .cout(Cout));
endmodule
