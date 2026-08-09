// Sixteen unrolled Blowfish rounds with final swap.
module blowfish_top(
  input  wire        clk,
  input  wire        rst_n,
  input  wire        load_key,
  input  wire [447:0] key_material,
  input  wire [63:0] block_in,
  output wire [63:0] block_out
);
  wire [31:0] pe;
  wire [4:0]  pi;
  wire [31:0] l0 = block_in[63:32];
  wire [31:0] r0 = block_in[31:0];
  wire [31:0] l1, r1, l2, r2, l3, r3, l4, r4, l5, r5, l6, r6, l7, r7, l8, r8;
  wire [31:0] l9, r9, l10, r10, l11, r11, l12, r12, l13, r13, l14, r14, l15, r15, l16, r16;

  bf_key_sched u_ks(clk, rst_n, load_key, key_material, pe, pi);
  blowfish_round_1  u_r1(l0, r0, pe, l1, r1);
  blowfish_round_2  u_r2(l1, r1, pe, l2, r2);
  blowfish_round_3  u_r3(l2, r2, pe, l3, r3);
  blowfish_round_4  u_r4(l3, r3, pe, l4, r4);
  blowfish_round_5  u_r5(l4, r4, pe, l5, r5);
  blowfish_round_6  u_r6(l5, r5, pe, l6, r6);
  blowfish_round_7  u_r7(l6, r6, pe, l7, r7);
  blowfish_round_8  u_r8(l7, r7, pe, l8, r8);
  blowfish_round_9  u_r9(l8, r8, pe, l9, r9);
  blowfish_round_10 u_r10(l9, r9, pe, l10, r10);
  blowfish_round_11 u_r11(l10, r10, pe, l11, r11);
  blowfish_round_12 u_r12(l11, r11, pe, l12, r12);
  blowfish_round_13 u_r13(l12, r12, pe, l13, r13);
  blowfish_round_14 u_r14(l13, r13, pe, l14, r14);
  blowfish_round_15 u_r15(l14, r14, pe, l15, r15);
  blowfish_round_16 u_r16(l15, r15, pe, l16, r16);

  assign block_out = {r16, l16};
endmodule
