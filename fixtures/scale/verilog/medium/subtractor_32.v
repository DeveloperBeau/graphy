module subtractor_32(
  input  wire [31:0] a,
  input  wire [31:0] b,
  output wire [31:0] diff,
  output wire        borrow
);
  wire cout;

  // Invert-and-carry-in form of two's complement subtraction.
  ripple_adder_32 u_add(a, ~b, 1'b1, diff, cout);

  assign borrow = ~cout;
endmodule
