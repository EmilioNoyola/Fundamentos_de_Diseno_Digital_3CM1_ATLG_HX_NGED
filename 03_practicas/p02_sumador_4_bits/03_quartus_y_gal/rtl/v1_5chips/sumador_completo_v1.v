// =====================================================================
//  sumador_completo_v1.v  --  VERSION 1 (5 chips: 2x74HC86, 2x74HC08, 1x74HC32)
//  Sumador completo de 1 bit con PROPAGACION (P) y GENERACION (G).
//
//      P    = A xor B          -> compuerta XOR  (74HC86)
//      G    = A and B          -> compuerta AND  (74HC08)
//      S    = P xor Cin        -> compuerta XOR  (74HC86)
//      Cout = G or (P and Cin) -> AND (74HC08) + OR (74HC32)
//
//  La XOR "P" se reutiliza para la suma Y para el acarreo:
//  por eso esta version usa menos compuertas (y menos chips).
// =====================================================================
module sumador_completo_v1 (
    input  wire a,      // bit del primer numero
    input  wire b,      // bit del segundo numero
    input  wire cin,    // acarreo que llega de la etapa anterior
    output wire s,      // bit de suma
    output wire cout    // acarreo que sale hacia la siguiente etapa
);
    wire p;    // propagacion  (A xor B)
    wire g;    // generacion   (A and B)
    wire pc;   // P and Cin

    // primitiva (salida, entrada1, entrada2)
    xor U_P  (p,    a, b);     // 74HC86
    and U_G  (g,    a, b);     // 74HC08
    and U_PC (pc,   p, cin);   // 74HC08
    xor U_S  (s,    p, cin);   // 74HC86
    or  U_CO (cout, g, pc);    // 74HC32
endmodule
