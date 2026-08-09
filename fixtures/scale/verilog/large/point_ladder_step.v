// One differential-addition rung of the X25519 ladder.
module point_ladder_step(
  input  wire         clk,
  input  wire         rst_n,
  input  wire         start,
  input  wire [254:0] x2,
  input  wire [254:0] z2,
  input  wire [254:0] x3,
  output wire [254:0] x2_next,
  output wire [254:0] z2_next,
  output wire         done
);
  wire [254:0] a_sum, b_sum, sq;
  wire         mul_done;

  gf25519_add u_a(x2, z2, a_sum);
  gf25519_add u_b(x3, z2, b_sum);
  gf25519_mul u_sq(clk, rst_n, start, a_sum, b_sum, sq, mul_done);

  assign x2_next = sq;
  assign z2_next = a_sum;
  assign done    = mul_done;
endmodule
