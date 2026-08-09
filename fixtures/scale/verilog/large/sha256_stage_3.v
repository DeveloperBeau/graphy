// SHA-256 compression stage 3 of 8 (eight rounds each when pipelined).
module sha256_stage_3(
  input  wire [255:0] digest_in,
  input  wire [31:0]  w,
  input  wire [31:0]  k,
  output wire [255:0] digest_out
);
  localparam STAGE = 3;
  wire [31:0] a = digest_in[255:224], b = digest_in[223:192];
  wire [31:0] c = digest_in[191:160], d = digest_in[159:128];
  wire [31:0] e = digest_in[127:96], f = digest_in[95:64];
  wire [31:0] g = digest_in[63:32], h = digest_in[31:0];
  wire [31:0] ch_out, maj_out, bs0_out, bs1_out;

  sha_ch   u_ch(e, f, g, ch_out);
  sha_maj  u_maj(a, b, c, maj_out);
  sha_bsig0 u_b0(a, bs0_out);
  sha_bsig1 u_b1(e, bs1_out);

  wire [31:0] t1 = h + bs1_out + ch_out + k + w;
  wire [31:0] t2 = bs0_out + maj_out;

  assign digest_out = {t1 + t2, a, b, c, d + t1, e, f, g};
endmodule
