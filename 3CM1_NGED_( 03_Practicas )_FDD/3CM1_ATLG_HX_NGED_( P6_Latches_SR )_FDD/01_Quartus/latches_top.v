module latches_top (
    input  wire sw_s,
    input  wire sw_r,
    input  wire c_555,
    output wire q_nand_prim,  output wire qn_nand_prim,
    output wire q_nand_asg,   output wire qn_nand_asg,
    output wire q_nor_prim,   output wire qn_nor_prim,
    output wire q_nor_asg,    output wire qn_nor_asg
);
    wire S = sw_s;
    wire R = sw_r;
    wire C = c_555;

    latch_sr_nand_prim u1 (.S(S), .R(R), .C(C), .Q(q_nand_prim), .Qn(qn_nand_prim));
    latch_sr_nand_asg  u2 (.S(S), .R(R), .C(C), .Q(q_nand_asg),  .Qn(qn_nand_asg));
    latch_sr_nor_prim  u3 (.S(S), .R(R), .C(C), .Q(q_nor_prim),  .Qn(qn_nor_prim));
    latch_sr_nor_asg   u4 (.S(S), .R(R), .C(C), .Q(q_nor_asg),   .Qn(qn_nor_asg));
endmodule
