module bignum_sub(
  input  wire [255:0] a,
  input  wire [255:0] b,
  output wire [255:0] diff,
  output wire         borrow
);
  wire [256:0] wide = {1'b0, a} - {1'b0, b};

  assign diff   = wide[255:0];
  assign borrow = wide[256];

  // Conditional-subtract steps in the Montgomery loop use this.
endmodule
