module sumador_completo (
    input  wire a,
    input  wire b,
    input  wire c_in,

    output wire led_sum_n,
    output wire led_cout_n
);

    wire sum;
    wire c_out;

    assign sum = a ^ b ^ c_in;

    assign c_out = (a & b) | (c_in & (a ^ b));

    assign led_sum_n  = ~sum;
    assign led_cout_n = ~c_out;

endmodule