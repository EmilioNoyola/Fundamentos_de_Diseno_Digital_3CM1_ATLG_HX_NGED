module jk_ffn (
    input  wire j,
    input  wire k,
    input  wire reset,
    input  wire clk,
    output reg  qjk,
    output reg  nqjk
);
    always @(negedge clk or posedge reset)
        if (reset) begin
            qjk  <= 1'b0;
            nqjk <= 1'b1;
        end
        else
            case ({j, k})
                2'b00: begin qjk <= qjk;  nqjk <= nqjk;  end
                2'b01: begin qjk <= 1'b0; nqjk <= 1'b1;  end
                2'b10: begin qjk <= 1'b1; nqjk <= 1'b0;  end
                2'b11: begin qjk <= ~qjk; nqjk <= ~nqjk; end
            endcase
endmodule
