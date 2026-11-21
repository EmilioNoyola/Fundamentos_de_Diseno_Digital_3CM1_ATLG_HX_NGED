`timescale 1ns / 1ps
module sumador_4bits (
    input  wire [3:0] A,
    input  wire [3:0] B,
    input  wire       Cin,
    output wire [3:0] S,
    output wire       Cout
);
    wire C0, C1, C2;

    wire ab0, ac0, bc0;
    wire ab1, ac1, bc1;
    wire ab2, ac2, bc2;
    wire ab3, ac3, bc3;

    xor g_s0  (S[0], A[0], B[0], Cin);
    and g_ab0 (ab0,  A[0], B[0]);
    and g_ac0 (ac0,  A[0], Cin);
    and g_bc0 (bc0,  B[0], Cin);
    or  g_c0  (C0,   ab0, ac0, bc0);

    xor g_s1  (S[1], A[1], B[1], C0);
    and g_ab1 (ab1,  A[1], B[1]);
    and g_ac1 (ac1,  A[1], C0);
    and g_bc1 (bc1,  B[1], C0);
    or  g_c1  (C1,   ab1, ac1, bc1);

    xor g_s2  (S[2], A[2], B[2], C1);
    and g_ab2 (ab2,  A[2], B[2]);
    and g_ac2 (ac2,  A[2], C1);
    and g_bc2 (bc2,  B[2], C1);
    or  g_c2  (C2,   ab2, ac2, bc2);

    xor g_s3  (S[3], A[3], B[3], C2);
    and g_ab3 (ab3,  A[3], B[3]);
    and g_ac3 (ac3,  A[3], C2);
    and g_bc3 (bc3,  B[3], C2);
    or  g_c3  (Cout, ab3, ac3, bc3);
endmodule