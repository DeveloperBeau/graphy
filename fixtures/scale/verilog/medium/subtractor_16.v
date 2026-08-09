// a - b via two's complement addition.
module subtractor_16(
  input  wire [15:0] a,
  input  wire [15:0] b,
  output wire [15:0] diff,
  output wire        borrow
);
  wire [15:0] b_neg;
  wire        cout;

  twos_complement_16 u_neg(b, b_neg);
  ripple_adder_16    u_add(a, b_neg, 1'b0, diff, cout);

  assign borrow = ~cout & (b != 16'd0);
endmodule
