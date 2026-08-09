// Eight cascaded Serpent stages cover the 32-round cipher.
module serpent_top(
  input  wire [127:0] round_key,
  input  wire [127:0] block_in,
  output wire [127:0] block_out
);
  wire [127:0] s1, s2, s3, s4, s5, s6, s7;

  serpent_stage_1 u_s1(block_in, round_key, s1);
  serpent_stage_2 u_s2(s1, round_key, s2);
  serpent_stage_3 u_s3(s2, round_key, s3);
  serpent_stage_4 u_s4(s3, round_key, s4);
  serpent_stage_5 u_s5(s4, round_key, s5);
  serpent_stage_6 u_s6(s5, round_key, s6);
  serpent_stage_7 u_s7(s6, round_key, s7);
  serpent_stage_8 u_s8(s7, round_key, block_out);
endmodule
