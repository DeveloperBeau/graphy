module bignum_shl(
  input  wire [255:0] a,
  input  wire [7:0]   amount,
  output wire [255:0] shifted,
  output wire         spill
);
  wire [511:0] wide = {256'd0, a} << amount;

  assign shifted = wide[255:0];
  assign spill   = |wide[511:256];

  // Spill flags an overflow past the limb boundary.
endmodule
