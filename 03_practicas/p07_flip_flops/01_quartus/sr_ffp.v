module sr_ffp (
    input  wire s,
    input  wire r,
    input  wire reset,
    input  wire clk,
    output reg  qsr,
    output reg  nqsr
);
    always @(posedge clk or posedge reset)
        if (reset) begin
            qsr  <= 1'b0;
            nqsr <= 1'b1;
        end
        else begin
            qsr  <= ~r & (s | qsr);
            nqsr <= ~s & (r | nqsr);
        end
endmodule
