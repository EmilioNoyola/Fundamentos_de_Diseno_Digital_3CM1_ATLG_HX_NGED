// =====================================================================
//  sumador_4bits_v2.v  --  Sumador de 4 bits en cascada (ripple carry)
//  construido con 4 instancias de sumador_completo_v2 (VERSION 2).
// =====================================================================
module sumador_4bits_v2 (
    input  wire [3:0] A,
    input  wire [3:0] B,
    input  wire       Cin,
    output wire [3:0] S,
    output wire       Cout
);
    wire C1, C2, C3;

    sumador_completo_v2 FA0 (.a(A[0]), .b(B[0]), .cin(Cin), .s(S[0]), .cout(C1));
    sumador_completo_v2 FA1 (.a(A[1]), .b(B[1]), .cin(C1),  .s(S[1]), .cout(C2));
    sumador_completo_v2 FA2 (.a(A[2]), .b(B[2]), .cin(C2),  .s(S[2]), .cout(C3));
    sumador_completo_v2 FA3 (.a(A[3]), .b(B[3]), .cin(C3),  .s(S[3]), .cout(Cout));
endmodule
