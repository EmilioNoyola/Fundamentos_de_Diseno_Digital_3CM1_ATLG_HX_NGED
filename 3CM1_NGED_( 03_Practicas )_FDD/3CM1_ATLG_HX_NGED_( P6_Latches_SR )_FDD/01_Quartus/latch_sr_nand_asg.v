// ============================================================
//  Latch SR con entrada de control C, compuertas NAND
//  Arquitectura de FLUJO DE DATOS: ecuaciones con assign
// ============================================================
module latch_sr_nand_asg (
    input  wire S,
    input  wire R,
    input  wire C,
    output wire Q,
    output wire Qn
);
    (* keep = 1 *) wire s_n;
    (* keep = 1 *) wire r_n;

    assign s_n = ~(S & C);     // NAND = AND negada
    assign r_n = ~(R & C);
    assign Q   = ~(s_n & Qn);
    assign Qn  = ~(r_n & Q);
endmodule
