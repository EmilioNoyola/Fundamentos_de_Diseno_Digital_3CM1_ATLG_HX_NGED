// ============================================================
//  Latch SR con entrada de control C, compuertas NOR
//  Arquitectura de FLUJO DE DATOS: ecuaciones con assign
// ============================================================
module latch_sr_nor_asg (
    input  wire S,
    input  wire R,
    input  wire C,
    output wire Q,
    output wire Qn
);
    (* keep = 1 *) wire s_g;
    (* keep = 1 *) wire r_g;

    assign s_g = S & C;
    assign r_g = R & C;
    assign Q   = ~(r_g | Qn);  // NOR = OR negada
    assign Qn  = ~(s_g | Q);
endmodule
