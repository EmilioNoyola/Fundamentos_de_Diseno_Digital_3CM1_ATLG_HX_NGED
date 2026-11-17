// ============================================================
//  Banco de pruebas de los cuatro latches
//  La unidad de tiempo es 1 ms: C imita al 555 de la practica 5
//  (1.719 s en alto y 1.247 s en bajo, T = 2.966 s)
// ============================================================
`timescale 1ms/1ms
module tb_latches;
    reg  S = 0, R = 0, C = 0;
    wire Q1, Qn1, Q2, Qn2, Q3, Qn3, Q4, Qn4;

    latch_sr_nand_prim u1 (.S(S), .R(R), .C(C), .Q(Q1), .Qn(Qn1));
    latch_sr_nand_asg  u2 (.S(S), .R(R), .C(C), .Q(Q2), .Qn(Qn2));
    latch_sr_nor_prim  u3 (.S(S), .R(R), .C(C), .Q(Q3), .Qn(Qn3));
    latch_sr_nor_asg   u4 (.S(S), .R(R), .C(C), .Q(Q4), .Qn(Qn4));

    // ---- la senal C: astable de 3 s --------------------------
    always begin
        #1247 C = 1;      // tiempo en bajo
        #1719 C = 0;      // tiempo en alto
    end

    // ---- modelo de referencia: lo que dice la tabla ----------
    reg esperado = 1'bx;               // al encender nadie sabe que guarda
    always @(*) if (C) begin
        if (S & ~R) esperado = 1;      // set
        if (R & ~S) esperado = 0;      // reset
    end

    integer errores = 0, revisiones = 0;
    task revisa;
        begin
            if (!(S & R & C) && esperado !== 1'bx) begin
                revisiones = revisiones + 1;
                if ({Q1,Q2,Q3,Q4} !== {4{esperado}} ||
                    {Qn1,Qn2,Qn3,Qn4} !== {4{~esperado}}) begin
                    errores = errores + 1;
                    $display("ERROR t=%t C=%b S=%b R=%b  Q=%b%b%b%b  Qn=%b%b%b%b  esperado=%b",
                             $time, C, S, R, Q1,Q2,Q3,Q4, Qn1,Qn2,Qn3,Qn4, esperado);
                end
            end
        end
    endtask
    always @(S or R or C) #1 revisa;   // 1 ms despues de cada cambio

    // ---- estimulos: C sube en 1.247, 4.213, 7.179 y 10.145 s -
    //                 y baja en 2.966, 5.932, 8.898 y 11.864 s
    initial begin
        $timeformat(-3, 0, " ms", 8);   // %t en milisegundos (Icarus y Questa)
        $dumpfile("latches.vcd");
        $dumpvars(0, tb_latches);
        $monitor("%t  C=%b S=%b R=%b | Q: %b %b %b %b | Q': %b %b %b %b",
                 $time, C, S, R, Q1, Q2, Q3, Q4, Qn1, Qn2, Qn3, Qn4);
                    R = 1;        //  0.0 s  reset pedido con C = 0: aun no pasa nada
        #1600       R = 0;        //  1.6 s  (C subio en 1.247 s y borro) memoria
        #600  S = 1;              //  2.2 s  set con C = 1: Q sube al instante
        #400  S = 0;              //  2.6 s  memoria: Q se queda en 1
        #800        R = 1;        //  3.4 s  reset con C = 0: se ignora...
        #1400       R = 0;        //  4.8 s  ...hasta que C sube en 4.213 s
        #1600 S = 1;              //  6.4 s  set con C = 0: espera a C (7.179 s)
        #1200 S = 0;              //  7.6 s  memoria en 1
        #300        R = 1;        //  7.9 s  con C = 1 el latch es transparente:
        #300        R = 0;        //  8.2 s     Q sigue a S y R
        #300  S = 1;              //  8.5 s
        #200  S = 0;              //  8.7 s
        #800  S = 1; R = 1;       //  9.5 s  S = R = 1 con C = 0: nada
        #1100       R = 0;        // 10.6 s  (prohibido desde 10.145 s) sale a set
        #400  S = 0;              // 11.0 s
        #1500;                    // 12.5 s
        $display("Revisiones: %0d   Errores: %0d", revisiones, errores);
        if (errores == 0) $display("PASA: los cuatro latches cumplen la tabla");
        $finish;
    end
endmodule
