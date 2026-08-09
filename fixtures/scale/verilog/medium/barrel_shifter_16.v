module barrel_shifter_16(
  input  wire [15:0] a,
  input  wire [3:0]  amount,
  input  wire        dir_left,
  input  wire        arithmetic,
  output wire [15:0] result
);
  wire [15:0] left_out, right_out;

  shifter_left_16  u_left(a, amount, left_out);
  shifter_right_16 u_right(a, amount, arithmetic, right_out);

  assign result = dir_left ? left_out : right_out;
endmodule
