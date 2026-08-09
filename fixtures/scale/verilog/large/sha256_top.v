// Eight-stage pipelined SHA-256 compression with schedule feed.
module sha256_top(
  input  wire         clk,
  input  wire         rst_n,
  input  wire         load,
  input  wire [511:0] block_in,
  output wire [255:0] digest
);
  localparam [255:0] H0 = {32'h6a09e667, 32'hbb67ae85, 32'h3c6ef372,
                           32'ha54ff53a, 32'h510e527f, 32'h9b05688c,
                           32'h1f83d9ab, 32'h5be0cd19};
  wire [31:0]  w;
  wire [255:0] d1, d2, d3, d4, d5, d6, d7, d8;

  sha_msg_sched u_sched(clk, rst_n, load, block_in, w);
  sha256_stage_1 u_s1(H0, w, 32'h428a2f98, d1);
  sha256_stage_2 u_s2(d1, w, 32'h71374491, d2);
  sha256_stage_3 u_s3(d2, w, 32'hb5c0fbcf, d3);
  sha256_stage_4 u_s4(d3, w, 32'he9b5dba5, d4);
  sha256_stage_5 u_s5(d4, w, 32'h3956c25b, d5);
  sha256_stage_6 u_s6(d5, w, 32'h59f111f1, d6);
  sha256_stage_7 u_s7(d6, w, 32'h923f82a4, d7);
  sha256_stage_8 u_s8(d7, w, 32'hab1c5ed5, d8);

  // Davies-Meyer feed-forward closes the compression function.
  assign digest = d8 + H0;
endmodule
