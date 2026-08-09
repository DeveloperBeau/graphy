module half_adder(
  input  wire a,
  input  wire b,
  output wire sum,
  output wire carry
);
  // Single-bit half adder: no carry input.
  assign sum   = a ^ b;
  assign carry = a & b;
endmodule
