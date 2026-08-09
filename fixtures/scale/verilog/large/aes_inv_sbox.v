// Decrypt-path S-box stage.
module aes_inv_sbox(
  input  wire [7:0] byte_in,
  output wire [7:0] byte_out
);
  // Inverse affine transform ahead of the shared field inversion.
  wire [7:0] a = {byte_in[6:0], byte_in[7]} ^ {byte_in[4:0], byte_in[7:5]}
               ^ {byte_in[2:0], byte_in[7:3]} ^ 8'h05;
  wire [7:0] inv = {a[3:0], a[7:4]} ^ {a[5:0], a[7:6]};

  assign byte_out = inv;
endmodule
