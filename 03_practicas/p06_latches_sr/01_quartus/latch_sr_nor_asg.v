`timescale 1us/1us
module latch_sr_nor_asg (
    input  wire S,
    input  wire R,
    input  wire C,
    output wire Q,
    output wire Qn
);
    (* keep = 1 *) wire s_g;
    (* keep = 1 *) wire r_g;

    assign #1 s_g = S & C;
    assign #1 r_g = R & C;
    assign #1 Q   = ~(r_g | Qn);
    assign #1 Qn  = ~(s_g | Q);
endmodule
