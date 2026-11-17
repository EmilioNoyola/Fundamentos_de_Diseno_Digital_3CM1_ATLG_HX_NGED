// ============================================================
//  Latch SR con entrada de control C, compuertas NOR
//  Arquitectura ESTRUCTURAL: solo primitivas de Verilog
//  Las AND dejan pasar S y R solo mientras C = 1
// ============================================================
module latch_sr_nor_prim (
    input  wire S,
    input  wire R,
    input  wire C,
    output wire Q,
    output wire Qn
);
    (* keep = 1 *) wire s_g;   // S habilitada por C
    (* keep = 1 *) wire r_g;   // R habilitada por C

    and g1 (s_g, S, C);        // etapa de control
    and g2 (r_g, R, C);
    nor g3 (Q,  r_g, Qn);      // latch SR (dos NOR cruzadas)
    nor g4 (Qn, s_g, Q);
endmodule
