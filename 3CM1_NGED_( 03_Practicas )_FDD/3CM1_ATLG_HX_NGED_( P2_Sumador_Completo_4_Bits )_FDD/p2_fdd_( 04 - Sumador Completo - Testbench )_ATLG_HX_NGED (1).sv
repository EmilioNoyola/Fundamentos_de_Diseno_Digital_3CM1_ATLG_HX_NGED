'timescale 1ns/1ps
$dumpfile("dump.vcd");
$dumpvars(0, tb_sumador_completo);
module tb_sumador_completo;   //Como un laboratorio virtual o protoboard

    reg a, b, c_in;           //"reg" permite cambiar los valores durante la simulación
    wire sum, c_out;          //"wire" es el cable de salida

    sumador_completo dut (    //dut (device under test) conecta la prueba con 
        .a(a),                  nuestro modulo, el codigo de la tang nano 
        .b(b),
        .c_in(c_in),
        .sum(sum),
        .c_out(c_out)

    );

    integer i;

    initial begin 
        $display (" A B Cin | Sum Cout");
        $display("-----------------------");

        for(i=0;i<8;i=i+1) begin                //Este for prueba las 8 combinaciones posibles
            {a, b, c_in}=i;                     //Concatena las tres entradas en un vector y 
            #10;                                  cada valor de i se asigna en binario, un digito
            $display(" %b %b %b | %b %b",         para cada entrada
                    a, b, c_in, sum, c_out");
        end

        $finish;
    end

endmodule