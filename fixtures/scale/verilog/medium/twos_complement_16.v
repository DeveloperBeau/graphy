module twos_complement_16(
  input  wire [15:0] a,
  output wire [15:0] negated
);
  wire wrap;

  // Invert then add one.
  // The wrap output is unused here: negating zero never overflows.
  incrementer_16 u_inc(~a, negated, wrap);
endmodule
