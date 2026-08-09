// Full 16-round DES datapath with final half swap.
module des_top(
  input  wire        clk,
  input  wire        rst_n,
  input  wire        load_key,
  input  wire [55:0] key56,
  input  wire [63:0] block_in,
  output wire [63:0] block_out
);
  wire [47:0] sk;
  wire [3:0]  rno;
  wire [63:0] ip_out, preout;
  wire [31:0] l0 = ip_out[63:32];
  wire [31:0] r0 = ip_out[31:0];
  wire [31:0] l1, r1, l2, r2, l3, r3, l4, r4, l5, r5, l6, r6, l7, r7, l8, r8;
  wire [31:0] l9, r9, l10, r10, l11, r11, l12, r12, l13, r13, l14, r14, l15, r15, l16, r16;

  des_key_schedule u_ks(clk, rst_n, load_key, key56, sk, rno);
  des_ip u_ip(block_in, ip_out);
  des_round_1  u_r1(l0, r0, sk, l1, r1);
  des_round_2  u_r2(l1, r1, sk, l2, r2);
  des_round_3  u_r3(l2, r2, sk, l3, r3);
  des_round_4  u_r4(l3, r3, sk, l4, r4);
  des_round_5  u_r5(l4, r4, sk, l5, r5);
  des_round_6  u_r6(l5, r5, sk, l6, r6);
  des_round_7  u_r7(l6, r6, sk, l7, r7);
  des_round_8  u_r8(l7, r7, sk, l8, r8);
  des_round_9  u_r9(l8, r8, sk, l9, r9);
  des_round_10 u_r10(l9, r9, sk, l10, r10);
  des_round_11 u_r11(l10, r10, sk, l11, r11);
  des_round_12 u_r12(l11, r11, sk, l12, r12);
  des_round_13 u_r13(l12, r12, sk, l13, r13);
  des_round_14 u_r14(l13, r13, sk, l14, r14);
  des_round_15 u_r15(l14, r14, sk, l15, r15);
  des_round_16 u_r16(l15, r15, sk, l16, r16);

  assign preout = {r16, l16};
  des_fp u_fp(preout, block_out);
endmodule
