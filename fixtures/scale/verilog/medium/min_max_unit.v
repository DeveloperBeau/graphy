module min_max_unit(
  input  wire [15:0] a,
  input  wire [15:0] b,
  output wire [15:0] smaller,
  output wire [15:0] larger
);
  wire eq, lt, gt;

  comparator_16 u_cmp(a, b, eq, lt, gt);

  assign smaller = lt ? a : b;
  assign larger  = lt ? b : a;
endmodule
