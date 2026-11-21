module restador4bits (
    input  wire [3:0] a,
    input  wire [3:0] b,

    output wire [3:0] diff,
    output wire       b_out
);

    wire b1;
    wire b2;
    wire b3;

    assign diff[0] = a[0] ^ b[0];

    assign b1 = (~a[0] & b[0]);


    assign diff[1] = a[1] ^ b[1] ^ b1;

    assign b2 = (~a[1] & b[1]) | (~a[1] & b1) | ( b[1] & b1);


    assign diff[2] = a[2] ^ b[2] ^ b2;

    assign b3 = (~a[2] & b[2]) | (~a[2] & b2) | ( b[2] & b2);


    assign diff[3] = a[3] ^ b[3] ^ b3;

    assign b_out = (~a[3] & b[3]) | (~a[3] & b3) | ( b[3] & b3);

endmodule