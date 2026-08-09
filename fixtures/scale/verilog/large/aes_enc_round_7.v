// AES encryption round 7 of 10.
module aes_enc_round_7(
  input  wire [127:0] state_in,
  input  wire [127:0] round_key,
  output wire [127:0] state_out
);
  localparam ROUND = 7;
  wire [127:0] subbed, shifted;
  wire [127:0] mixed;

  aes_sub_word u_sw3(state_in[127:96], subbed[127:96]);
  aes_sub_word u_sw2(state_in[95:64], subbed[95:64]);
  aes_sub_word u_sw1(state_in[63:32], subbed[63:32]);
  aes_sub_word u_sw0(state_in[31:0], subbed[31:0]);
  shift_rows   u_sr(subbed, shifted);
  mix_columns  u_mc(shifted, mixed);
  add_round_key u_ark(mixed, round_key, state_out);
endmodule
