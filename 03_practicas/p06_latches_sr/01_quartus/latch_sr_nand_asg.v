`timescale 1us/1us
module latch_sr_nand_asg (
    input  wire S,
    input  wire R,
    input  wire C,
    output wire Q,
    output wire Qn
);
    (* keep = 1 *) wire s_n;
    (* keep = 1 *) wire r_n;

    assign #1 s_n = ~(S & C);
    assign #1 r_n = ~(R & C);
    assign #1 Q   = ~(s_n & Qn);
    assign #1 Qn  = ~(r_n & Q);
endmodule
