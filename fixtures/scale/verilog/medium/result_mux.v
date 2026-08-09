module result_mux(
  input  wire [3:0]  alu_op,
  input  wire [15:0] add_result,
  input  wire [15:0] sub_result,
  input  wire [31:0] mul_result,
  input  wire [15:0] div_result,
  input  wire [15:0] shift_result,
  input  wire [15:0] cmp_result,
  output reg  [15:0] selected
);
  always @(*) begin
    case (alu_op)
      4'd0: selected = add_result;
      4'd1: selected = sub_result;
      4'd2: selected = mul_result[15:0];
      4'd3: selected = div_result;
      4'd4: selected = shift_result;
      4'd5: selected = cmp_result;
      default: selected = 16'd0;
    endcase
  end
endmodule
