// feature: module, parameter, input/output, assign, always
module adder #(parameter WIDTH = 8) (
    input  [WIDTH-1:0] a,
    input  [WIDTH-1:0] b,
    output [WIDTH:0]   sum
);
    assign sum = a + b;
endmodule

module bit_and (
    input  a,
    input  b,
    output y
);
    assign y = a & b;
endmodule
