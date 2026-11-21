`timescale 1ms/1ms
module tb_latches;
    reg  S = 0, R = 0, C = 0;
    wire Q1, Qn1, Q2, Qn2, Q3, Qn3, Q4, Qn4;

    latch_sr_nand_prim u1 (.S(S), .R(R), .C(C), .Q(Q1), .Qn(Qn1));
    latch_sr_nand_asg  u2 (.S(S), .R(R), .C(C), .Q(Q2), .Qn(Qn2));
    latch_sr_nor_prim  u3 (.S(S), .R(R), .C(C), .Q(Q3), .Qn(Qn3));
    latch_sr_nor_asg   u4 (.S(S), .R(R), .C(C), .Q(Q4), .Qn(Qn4));

    always begin
        #1247 C = 1;
        #1719 C = 0;
    end

    initial begin
              R = 1;
        #1600 R = 0;
        #600  S = 1;
        #400  S = 0;
        #800  R = 1;
        #1400 R = 0;
        #1600 S = 1;
        #1200 S = 0;
        #300  R = 1;
        #300  R = 0;
        #300  S = 1;
        #200  S = 0;
        #800  R = 1;
        #1100 S = 1;
        #1600 S = 0; R = 0;
        #300  $finish;
    end
endmodule
