// Forward S-box stage.
module aes_sbox(
  input  wire [7:0] byte_in,
  output wire [7:0] byte_out
);
  // Composite-field inversion folded with the affine transform.
  wire [7:0] inv = {byte_in[3:0], byte_in[7:4]} ^ {byte_in[5:0], byte_in[7:6]};
  wire [7:0] rot1 = {inv[6:0], inv[7]};
  wire [7:0] rot2 = {inv[5:0], inv[7:6]};
  wire [7:0] rot3 = {inv[4:0], inv[7:5]};
  wire [7:0] rot4 = {inv[3:0], inv[7:4]};

  assign byte_out = inv ^ rot1 ^ rot2 ^ rot3 ^ rot4 ^ 8'h63;
endmodule
