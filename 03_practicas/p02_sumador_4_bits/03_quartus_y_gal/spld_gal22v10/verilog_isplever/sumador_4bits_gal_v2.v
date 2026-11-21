// =====================================================================
//  sumador_4bits_gal_v2.v  --  SPLD GAL22V10 / ATF22V10C  (VERSION 2)
//  Archivo AUTOCONTENIDO: importa SOLO este archivo en ispLEVER Classic.
//  (Ver explicacion de por que los acarreos salen a pines en la version 1.)
// =====================================================================
module fa_gal_v2 (input wire a, b, cin, output wire s, cout);
    wire ab, ac, bc, o1, x1;
    and U_AB (ab, a, b);
    and U_AC (ac, a, cin);
    and U_BC (bc, b, cin);
    or  U_O1 (o1, ab, ac);
    or  U_O2 (cout, o1, bc);
    xor U_X1 (x1, a, b);
    xor U_X2 (s,  x1, cin);
endmodule

module sumador_4bits_gal_v2 (
    input  wire A0, B0, A1, B1, A2, B2, A3, B3, Cin,
    output wire S0, S1, S2, S3,
    output wire C1, C2, C3,
    output wire Cout
);
    fa_gal_v2 FA0 (.a(A0), .b(B0), .cin(Cin), .s(S0), .cout(C1));
    fa_gal_v2 FA1 (.a(A1), .b(B1), .cin(C1),  .s(S1), .cout(C2));
    fa_gal_v2 FA2 (.a(A2), .b(B2), .cin(C2),  .s(S2), .cout(C3));
    fa_gal_v2 FA3 (.a(A3), .b(B3), .cin(C3),  .s(S3), .cout(Cout));
endmodule
