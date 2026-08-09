module chacha_state_init(
  input  wire [255:0] key,
  input  wire [95:0]  nonce,
  input  wire [31:0]  block_count,
  output wire [511:0] state_out
);
  // "expand 32-byte k" constants head the state matrix.
  assign state_out = {32'h6170_7865, 32'h3320_646e,
                      32'h7962_2d32, 32'h6b20_6574,
                      key, block_count, nonce};
endmodule
