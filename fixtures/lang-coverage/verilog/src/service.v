// feature: module, parameter, input/output, always block, function, module instantiation
`include "helpers.v"

module counter #(parameter WIDTH = 4) (
    input              clk,
    input              reset,
    output reg [WIDTH-1:0] count
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            count <= 0;
        else
            count <= count + 1;
    end

    function automatic [WIDTH-1:0] next_val;
        input [WIDTH-1:0] current;
        next_val = current + 1;
    endfunction
endmodule

module top (
    input  clk,
    input  reset,
    output [3:0] out_count,
    output [8:0] out_sum
);
    wire [7:0] add_a;
    wire [7:0] add_b;
    assign add_a = 8'd10;
    assign add_b = 8'd20;

    counter #(.WIDTH(4)) my_counter (
        .clk(clk),
        .reset(reset),
        .count(out_count)
    );

    adder #(.WIDTH(8)) my_adder (
        .a(add_a),
        .b(add_b),
        .sum(out_sum)
    );
endmodule
