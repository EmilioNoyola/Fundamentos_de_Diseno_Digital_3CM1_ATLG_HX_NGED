// ============================================================
//  Practica 6 - Latches SR con entrada de control
//  Modulo superior para la tarjeta Cyclone IV (RZ301)
//
//  Entradas (todas desde la protoboard, por el conector P2)
//    sw_s, sw_r : switches 1 y 2 de un DIP en la protoboard.
//                 ON = 3.3 V = 1; OFF = 0 por la resistencia
//                 de 10 k a tierra (pull-down)
//    c_555      : salida del 555 astable de 3 s, ya bajada
//                 a ~3.4 V con el divisor de resistencias
//  Salidas
//    8 LEDs en la protoboard: Q y Q' de los cuatro latches
//  No se usa ningun componente de la tarjeta (ni DIP ni LEDs).
// ============================================================
module latches_top (
    input  wire sw_s,
    input  wire sw_r,
    input  wire c_555,
    output wire q_nand_prim,  output wire qn_nand_prim,
    output wire q_nand_asg,   output wire qn_nand_asg,
    output wire q_nor_prim,   output wire qn_nor_prim,
    output wire q_nor_asg,    output wire qn_nor_asg
);
    wire S = sw_s;                  // switch en ON  ->  S = 1
    wire R = sw_r;
    wire C = c_555;

    latch_sr_nand_prim u1 (.S(S), .R(R), .C(C), .Q(q_nand_prim), .Qn(qn_nand_prim));
    latch_sr_nand_asg  u2 (.S(S), .R(R), .C(C), .Q(q_nand_asg),  .Qn(qn_nand_asg));
    latch_sr_nor_prim  u3 (.S(S), .R(R), .C(C), .Q(q_nor_prim),  .Qn(qn_nor_prim));
    latch_sr_nor_asg   u4 (.S(S), .R(R), .C(C), .Q(q_nor_asg),   .Qn(qn_nor_asg));
endmodule
