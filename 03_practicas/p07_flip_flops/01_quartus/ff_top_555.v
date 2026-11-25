module ff_top_555 (
    input  wire clk_555,
    input  wire sw_sj, sw_rk, sw_dt, sw_rst,
    output wire q_sr, qn_sr,
    output wire q_d,  qn_d,
    output wire q_t,  qn_t,
    output wire q_jk, qn_jk,
    output wire sdram_cs_n
);
    assign sdram_cs_n = 1'b1;

    sr_ffp u1 (.s(sw_sj), .r(sw_rk), .reset(sw_rst), .clk(clk_555), .qsr(q_sr), .nqsr(qn_sr));
    d_ffp  u2 (.d(sw_dt),            .reset(sw_rst), .clk(clk_555), .qd(q_d),   .nqd(qn_d));
    t_ffp  u3 (.t(sw_dt),            .reset(sw_rst), .clk(clk_555), .qt(q_t),   .nqt(qn_t));
    jk_ffn u4 (.j(sw_sj), .k(sw_rk), .reset(sw_rst), .clk(clk_555), .qjk(q_jk), .nqjk(qn_jk));
endmodule
