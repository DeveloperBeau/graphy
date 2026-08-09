// Unrolled AES-128 encrypt pipeline, one block per cycle at full fill.
module aes_top(
  input  wire         clk,
  input  wire         rst_n,
  input  wire         load_key,
  input  wire [127:0] cipher_key,
  input  wire [127:0] block_in,
  output wire [127:0] block_out
);
  wire [127:0] rk;
  wire [3:0]   rk_idx;
  wire [127:0] s0, s1, s2, s3, s4, s5, s6, s7, s8, s9;

  aes_key_expand u_ks(clk, rst_n, load_key, cipher_key, rk, rk_idx);
  add_round_key  u_init(block_in, cipher_key, s0);

  aes_enc_round_1  u_r1(s0, rk, s1);
  aes_enc_round_2  u_r2(s1, rk, s2);
  aes_enc_round_3  u_r3(s2, rk, s3);
  aes_enc_round_4  u_r4(s3, rk, s4);
  aes_enc_round_5  u_r5(s4, rk, s5);
  aes_enc_round_6  u_r6(s5, rk, s6);
  aes_enc_round_7  u_r7(s6, rk, s7);
  aes_enc_round_8  u_r8(s7, rk, s8);
  aes_enc_round_9  u_r9(s8, rk, s9);
  aes_enc_round_10 u_r10(s9, rk, block_out);
endmodule
