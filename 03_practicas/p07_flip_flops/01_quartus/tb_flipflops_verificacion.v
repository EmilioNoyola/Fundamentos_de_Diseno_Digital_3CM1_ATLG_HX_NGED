// ============================================================
//  Banco de pruebas de los cuatro flip-flops (practica 7)
//  La unidad de tiempo es 1 ms. CLK imita al reloj lento de 3 s:
//  1.5 s en 0 y 1.5 s en 1  ->  flancos de subida en 1.5, 4.5, 7.5 ... s
//                               flancos de bajada en 3, 6, 9 ... s
//  Las entradas cambian a la mitad de cada medio periodo (0.75 s
//  despues de cada flanco), lejos de los flancos, como al mover
//  el DIP a mano.
// ============================================================
`timescale 1ms/1ms
module tb_flipflops_verificacion;
    reg  SJ = 0, RK = 0, DT = 0, RST = 0, CLK = 0;
    wire Qsr, Qnsr, Qd, Qnd, Qt, Qnt, Qjk, Qnjk;

    sr_ffp u1 (.s(SJ), .r(RK), .reset(RST), .clk(CLK), .qsr(Qsr), .nqsr(Qnsr));
    d_ffp  u2 (.d(DT),         .reset(RST), .clk(CLK), .qd(Qd),   .nqd(Qnd));
    t_ffp  u3 (.t(DT),         .reset(RST), .clk(CLK), .qt(Qt),   .nqt(Qnt));
    jk_ffn u4 (.j(SJ), .k(RK), .reset(RST), .clk(CLK), .qjk(Qjk), .nqjk(Qnjk));

    always #1500 CLK = ~CLK;              // reloj de 3 s

    // ---- modelo de referencia: copia directa de las tablas ----
    reg [1:0] e_sr = 2'bxx, e_d = 2'bxx, e_t = 2'bxx, e_jk = 2'bxx;  // {Q, Q'}
    always @(posedge RST) begin e_sr = 2'b01; e_d = 2'b01; e_t = 2'b01; e_jk = 2'b01; end
    always @(posedge CLK) if (!RST) begin
        case ({SJ, RK})
            2'b00: e_sr = e_sr;          // memoria
            2'b01: e_sr = 2'b01;         // reset
            2'b10: e_sr = 2'b10;         // set
            2'b11: e_sr = 2'b00;         // prohibido: Q = Q' = 0
        endcase
        e_d = DT ? 2'b10 : 2'b01;
        if (DT) e_t = {e_t[0], e_t[1]};  // intercambia Q y Q'
    end
    always @(negedge CLK) if (!RST)
        case ({SJ, RK})
            2'b00: e_jk = e_jk;
            2'b01: e_jk = 2'b01;
            2'b10: e_jk = 2'b10;
            2'b11: e_jk = {e_jk[0], e_jk[1]};
        endcase

    integer errores = 0, revisiones = 0;
    task revisa;
        begin
            revisiones = revisiones + 1;
            if ({Qsr, Qnsr} !== e_sr || {Qd, Qnd} !== e_d ||
                {Qt, Qnt}   !== e_t  || {Qjk, Qnjk} !== e_jk) begin
                errores = errores + 1;
                $display("ERROR t=%t  SR=%b%b(esp %b)  D=%b%b(esp %b)  T=%b%b(esp %b)  JK=%b%b(esp %b)",
                         $time, Qsr, Qnsr, e_sr, Qd, Qnd, e_d, Qt, Qnt, e_t, Qjk, Qnjk, e_jk);
            end
        end
    endtask
    always @(CLK or RST or SJ or RK or DT) #1 revisa;   // 1 ms despues de cada cambio

    // ---- estimulos (S=J, R=K, D=T, reset) ----------------------
    initial begin
        $timeformat(-3, 0, " ms", 9);
        $dumpfile("flipflops.vcd");
        $dumpvars(0, tb_flipflops_verificacion);
        $monitor("%t  CLK=%b RST=%b S/J=%b R/K=%b D/T=%b | SR %b%b  D %b%b  T %b%b  JK %b%b",
                 $time, CLK, RST, SJ, RK, DT, Qsr, Qnsr, Qd, Qnd, Qt, Qnt, Qjk, Qnjk);
        #400   RST = 1;                       //  0.40 s  reset: todos Q = 0, Q' = 1
        #800   RST = 0;                       //  1.20 s
        #1050  SJ = 1; RK = 0; DT = 1;        //  2.25 s  sube 4.5: SR set, D=1, T cambia
                                              //          baja 3.0 (antes): JK set
        #3000  SJ = 0; RK = 0; DT = 0;        //  5.25 s  memoria en todos; D = 0
        #3000  SJ = 0; RK = 1; DT = 1;        //  8.25 s  SR reset, JK reset, D=1, T cambia
        #3000  SJ = 1; RK = 1;                // 11.25 s  SR prohibido (Q=Q'=0), JK cambia
        #3000  SJ = 1; RK = 1; DT = 0;        // 14.25 s  JK sigue cambiando; T se queda
        #3000  SJ = 1; RK = 0;                // 17.25 s  JK set (baja 18); SR sale de 00 a set (sube 19.5)
        #3000  RST = 1;                       // 20.25 s  reset con CLK = 1: borra al instante, sin flanco
        #1500  RST = 0;                       // 21.75 s  (el flanco de bajada de 21 s se ignoro)
        #3000;                                // 24.75 s  sube 22.5: SR set otra vez; baja 24: JK set
        $display("Revisiones: %0d   Errores: %0d", revisiones, errores);
        if (errores == 0) $display("PASA: los cuatro flip-flops cumplen sus tablas");
        #1000 $finish;   // 1 s de margen: Questa corre solo 25 s y no llega aqui (sin ventana de "finish")
    end
endmodule
