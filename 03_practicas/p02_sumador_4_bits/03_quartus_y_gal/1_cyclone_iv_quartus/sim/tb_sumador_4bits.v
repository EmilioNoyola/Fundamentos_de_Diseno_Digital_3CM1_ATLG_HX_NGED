// ============================================================================
//  tb_sumador_4bits.v  -  Banco de pruebas (testbench)
//  Prueba las 512 combinaciones posibles (16 x 16 x 2) y compara el
//  resultado del circuito contra la suma aritmética A + B + Cin.
//  Funciona en ModelSim/Questa (incluido con Quartus) y en Icarus Verilog.
//  NO se sintetiza: solo sirve para simular.
// ============================================================================
`timescale 1ns / 1ps
module tb_sumador_4bits;
    reg  [3:0] A, B;
    reg        Cin;
    wire [3:0] S;
    wire       Cout;
    integer i, j, k, errores;

    // Dispositivo bajo prueba (DUT)
    sumador_4bits dut (.A(A), .B(B), .Cin(Cin), .S(S), .Cout(Cout));

    initial begin
        $dumpfile("sumador_4bits.vcd");     // formas de onda para GTKWave
        $dumpvars(0, tb_sumador_4bits);
        errores = 0;
        $display("   A      B    Cin |  Cout  S     | decimal      | estado");
        $display("  ----------------------------------------------------------");
        for (k = 0; k < 2; k = k + 1)
            for (i = 0; i < 16; i = i + 1)
                for (j = 0; j < 16; j = j + 1) begin
                    A = i; B = j; Cin = k;
                    #10;                                   // esperar a que se estabilice
                    if ({Cout, S} !== A + B + Cin) begin
                        errores = errores + 1;
                        $display("  %b + %b + %b | %b  %b | %2d+%2d+%0d = %2d | ERROR",
                                 A, B, Cin, Cout, S, A, B, Cin, {Cout, S});
                    end else if (j == i || (i == 15 && j == 1))  // muestra algunos casos
                        $display("  %b + %b + %b |  %b  %b  | %2d+%2d+%0d = %2d | ok",
                                 A, B, Cin, Cout, S, A, B, Cin, {Cout, S});
                end
        $display("  ----------------------------------------------------------");
        if (errores == 0) $display("  PRUEBA SUPERADA: 512 combinaciones correctas.");
        else              $display("  PRUEBA FALLIDA: %0d errores.", errores);
        $finish;
    end
endmodule
