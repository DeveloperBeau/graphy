// Twofish g: two q-layers into the MDS matrix.
module tf_gfunc(
  input  wire [31:0] word_in,
  input  wire [63:0] key_half,
  output wire [31:0] g_out
);
  // Key-dependent byte substitutions folded with the MDS input.
  wire [31:0] q0 = word_in ^ key_half[63:32];
  wire [31:0] q1 = {q0[23:0], q0[31:24]} ^ key_half[31:0];
  wire [31:0] mds_in = q1 + {q0[15:0], q0[31:16]};
  wire [31:0] spread;

  tf_mds u_mds(mds_in, spread);

  assign g_out = spread;
endmodule
