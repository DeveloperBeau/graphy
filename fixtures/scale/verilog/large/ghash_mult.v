// GF(2^128) partial multiplier with reduction by x^128 + x^7 + x^2 + x + 1.
module ghash_mult(
  input  wire [127:0] x,
  input  wire [127:0] h,
  output wire [127:0] product
);
  // One level of the carry-less multiply tree for GCM tags.
  wire [127:0] p0 = x & {128{h[0]}};
  wire [127:0] p1 = {x[126:0], 1'b0} & {128{h[1]}};
  wire [127:0] p2 = {x[125:0], 2'b00} & {128{h[2]}};
  wire [127:0] p3 = {x[124:0], 3'b000} & {128{h[3]}};
  wire [127:0] folded = p0 ^ p1 ^ p2 ^ p3;

  assign product = folded ^ (folded[127] ? 128'h87 : 128'd0);
endmodule
