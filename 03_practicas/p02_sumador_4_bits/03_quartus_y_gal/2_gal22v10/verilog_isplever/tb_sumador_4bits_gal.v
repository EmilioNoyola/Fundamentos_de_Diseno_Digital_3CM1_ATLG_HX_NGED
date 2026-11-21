// Banco de pruebas para sumador_4bits_gal.v (512 combinaciones). No se sintetiza.
`timescale 1ns / 1ps
module tb_sumador_4bits_gal;
    reg  [3:0] A, B;
    reg        Cin;
    wire S0, S1, S2, S3, C0, C1, C2, Cout;
    integer n, errores;

    sumador_4bits_gal dut (.A0(A[0]), .A1(A[1]), .A2(A[2]), .A3(A[3]),
                           .B0(B[0]), .B1(B[1]), .B2(B[2]), .B3(B[3]), .Cin(Cin),
                           .S0(S0), .S1(S1), .S2(S2), .S3(S3),
                           .C0(C0), .C1(C1), .C2(C2), .Cout(Cout));
    initial begin
        errores = 0;
        for (n = 0; n < 512; n = n + 1) begin
            {Cin, A, B} = n;
            #10;
            if ({Cout, S3, S2, S1, S0} !== A + B + Cin) begin
                errores = errores + 1;
                $display("ERROR: %b + %b + %b -> %b%b%b%b%b", A, B, Cin, Cout, S3, S2, S1, S0);
            end
        end
        if (errores == 0) $display("PRUEBA SUPERADA: 512 combinaciones correctas.");
        else              $display("PRUEBA FALLIDA: %0d errores.", errores);
        $finish;
    end
endmodule
