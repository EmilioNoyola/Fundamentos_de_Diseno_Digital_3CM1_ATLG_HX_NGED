`timescale 1us/1us
module latch_sr_nor_prim (
    input  wire S,
    input  wire R,
    input  wire C,
    output wire Q,
    output wire Qn
);
    (* keep = 1 *) wire s_g;
    (* keep = 1 *) wire r_g;

    and #1 g1 (s_g, S, C);
    and #1 g2 (r_g, R, C);
    nor #1 g3 (Q,  r_g, Qn);
    nor #1 g4 (Qn, s_g, Q);
endmodule
