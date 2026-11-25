module d_ffp (
    input  wire d,
    input  wire reset,
    input  wire clk,
    output reg  qd,
    output reg  nqd
);
    always @(posedge clk or posedge reset)
        if (reset) begin
            qd  <= 1'b0;
            nqd <= 1'b1;
        end
        else begin
            qd  <= d;
            nqd <= ~d;
        end
endmodule
