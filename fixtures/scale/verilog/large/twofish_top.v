// Sixteen unrolled Twofish rounds.
module twofish_top(
  input  wire [63:0]  round_key,
  input  wire [127:0] block_in,
  output wire [127:0] block_out
);
  wire [63:0] l0 = block_in[127:64];
  wire [63:0] r0 = block_in[63:0];
  wire [63:0] l1, r1, l2, r2, l3, r3, l4, r4, l5, r5, l6, r6, l7, r7, l8, r8;
  wire [63:0] l9, r9, l10, r10, l11, r11, l12, r12, l13, r13, l14, r14, l15, r15, l16, r16;

  twofish_round_1  u_r1(l0, r0, round_key, l1, r1);
  twofish_round_2  u_r2(l1, r1, round_key, l2, r2);
  twofish_round_3  u_r3(l2, r2, round_key, l3, r3);
  twofish_round_4  u_r4(l3, r3, round_key, l4, r4);
  twofish_round_5  u_r5(l4, r4, round_key, l5, r5);
  twofish_round_6  u_r6(l5, r5, round_key, l6, r6);
  twofish_round_7  u_r7(l6, r6, round_key, l7, r7);
  twofish_round_8  u_r8(l7, r7, round_key, l8, r8);
  twofish_round_9  u_r9(l8, r8, round_key, l9, r9);
  twofish_round_10 u_r10(l9, r9, round_key, l10, r10);
  twofish_round_11 u_r11(l10, r10, round_key, l11, r11);
  twofish_round_12 u_r12(l11, r11, round_key, l12, r12);
  twofish_round_13 u_r13(l12, r12, round_key, l13, r13);
  twofish_round_14 u_r14(l13, r13, round_key, l14, r14);
  twofish_round_15 u_r15(l14, r14, round_key, l15, r15);
  twofish_round_16 u_r16(l15, r15, round_key, l16, r16);

  assign block_out = {r16, l16};
endmodule
