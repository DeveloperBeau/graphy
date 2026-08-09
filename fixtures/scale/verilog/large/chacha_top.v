// ChaCha20 block function: init, 10 double rounds, feed-forward.
module chacha_top(
  input  wire [255:0] key,
  input  wire [95:0]  nonce,
  input  wire [31:0]  block_count,
  output wire [511:0] keystream
);
  wire [511:0] s0, d1, d2, d3, d4, d5, d6, d7, d8, d9, d10;

  chacha_state_init u_init(key, nonce, block_count, s0);
  chacha_dround_1  u_d1(s0, d1);
  chacha_dround_2  u_d2(d1, d2);
  chacha_dround_3  u_d3(d2, d3);
  chacha_dround_4  u_d4(d3, d4);
  chacha_dround_5  u_d5(d4, d5);
  chacha_dround_6  u_d6(d5, d6);
  chacha_dround_7  u_d7(d6, d7);
  chacha_dround_8  u_d8(d7, d8);
  chacha_dround_9  u_d9(d8, d9);
  chacha_dround_10 u_d10(d9, d10);

  // Feed-forward add of the initial state, wordwise.
  assign keystream = d10 + s0;
endmodule
