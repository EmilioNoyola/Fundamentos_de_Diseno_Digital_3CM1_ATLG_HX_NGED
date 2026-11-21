`timescale 1us/1us
module latch_sr_nand_prim (
    input  wire S,
    input  wire R,
    input  wire C,
    output wire Q,
    output wire Qn
);
    (* keep = 1 *) wire s_n;
    (* keep = 1 *) wire r_n;

    nand #1 g1 (s_n, S, C);
    nand #1 g2 (r_n, R, C);
    nand #1 g3 (Q,  s_n, Qn);
    nand #1 g4 (Qn, r_n, Q);
endmodule
