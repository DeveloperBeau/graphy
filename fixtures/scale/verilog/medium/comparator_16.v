// 16-bit magnitude comparator from two 8-bit halves.
module comparator_16(
  input  wire [15:0] a,
  input  wire [15:0] b,
  output wire        eq,
  output wire        lt,
  output wire        gt
);
  wire eq_hi, lt_hi, gt_hi;
  wire eq_lo, lt_lo, gt_lo;

  comparator_8 u_hi(a[15:8], b[15:8], eq_hi, lt_hi, gt_hi);
  comparator_8 u_lo(a[7:0], b[7:0], eq_lo, lt_lo, gt_lo);

  assign eq = eq_hi & eq_lo;
  assign lt = lt_hi | (eq_hi & lt_lo);
  assign gt = gt_hi | (eq_hi & gt_lo);
endmodule
