`timescale 1ms/1ms

module tb_flipflops;
    reg  clk_555 = 0;
    reg  sw_sj = 0, sw_rk = 0, sw_dt = 0, sw_rst = 0;
    wire q_sr, qn_sr, q_d, qn_d, q_t, qn_t, q_jk, qn_jk, sdram_cs_n;

    ff_top_555 dut (
        .clk_555(clk_555),
        .sw_sj(sw_sj), .sw_rk(sw_rk), .sw_dt(sw_dt), .sw_rst(sw_rst),
        .q_sr(q_sr), .qn_sr(qn_sr),
        .q_d(q_d),   .qn_d(qn_d),
        .q_t(q_t),   .qn_t(qn_t),
        .q_jk(q_jk), .qn_jk(qn_jk),
        .sdram_cs_n(sdram_cs_n)
    );

    always #1500 clk_555 = ~clk_555;

    initial begin
        #400  sw_rst = 1;
        #800  sw_rst = 0;
        #1050 sw_sj = 1; sw_rk = 0; sw_dt = 1;
        #3000 sw_sj = 0; sw_rk = 0; sw_dt = 0;
        #3000 sw_sj = 0; sw_rk = 1; sw_dt = 1;
        #3000 sw_sj = 1; sw_rk = 1;
        #3000 sw_sj = 1; sw_rk = 1; sw_dt = 0;
        #3000 sw_sj = 1; sw_rk = 0;
        #3000 sw_rst = 1;
        #1500 sw_rst = 0;
    end
endmodule
