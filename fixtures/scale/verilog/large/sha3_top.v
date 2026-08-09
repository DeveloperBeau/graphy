// SHA3-256 sponge permutation, fully unrolled.
module sha3_top(
  input  wire [1087:0] rate_in,
  input  wire [511:0]  capacity_in,
  output wire [255:0]  digest
);
  wire [1599:0] s0 = {capacity_in, rate_in};
  wire [1599:0] r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12;
  wire [1599:0] r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24;

  keccak_round_1  u_k1(s0, r1);
  keccak_round_2  u_k2(r1, r2);
  keccak_round_3  u_k3(r2, r3);
  keccak_round_4  u_k4(r3, r4);
  keccak_round_5  u_k5(r4, r5);
  keccak_round_6  u_k6(r5, r6);
  keccak_round_7  u_k7(r6, r7);
  keccak_round_8  u_k8(r7, r8);
  keccak_round_9  u_k9(r8, r9);
  keccak_round_10 u_k10(r9, r10);
  keccak_round_11 u_k11(r10, r11);
  keccak_round_12 u_k12(r11, r12);
  keccak_round_13 u_k13(r12, r13);
  keccak_round_14 u_k14(r13, r14);
  keccak_round_15 u_k15(r14, r15);
  keccak_round_16 u_k16(r15, r16);
  keccak_round_17 u_k17(r16, r17);
  keccak_round_18 u_k18(r17, r18);
  keccak_round_19 u_k19(r18, r19);
  keccak_round_20 u_k20(r19, r20);
  keccak_round_21 u_k21(r20, r21);
  keccak_round_22 u_k22(r21, r22);
  keccak_round_23 u_k23(r22, r23);
  keccak_round_24 u_k24(r23, r24);

  assign digest = r24[255:0];
endmodule
