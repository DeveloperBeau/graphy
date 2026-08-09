module aes_sub_word(
  input  wire [31:0] word_in,
  output wire [31:0] word_out
);
  aes_sbox u_b3(word_in[31:24], word_out[31:24]);
  aes_sbox u_b2(word_in[23:16], word_out[23:16]);
  aes_sbox u_b1(word_in[15:8], word_out[15:8]);
  aes_sbox u_b0(word_in[7:0], word_out[7:0]);

  // Four parallel S-boxes: one 32-bit column per cycle.
endmodule
