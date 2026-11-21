// =====================================================================
//  tb_sumador_4bits.v  --  Banco de pruebas (testbench) EXHAUSTIVO
//  Prueba las 512 combinaciones (16 x 16 x 2) en:
//    - sumador_4bits_v1      (FPGA/CPLD, version 1)
//    - sumador_4bits_v2      (FPGA/CPLD, version 2)
//    - sumador_4bits_gal_v1  (SPLD, version 1)
//    - sumador_4bits_gal_v2  (SPLD, version 2)
//  y las compara contra la suma "de referencia" A + B + Cin.
//  El testbench NO se sintetiza: solo sirve para simular.
// =====================================================================
`timescale 1ns/1ps
module tb_sumador_4bits;
    reg  [3:0] A, B;
    reg        Cin;
    wire [3:0] S1v, S2v;
    wire       Co1, Co2;
    wire       g1S0, g1S1, g1S2, g1S3, g1C1, g1C2, g1C3, g1Co;
    wire       g2S0, g2S1, g2S2, g2S3, g2C1, g2C2, g2C3, g2Co;

    // Dispositivos bajo prueba (DUT)
    sumador_4bits_v1 dut1 (.A(A), .B(B), .Cin(Cin), .S(S1v), .Cout(Co1));
    sumador_4bits_v2 dut2 (.A(A), .B(B), .Cin(Cin), .S(S2v), .Cout(Co2));
    sumador_4bits_gal_v1 gal1 (.A0(A[0]),.B0(B[0]),.A1(A[1]),.B1(B[1]),.A2(A[2]),.B2(B[2]),
        .A3(A[3]),.B3(B[3]),.Cin(Cin),.S0(g1S0),.S1(g1S1),.S2(g1S2),.S3(g1S3),
        .C1(g1C1),.C2(g1C2),.C3(g1C3),.Cout(g1Co));
    sumador_4bits_gal_v2 gal2 (.A0(A[0]),.B0(B[0]),.A1(A[1]),.B1(B[1]),.A2(A[2]),.B2(B[2]),
        .A3(A[3]),.B3(B[3]),.Cin(Cin),.S0(g2S0),.S1(g2S1),.S2(g2S2),.S3(g2S3),
        .C1(g2C1),.C2(g2C2),.C3(g2C3),.Cout(g2Co));

    integer i, errores;
    reg [4:0] esperado;

    initial begin
        $dumpfile("sumador_4bits.vcd");   // archivo de formas de onda (GTKWave)
        $dumpvars(0, tb_sumador_4bits);
        errores = 0;
        $display("   A    +   B    + Cin =  v1(Cout S)  v2(Cout S)  esperado");
        for (i = 0; i < 512; i = i + 1) begin
            {Cin, B, A} = i[8:0];
            #10;                                   // espera a que se estabilice
            esperado = A + B + Cin;
            if ({Co1, S1v} !== esperado || {Co2, S2v} !== esperado ||
                {g1Co, g1S3, g1S2, g1S1, g1S0} !== esperado ||
                {g2Co, g2S3, g2S2, g2S1, g2S0} !== esperado) begin
                errores = errores + 1;
                $display("ERROR: A=%b B=%b Cin=%b -> v1=%b%b v2=%b%b esperado=%b",
                         A, B, Cin, Co1, S1v, Co2, S2v, esperado);
            end
            if (i % 37 == 0)   // muestra algunas lineas de ejemplo
                $display("  %b (%2d) + %b (%2d) +  %b  =  %b %b      %b %b     %b (%2d)",
                         A, A, B, B, Cin, Co1, S1v, Co2, S2v, esperado, esperado);
        end
        if (errores == 0)
            $display("\nPRUEBA SUPERADA: 512 de 512 combinaciones correctas en las 4 descripciones.");
        else
            $display("\nPRUEBA FALLIDA: %0d errores.", errores);
        $finish;
    end
endmodule
