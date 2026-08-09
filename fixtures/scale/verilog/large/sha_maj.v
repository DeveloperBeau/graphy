module sha_maj(
  input  wire [31:0] a,
  input  wire [31:0] b,
  input  wire [31:0] c,
  output wire [31:0] out
);
  // Majority vote of three working variables, bitwise.
  assign out = (a & b) ^ (a & c) ^ (b & c);

  // Feeds the T2 temporary each round.
endmodule
