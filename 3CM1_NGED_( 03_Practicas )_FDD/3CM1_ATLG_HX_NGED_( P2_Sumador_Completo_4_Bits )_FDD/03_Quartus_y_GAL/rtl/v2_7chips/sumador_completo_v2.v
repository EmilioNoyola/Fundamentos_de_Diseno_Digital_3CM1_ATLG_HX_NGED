// =====================================================================
//  sumador_completo_v2.v  --  VERSION 2 (7 chips: 3x74HC08, 2x74HC32, 2x74HC86)
//  Sumador completo de 1 bit en SUMA DE PRODUCTOS (mapas de Karnaugh).
//
//      S    = A xor B xor Cin              (XOR de 3 entradas = 2 XOR de 2)
//      Cout = A*B + A*Cin + B*Cin          (3 AND + OR de 3 = 3 AND + 2 OR)
//
//  Aqui el acarreo NO usa XOR: sale directo del mapa de Karnaugh
//  (funcion "mayoria"). Se escribe con compuertas de 2 entradas para que
//  el conteo coincida con los chips 74HC (4 compuertas por chip).
// =====================================================================
module sumador_completo_v2 (
    input  wire a,
    input  wire b,
    input  wire cin,
    output wire s,
    output wire cout
);
    wire ab, ac, bc;   // productos del mapa de Karnaugh
    wire o1;           // primera mitad del OR de 3 entradas
    wire x1;           // primera mitad del XOR de 3 entradas

    and U_AB (ab, a, b);       // 74HC08
    and U_AC (ac, a, cin);     // 74HC08
    and U_BC (bc, b, cin);     // 74HC08
    or  U_O1 (o1, ab, ac);     // 74HC32
    or  U_O2 (cout, o1, bc);   // 74HC32
    xor U_X1 (x1, a, b);       // 74HC86
    xor U_X2 (s,  x1, cin);    // 74HC86
endmodule
