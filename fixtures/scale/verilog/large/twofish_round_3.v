// Twofish round 3 of 16.
module twofish_round_3(
  input  wire [63:0] left_in,
  input  wire [63:0] right_in,
  input  wire [63:0] round_key,
  output wire [63:0] left_out,
  output wire [63:0] right_out
);
  localparam ROUND = 3;
  wire [31:0] rotated_in = {left_in[23:0], left_in[31:24]};
  wire [31:0] g0, g1, p0, p1;
  wire [31:0] right_hi, right_lo;

  tf_gfunc u_g0(left_in[63:32], round_key, g0);
  tf_gfunc u_g1(rotated_in, round_key, g1);
  tf_pht   u_pht(g0, g1, p0, p1);

  assign right_hi = right_in[63:32] ^ p0;
  assign right_lo = {right_in[0], right_in[31:1]} ^ p1;

  assign right_out = left_in;
  assign left_out  = {right_hi, right_lo};
endmodule
