// Maximum-distance-separable column mix over 0x169.
module tf_mds(
  input  wire [31:0] col_in,
  output wire [31:0] col_out
);
  // GF(2^8) doubling of each byte for the MDS multiply.
  wire [7:0] b0 = col_in[7:0], b1 = col_in[15:8];
  wire [7:0] b2 = col_in[23:16], b3 = col_in[31:24];
  wire [7:0] d0 = {b0[6:0], 1'b0} ^ (b0[7] ? 8'h4D : 8'h00);
  wire [7:0] d1 = {b1[6:0], 1'b0} ^ (b1[7] ? 8'h4D : 8'h00);
  wire [7:0] d2 = {b2[6:0], 1'b0} ^ (b2[7] ? 8'h4D : 8'h00);
  wire [7:0] d3 = {b3[6:0], 1'b0} ^ (b3[7] ? 8'h4D : 8'h00);

  assign col_out = {d3 ^ b0, d2 ^ b3, d1 ^ b2, d0 ^ b1};
endmodule
