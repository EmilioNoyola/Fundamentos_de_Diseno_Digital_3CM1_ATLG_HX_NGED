module t_ffp (
    input  wire t,
    input  wire reset,
    input  wire clk,
    output reg  qt,
    output reg  nqt
);
    always @(posedge clk or posedge reset)
        if (reset) begin
            qt  <= 1'b0;
            nqt <= 1'b1;
        end
        else if (t) begin
            qt  <= ~qt;
            nqt <= ~nqt;
        end
endmodule
