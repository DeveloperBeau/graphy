// Two chained mixing rounds with the finalisation xor.
module blake2_top(
  input  wire [511:0] h_in,
  input  wire [255:0] msg_words,
  output wire [511:0] h_out
);
  wire [511:0] v1, v2;

  blake2_mix u_round_a(h_in, msg_words, v1);
  blake2_mix u_round_b(v1, msg_words, v2);

  // Feed-forward xor finalises the state halves.
  assign h_out = h_in ^ v2 ^ {v2[255:0], v2[511:256]};
endmodule
