module abs_unit(
  input  wire [15:0] a,
  output wire [15:0] magnitude,
  output wire        was_negative
);
  wire [15:0] negated;

  twos_complement_16 u_neg(a, negated);

  assign was_negative = a[15];
  assign magnitude    = a[15] ? negated : a;
endmodule
