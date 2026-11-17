// ============================================================
//  Latch SR con entrada de control C, compuertas NAND
//  Arquitectura ESTRUCTURAL: solo primitivas de Verilog
//  C = 1 -> el latch obedece a S y R    C = 0 -> memoria
// ============================================================
module latch_sr_nand_prim (
    input  wire S,      // set   (activo en alto)
    input  wire R,      // reset (activo en alto)
    input  wire C,      // control: viene del 555 (3 s)
    output wire Q,
    output wire Qn      // Q negada
);
    (* keep = 1 *) wire s_n;   // S y C pasados por la primera NAND
    (* keep = 1 *) wire r_n;   // R y C pasados por la segunda NAND

    nand g1 (s_n, S, C);       // etapa de control
    nand g2 (r_n, R, C);
    nand g3 (Q,  s_n, Qn);     // latch S'R' (dos NAND cruzadas)
    nand g4 (Qn, r_n, Q);
endmodule
