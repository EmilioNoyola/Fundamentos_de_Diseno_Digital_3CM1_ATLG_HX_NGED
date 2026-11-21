// =============================================================================
//  led_demo.v  -  Prueba de LEDs para Sipeed Tang Nano 9K (GW1NR-LV9QN88PC6/I5)
// -----------------------------------------------------------------------------
//  4 animaciones; el botón S2 (pin 4) cambia de una a otra:
//    0) Auto fantástico (un LED rebota de lado a lado)
//    1) Contador binario de 6 bits
//    2) Llenar / vaciar la barra
//    3) Respiración alternada (PWM con corrección gamma)
//
//  Detalles de la placa:
//    - Reloj de 27 MHz en el pin 52
//    - Los 6 LEDs son ACTIVOS EN BAJO (0 = encendido) -> por eso se invierte
//    - Los botones son activos en bajo (presionado = 0)
// =============================================================================
`timescale 1ns/1ps

module led_demo #(
    parameter CLK_HZ    = 27_000_000,
    parameter STEP_HZ   = 10,     // velocidad de las animaciones (pasos/seg)
    parameter DEB_HZ    = 100,    // muestreo del botón (cada 10 ms) = antirrebote
    parameter BREATH_HZ = 256     // pasos de brillo por segundo (~2 s por ciclo)
)(
    input  wire       clk,        // 27 MHz
    input  wire       btn_n,      // botón S2, activo en bajo
    output wire [5:0] led         // LEDs, activos en bajo
);

    localparam STEP_DIV   = CLK_HZ / STEP_HZ;
    localparam DEB_DIV    = CLK_HZ / DEB_HZ;
    localparam BREATH_DIV = CLK_HZ / BREATH_HZ;

    // -------------------------------------------------------------------------
    // Generadores de "ticks": pulsos de 1 ciclo a frecuencias más lentas.
    // Todo el diseño corre con el mismo reloj (síncrono); los ticks solo
    // habilitan cuándo avanza cada cosa. Así evitamos crear relojes derivados.
    // -------------------------------------------------------------------------
    reg [31:0] step_cnt   = 0;
    reg [31:0] deb_cnt    = 0;
    reg [31:0] breath_cnt = 0;

    wire step_tick   = (step_cnt   == STEP_DIV   - 1);
    wire deb_tick    = (deb_cnt    == DEB_DIV    - 1);
    wire breath_tick = (breath_cnt == BREATH_DIV - 1);

    always @(posedge clk) begin
        step_cnt   <= step_tick   ? 32'd0 : step_cnt   + 32'd1;
        deb_cnt    <= deb_tick    ? 32'd0 : deb_cnt    + 32'd1;
        breath_cnt <= breath_tick ? 32'd0 : breath_cnt + 32'd1;
    end

    // -------------------------------------------------------------------------
    // Botón: sincronizador de 2 flip-flops (evita metaestabilidad, porque el
    // botón es asíncrono al reloj) + antirrebote por muestreo cada 10 ms.
    // -------------------------------------------------------------------------
    reg [1:0] btn_sync  = 2'b11;
    reg       btn_state = 1'b1;
    reg       btn_prev  = 1'b1;

    always @(posedge clk) begin
        btn_sync <= {btn_sync[0], btn_n};
        if (deb_tick)
            btn_state <= btn_sync[1];
        btn_prev <= btn_state;
    end

    wire btn_press = btn_prev & ~btn_state;   // flanco de bajada = se presionó

    // -------------------------------------------------------------------------
    // Selector de modo
    // -------------------------------------------------------------------------
    reg [1:0] mode = 2'd0;
    always @(posedge clk)
        if (btn_press)
            mode <= mode + 2'd1;

    // -------------------------------------------------------------------------
    // Modo 0: auto fantástico
    // -------------------------------------------------------------------------
    reg [2:0] pos = 3'd0;
    reg       dir = 1'b0;   // 0 = hacia arriba, 1 = hacia abajo

    always @(posedge clk) begin
        if (step_tick) begin
            if (!dir) begin
                if (pos == 3'd5) begin dir <= 1'b1; pos <= 3'd4; end
                else                 pos <= pos + 3'd1;
            end else begin
                if (pos == 3'd0) begin dir <= 1'b0; pos <= 3'd1; end
                else                 pos <= pos - 3'd1;
            end
        end
    end

    wire [5:0] kitt_pat = 6'b000001 << pos;

    // -------------------------------------------------------------------------
    // Modo 1: contador binario
    // -------------------------------------------------------------------------
    reg [5:0] bin_cnt = 6'd0;
    always @(posedge clk)
        if (step_tick)
            bin_cnt <= bin_cnt + 6'd1;

    // -------------------------------------------------------------------------
    // Modo 2: llenar (0..6) y luego vaciar (7..11)
    // -------------------------------------------------------------------------
    reg [3:0] fill = 4'd0;
    always @(posedge clk)
        if (step_tick)
            fill <= (fill == 4'd11) ? 4'd0 : fill + 4'd1;

    wire [6:0] ones     = (7'd1 << fill) - 7'd1;               // fill unos abajo
    wire [5:0] fill_pat = (fill <= 4'd6) ? ones[5:0]
                                         : (6'b111111 << (fill - 4'd6));

    // -------------------------------------------------------------------------
    // Modo 3: respiración (PWM)
    //   duty sube 0->255 y baja 255->0 (onda triangular).
    //   gamma = duty^2 / 256 porque el ojo percibe el brillo de forma no lineal.
    //   PWM: contador de 8 bits a 27 MHz -> ~105 kHz, no se nota parpadeo.
    // -------------------------------------------------------------------------
    reg [7:0] pwm  = 8'd0;
    reg [7:0] duty = 8'd0;
    reg       up   = 1'b1;

    always @(posedge clk) begin
        pwm <= pwm + 8'd1;
        if (breath_tick) begin
            if (up) begin
                if (duty == 8'd255) up <= 1'b0; else duty <= duty + 8'd1;
            end else begin
                if (duty == 8'd0)   up <= 1'b1; else duty <= duty - 8'd1;
            end
        end
    end

    wire [15:0] sq       = duty * duty;
    wire [7:0]  gamma_a  = sq[15:8];
    wire [7:0]  gamma_b  = 8'd255 - gamma_a;      // fase opuesta
    wire        on_a     = (pwm < gamma_a);
    wire        on_b     = (pwm < gamma_b);
    wire [5:0]  breath_pat = {on_b, on_a, on_b, on_a, on_b, on_a};

    // -------------------------------------------------------------------------
    // Multiplexor de salida (lógica positiva: 1 = encendido)
    // -------------------------------------------------------------------------
    reg [5:0] pattern;
    always @(*) begin
        case (mode)
            2'd0:    pattern = kitt_pat;
            2'd1:    pattern = bin_cnt;
            2'd2:    pattern = fill_pat;
            default: pattern = breath_pat;
        endcase
    end

    // LEDs activos en bajo -> invertimos
    assign led = ~pattern;

endmodule